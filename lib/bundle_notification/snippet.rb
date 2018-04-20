# frozen_string_literal: true

require 'active_record'
require 'bundle_notification/serializer'

module BundleNotification
  class Snippet < ActiveRecord::Base
    self.table_name = 'bundle_notification_snippets'

    serialize :data, Serializer

    validates :recipient, presence: true

    scope :unsent_for, ->(mailer_class) { where(mailer_class: mailer_class, sent_at: nil) }
  end
end
