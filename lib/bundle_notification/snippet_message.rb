# frozen_string_literal: true

require 'bundle_notification/snippet'

module BundleNotification
  class SnippetMessage
    attr_reader :mailer_class, :recipient, :snippet_data

    def initialize(mailer_class, recipient, snippet_data)
      @mailer_class = mailer_class
      @recipient = recipient
      @snippet_data = snippet_data
    end

    def deliver
      Snippet.create!(
        mailer_class: mailer_class,
        recipient: recipient,
        data: snippet_data
      )
    end
  end
end
