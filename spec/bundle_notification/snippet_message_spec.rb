# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BundleNotification::SnippetMessage do
  subject(:snippet_delivery) do
    described_class.new(
      'TestMailer',
      'recipient@example.com',
      foo: 'bar'
    )
  end

  describe '#deliver' do
    it 'creates NotificationSnippet in DB and doesnt send any mailer' do
      expect { snippet_delivery.deliver }.to change { BundleNotification::Snippet.count }.by(1)

      expect(BundleNotification::Snippet.last.attributes).to include(
        'mailer_class' => 'TestMailer',
        'recipient' => 'recipient@example.com',
        'data' => { foo: 'bar' },
        'sent_at' => nil
      )

      expect(ActionMailer::Base.deliveries.size).to eq(0)
    end
  end
end
