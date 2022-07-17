# frozen_string_literal: true

RSpec.describe FakeFile do
  it "has a version number" do
    expect(FakeFile::VERSION).not_to be nil
  end

  it "returns docx file" do
    expect(FakeFile::Document.generate.class).to eq(Tempfile)
  end
end
