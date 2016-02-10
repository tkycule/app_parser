require "zip"
require "cfpropertylist"
require "active_support/core_ext/object/try"
require "pngdefry"
require "tempfile"
require "app_parser/app_icon"

class AppParser::Ipa
  include AppParser::AppIcon

  attr_reader :iphone_icons, :ipad_icons

  def initialize(file_name)
    @zip_file = Zip::File.new(file_name)
    @iphone_icons = search_icons
    @ipad_icons = search_icons(ipad: true)
  end

  def os
    "ios"
  end

  def version
    info_plist["CFBundleVersion"]
  end

  def version_string
    info_plist["CFBundleShortVersionString"]
  end

  def display_name
    info_plist["CFBundleDisplayName"] || info_plist["CFBundleName"]
  end

  def bundle_id
    info_plist["CFBundleIdentifier"]
  end

  def provisioned_devices
    mobileprovision["ProvisionedDevices"]
  end

  # true if In-House
  def provisions_all_devices
    mobileprovision["ProvisionsAllDevices"] || false
  end

  def icons
    @iphone_icons + @ipad_icons
  end

  def icon_data(file_name)
    Dir.mktmpdir do |tmp_dir|
      src_file = "#{tmp_dir}/src"
      dest_file = "#{tmp_dir}/dest"
      find_entry(file_name).extract(src_file)
      Pngdefry.defry(src_file, dest_file)
      File.binread(dest_file)
    end
  end

  def info_plist
    @info_plist ||= CFPropertyList.native_types(
      CFPropertyList::List.new(data: read_file("Info.plist"), format: CFPropertyList::List::FORMAT_AUTO).value
    )
  end

  def mobileprovision
    @mobileprovision ||= CFPropertyList.native_types(
      CFPropertyList::List.new(data: read_file("embedded.mobileprovision").match(%r{<\?xml.*</plist>}m)[0], format: CFPropertyList::List::FORMAT_AUTO).value
    )
  end

  private

  def find_entries(path)
    @zip_file.glob("Payload/*.app/#{path}")
  end

  def find_entry(path)
    find_entries(path).first
  end

  def read_file(path)
    entry = find_entry(path)
    entry.get_input_stream.read unless entry.nil?
  end

  def search_icons(ipad: false)
    Dir.mktmpdir do |tmp_dir|
      info_plist.try(:[], "CFBundleIcons#{'~ipad' if ipad}").try(:[], "CFBundlePrimaryIcon").try(:[], "CFBundleIconFiles").each_with_object([]) do |icons, obj|
        find_entries(icons + "*").find_all { |entry| entry.name.index("~ipad").nil? != ipad }.each do |entry|
          tmp_file_name = "#{tmp_dir}/#{File.basename(entry.name)}"
          entry.extract(tmp_file_name)

          obj << { dimensions: Pngdefry.dimensions(tmp_file_name), file_name: File.basename(entry.name) }
        end
      end
    end
  end
end
