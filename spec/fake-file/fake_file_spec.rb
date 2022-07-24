# frozen_string_literal: true

RSpec.describe FakeFile do
  it "has a version number" do
    expect(FakeFile::VERSION).not_to be nil
  end

  it "returns pdf file" do
    expect(Marcel::MimeType.for(FakeFile::Document.pdf)).to eq("application/pdf")
  end

  it "returns docx file" do
    expect(Marcel::MimeType.for(FakeFile::Document.doc)).to eq("application/x-tika-ooxml")
  end
end
