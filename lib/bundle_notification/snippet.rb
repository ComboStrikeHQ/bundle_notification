# frozen_string_literal: true
require 'active_record/base'

module BundleNotification
  class Snippet < ActiveRecord::Base
    self.table_name = 'bundle_notification_snippets'

    serialize :data

    scope :unsent_for, ->(mailer_class) { where(mailer_class: mailer_class, sent_at: nil) }
  end
end
