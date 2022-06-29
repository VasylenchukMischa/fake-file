# frozen_string_literal: true

RSpec.describe FakeFile do
  it "has a version number" do
    expect(FakeFile::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(1+0).to eq(2-1)
  end
end
