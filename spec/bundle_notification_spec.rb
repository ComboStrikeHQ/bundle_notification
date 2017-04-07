require "spec_helper"

RSpec.describe BundleNotification do
  it "has a version number" do
    expect(BundleNotification::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
