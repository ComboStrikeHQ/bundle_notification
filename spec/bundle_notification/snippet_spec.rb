# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BundleNotification::Snippet do
  it 'serializes and de-serializes the `data` attribute' do
    create(:snippet, data: { foo: 'bar' })
    expect(described_class.last.data).to eq(foo: 'bar')
  end

  it 'uses the configured serializer' do
    BundleNotification.configure do |config|
      config.serializer = JSON
    end

    create(:snippet, data: { foo: 'bar' })
    expect(described_class.last.data).to eq('foo' => 'bar')
    expect(described_class.last.read_attribute_before_type_cast(:data)).to eq('{"foo":"bar"}')
  end

  it 'serializes nil values' do
    create(:snippet, data: nil)
    expect(described_class.last.read_attribute_before_type_cast(:data)).to eq(nil)
    expect(described_class.last.data).to eq(nil)
  end

  it 'serializes empty values' do
    create(:snippet, data: {})
    expect(described_class.last.read_attribute_before_type_cast(:data)).to eq("--- {}\n")
    expect(described_class.last.data).to eq({})
  end

  it 'validates presence of the recipient' do
    snippet = build(:snippet, recipient: nil)
    expect(snippet).not_to be_valid
    expect(snippet.errors.full_messages).to include("Recipient can't be blank")
  end
end
