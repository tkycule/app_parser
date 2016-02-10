require "spec_helper"

describe AppParser::Ipa do
  context "valid ipa" do
    let(:file_name) { File.dirname(__FILE__) + "/../fixtures/apps/AppParserTest.ipa" }
    subject { AppParser.parse(file_name) }
    it { expect(subject.os).to eq("ios") }
    it { expect(subject.version).to eq("1") }
    it { expect(subject.version_string).to eq("1.0") }
    it { expect(subject.display_name).to eq("AppParserTest") }
    it { expect(subject.bundle_id).to eq("com.gmail.tkycule.AppParserTest") }
    it { expect(subject.provisioned_devices).to eq(["0000000000000000000000000000000000000000"]) }
    it { expect(subject.provisions_all_devices).to be_falsey }
    it { expect(subject.icons.length).to eq(13) }
    it { expect(subject.iphone_icons.length).to eq(6) }
    it { expect(subject.ipad_icons.length).to eq(7) }
    it { expect(subject.icon(dimensions: 58)[:file_name]).to eq("AppIcon29x29@2x.png") }
    it { expect(subject.icon(dimensions: [58, 58])[:file_name]).to eq("AppIcon29x29@2x.png") }
    it { expect(subject.largest_icon[:file_name]).to eq("AppIcon60x60@3x.png") }
    it { expect(subject.smallest_icon[:file_name]).to eq("AppIcon29x29~ipad.png") }
    it { expect(subject.icon_data("AppIcon29x29@2x.png").size).not_to be_nil }
  end
end
