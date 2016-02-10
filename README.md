# AppParser

Analysis tool for iOS ipa and Android apk.

## Installation

    $ gem install app_parser

## USAGE

### iOS ipa

    irb > require "app_parser"
    => true

    irb > ipa = AppParser.parse("/path/to/file.ipa")
    irb > ipa.class
    => AppParser::Ipa

    irb > ipa.os
    => "ios"

    irb > ipa.version # CFBundleVersion
    => "1"

    irb> ipa.version_string # CFBundleShortVersionString
    => "1.0"

    irb > ipa.display_name # CFBundleShortVersionString or CFBundleName
    => "AppParserTest"

    irb > ipa.bundle_id # CFBundleIdentifier
    => "com.gmail.tkycule.AppParserTest"

    irb > ipa.provisioned_devices # ProvisionedDevices
    => ["0000000000000000000000000000000000000000"]

    irb > ipa.provisions_all_devices # ProvisionsAllDevices (true if In-House)
    => false

    irb > ipa.icons
    => [{:dimensions=>[58, 58], :file_name=>"AppIcon29x29@2x.png"}, ...]

    irb > ipa.iphone_icons
    => [{:dimensions=>[58, 58], :file_name=>"AppIcon29x29@2x.png"}, ...]

    irb > ipa.ipad_icons
    => [{:dimensions=>[58, 58], :file_name=>"AppIcon29x29@2x~ipad.png"}, ...]

    irb > ipa.icon(dimensions: 58)
    => {:dimensions=>[58, 58], :file_name=>"AppIcon29x29@2x.png"}

    irb > ipa.icon(dimensions: [58, 58])
    => {:dimensions=>[58, 58], :file_name=>"AppIcon29x29@2x.png"}

    irb > ipa.largest_icon
    => {:dimensions=>[180, 180], :file_name=>"AppIcon60x60@3x.png"}

    irb > ipa.smallest_icon
    => {:dimensions=>[29, 29], :file_name=>"AppIcon29x29~ipad.png"}

    irb(main):031:0> ipa.icon_data("AppIcon29x29@2x.png")
    => "\x89PNG\r\n ..."

### Android apk

    irb > require "app_parser"
    => true

    irb > apk = AppParser.parse("/path/to/file.apk")
    irb > apk.class
    => AppParser::Apk

    irb > apk.version # versionCode
    => "1"

    irb > apk.version_string # versionName
    => "1.0"

    irb > apk.display_name # app_name
    => "AppParserTest"

    irb > apk.bundle_id # package name
    => "com.gmail.tkycule.AppParserTest"

    irb > apk.provisioned_devices # always blank
    => []

    irb > apk.provisions_all_devices # always false
    => false

    irb > apk.icons
    => [{:dimensions=>[48, 48], :file_name=>"res/mipmap-mdpi-v4/ic_launcher.png"}, ...]

    irb > apk.iphone_icons # always blank
    => []

    irb > apk.ipad_icons # always blank
    => []

    irb > apk.icon(dimensions: 48)
    => {:dimensions=>[48, 48], :file_name=>"res/mipmap-mdpi-v4/ic_launcher.png"}

    irb > apk.icon(dimensions: [48, 48])
    => {:dimensions=>[48, 48], :file_name=>"res/mipmap-mdpi-v4/ic_launcher.png"}

    irb > apk.largest_icon
    => {:dimensions=>[192, 192], :file_name=>"res/mipmap-xxxhdpi-v4/ic_launcher.png"}

    irb > apk.smallest_icon
    => {:dimensions=>[48, 48], :file_name=>"res/mipmap-mdpi-v4/ic_launcher.png"}

    irb > apk.icon_data("res/mipmap-mdpi-v4/ic_launcher.png")
    => "\x89PNG\r\n ..."

## Author

[tkycule](https://github.com/tkycule)

## Licence

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
