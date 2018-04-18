# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :bundle_notification_snippets, force: true do |t|
    t.string :mailer_class
    t.string :recipient
    t.text :data
    t.datetime :sent_at
    t.datetime :created_at
  end
  add_index :bundle_notification_snippets, :mailer_class
end
