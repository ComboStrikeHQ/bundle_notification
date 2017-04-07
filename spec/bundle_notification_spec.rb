# frozen_string_literal: true
require 'spec_helper'

RSpec.describe BundleNotification do
  it 'has a version number' do
    expect(BundleNotification::VERSION).not_to be nil
  end
end
