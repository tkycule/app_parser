require "spec_helper"

describe AppParser do
  it "has a version number" do
    expect(AppParser::VERSION).not_to be nil
  end

  describe ".detect_os" do
    {
      "sample.ipa" => "ios",
      "sample.IPA" => "ios",
      "sample.apk" => "android",
      "sample.APK" => "android",
      "sample.txt" => nil,
      nil => nil
    }.each do |file_name, os|
      context "file_name is #{file_name || 'nil'}" do
        let(:file_name) { filename }
        subject { AppParser.detect_os(file_name) }
        it { expect(subject).to eq(os) }
      end
    end
  end

  describe ".parse" do
    context "ipa file" do
      let(:file_name) { File.dirname(__FILE__) + "/fixtures/apps/AppParserTest.ipa" }
      subject { AppParser.parse(file_name) }
      it { expect(subject).to be_a(AppParser::Ipa) }
    end

    context "apk file" do
      let(:file_name) { File.dirname(__FILE__) + "/fixtures/apps/AppParserTest.apk" }
      subject { AppParser.parse(file_name) }
      it { expect(subject).to be_a(AppParser::Apk) }
    end

    context "no file" do
      let(:file_name) { "no_file.ipa" }
      it { expect { AppParser.parse(file_name) }.to raise_error(AppParser::NotFoundError, file_name) }
    end

    context "not App file" do
      let(:file_name) { File.dirname(__FILE__) + "/fixtures/apps/not_app.txt" }
      it { expect { AppParser.parse(file_name) }.to raise_error(AppParser::NotAppError, file_name) }
    end
  end
end
