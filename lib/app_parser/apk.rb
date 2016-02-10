require "ruby_apk"
require "image_size"
require "app_parser/app_icon"

class AppParser::Apk
  include AppParser::AppIcon
  attr_reader :icons

  def initialize(file_name)
    @apk = Android::Apk.new(file_name)

    @icons = @apk.icon.each_with_object([]) do |(name, data), obj|
      tempfile = Tempfile.new(File.basename(name))
      tempfile.binmode
      tempfile.write(data)
      tempfile.close # closeしないと画像サイズが取れない
      size = ImageSize.path(tempfile.path).size
      obj << { dimensions: size, file_name: name }
      tempfile.unlink
    end
  end

  def os
    "android"
  end

  def version
    @apk.manifest.version_code.to_s
  end

  def version_string
    @apk.manifest.version_name
  end

  def display_name
    @apk.resource.find("@string/app_name")
  end

  def bundle_id
    @apk.manifest.package_name
  end

  def provisioned_devices
    []
  end

  def provisions_all_devices
    false
  end

  def icon_data(file_name)
    @apk.icon.find { |name, _data| name == file_name }.try(:last)
  end

  def iphone_icons
    []
  end

  def ipad_icons
    []
  end
end
