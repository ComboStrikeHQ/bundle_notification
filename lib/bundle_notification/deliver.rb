# frozen_string_literal: true
require 'bundle_notification/snippet'

module BundleNotification
  class Deliver
    attr_reader :mailer_class

    def initialize(mailer_class)
      @mailer_class = mailer_class
    end

    def deliver_unsent_snippets
      Snippet.transaction do
        return if unsent_snippets.empty?
        unsent_snippets.group_by(&:recipient).each do |recipient, snippets|
          bundle_notify(recipient, snippets.map(&:data)).deliver_later
        end
        mark_snippets_sent
      end
    end

    private

    def bundle_notify(bundle_data, snippets_data)
      mailer_class.constantize.bundle_notify(bundle_data, snippets_data)
    end

    def unsent_snippets
      @unsent_snippets ||= Snippet.unsent_for(mailer_class).order(:created_at, :id).lock.to_a
    end

    def mark_snippets_sent
      Snippet.where(id: unsent_snippets).update_all(sent_at: Time.zone.now)
      @unsent_snippets = nil
    end
  end
end
