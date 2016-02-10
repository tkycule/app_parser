require "app_parser/version"
require "app_parser/ipa"
require "app_parser/apk"

module AppParser
  class NotFoundError < StandardError; end
  class NotAppError < StandardError; end

  def self.parse(file_name)
    fail NotFoundError, file_name unless File.exist?(file_name)

    case detect_os(file_name)
    when "ios"
      AppParser::Ipa.new(file_name)
    when "android"
      AppParser::Apk.new(file_name)
    else
      fail NotAppError, file_name
    end
  end

  def self.detect_os(file_name)
    case File.extname(file_name.to_s).downcase
    when ".ipa"
      "ios"
    when ".apk"
      "android"
    end
  end
end
