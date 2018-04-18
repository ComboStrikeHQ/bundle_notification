# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BundleNotification::Snippet do
  it 'serializes and de-serializes the `data` attribute' do
    described_class.create!(data: { foo: 'bar' })
    expect(described_class.last.data).to eq(foo: 'bar')
  end

  it 'uses the configured serializer' do
    BundleNotification.configure do |config|
      config.serializer = JSON
    end

    described_class.create!(data: { foo: 'bar' })
    expect(described_class.last.data).to eq('foo' => 'bar')
    expect(described_class.last.read_attribute_before_type_cast(:data)).to eq('{"foo":"bar"}')
  end

  it 'serializes nil values' do
    described_class.create!(data: nil)
    expect(described_class.last.read_attribute_before_type_cast(:data)).to eq(nil)
    expect(described_class.last.data).to eq(nil)
  end

  it 'serializes empty values' do
    described_class.create!(data: {})
    expect(described_class.last.read_attribute_before_type_cast(:data)).to eq("--- {}\n")
    expect(described_class.last.data).to eq({})
  end
end
