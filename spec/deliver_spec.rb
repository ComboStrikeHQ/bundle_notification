# frozen_string_literal: true
require 'spec_helper'
require 'action_mailer'

RSpec.describe BundleNotification::Deliver do
  subject(:deliver) { described_class.new('TestMailer') }
  TestMailer = Class.new

  describe '#deliver_unsent_snippets' do
    let(:message_delivery_double) { instance_double(ActionMailer::MessageDelivery) }
    before do
      allow(message_delivery_double).to receive(:deliver_later)
      allow(TestMailer).to receive(:bundle_notify).and_return(message_delivery_double)
    end

    context 'no snippets enqueued' do
      it 'does nothing' do
        deliver.deliver_unsent_snippets
        expect(TestMailer).not_to have_received(:bundle_notify)
      end
    end

    context 'snippets of different mailer' do
      before do
        create(:snippet, mailer_class: 'AnotherMailer')
      end

      it 'does nothing' do
        deliver.deliver_unsent_snippets
        expect(TestMailer).not_to have_received(:bundle_notify)
      end
    end

    context 'multiple snippets for same mailer and recipient' do
      before do
        create(:snippet, mailer_class: 'TestMailer', recipient: 'recipient', data: { foo: 'bar' })
        create(:snippet, mailer_class: 'TestMailer', recipient: 'recipient', data: 'fizz')
      end

      it 'deliveries one notification, with array of snippets arbitrary data in order' do
        deliver.deliver_unsent_snippets
        deliver.deliver_unsent_snippets # second call should have no effect
        expect(TestMailer).to have_received(:bundle_notify).with(
          'recipient', [{ foo: 'bar' }, 'fizz']
        ).once
        expect(message_delivery_double).to have_received(:deliver_later).once
      end
    end

    context 'multiple snippets for same mailer but different recipients' do
      before do
        create(:snippet, mailer_class: 'TestMailer', recipient: 'recipient_1', data: 'a')
        create(:snippet, mailer_class: 'TestMailer', recipient: 'recipient_1', data: 'b')
        create(:snippet, mailer_class: 'TestMailer', recipient: 'recipient_2', data: 'c')
      end

      it 'deliveries one notification for each recipient' do
        deliver.deliver_unsent_snippets
        expect(TestMailer).to have_received(:bundle_notify).with('recipient_1', %w(a b)).once
        expect(TestMailer).to have_received(:bundle_notify).with('recipient_2', %w(c)).once
        expect(message_delivery_double).to have_received(:deliver_later).twice
      end
    end
  end
end
