require "spec_helper"

describe AppParser::Apk do
  context "valid apk" do
    let(:file_name) { File.dirname(__FILE__) + "/../fixtures/apps/AppParserTest.apk" }
    subject { AppParser.parse(file_name) }
    it do
      expect(subject.os).to eq("android")
      expect(subject.version).to eq("1")
      expect(subject.version_string).to eq("1.0")
      expect(subject.display_name).to eq("AppParserTest")
      expect(subject.bundle_id).to eq("com.gmail.tkycule.AppParserTest")
      expect(subject.provisioned_devices).to eq([])
      expect(subject.provisions_all_devices).to be_falsey
      expect(subject.icons.length).to eq(5)
      expect(subject.iphone_icons.length).to eq(0)
      expect(subject.ipad_icons.length).to eq(0)
      expect(subject.icon(dimensions: 48)[:file_name]).to eq("res/mipmap-mdpi-v4/ic_launcher.png")
      expect(subject.icon(dimensions: [48, 48])[:file_name]).to eq("res/mipmap-mdpi-v4/ic_launcher.png")
      expect(subject.largest_icon[:file_name]).to eq("res/mipmap-xxxhdpi-v4/ic_launcher.png")
      expect(subject.smallest_icon[:file_name]).to eq("res/mipmap-mdpi-v4/ic_launcher.png")
      expect(subject.icon_data("res/mipmap-mdpi-v4/ic_launcher.png").size).not_to be_nil
    end
  end
end
