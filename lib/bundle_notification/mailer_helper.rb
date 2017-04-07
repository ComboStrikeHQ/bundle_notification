# frozen_string_literal: true
require 'active_support/concern'
require 'bundle_notification/deliver'
require 'bundle_notification/snippet_message'

module BundleNotification
  module MailerHelper
    extend ActiveSupport::Concern

    class_methods do
      def deliver_unsent_snippets
        Deliver.new(to_s).deliver_unsent_snippets
      end
    end

    def snippet(recipient, snippet_data)
      # SnippetMessage will replace Mail::Message of ActionMailer::MessageDelivery
      @_mail_was_called = true
      @_message = SnippetMessage.new(self.class.to_s, recipient, snippet_data)
    end
  end
end
