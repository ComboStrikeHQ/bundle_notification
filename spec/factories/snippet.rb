# frozen_string_literal: true

FactoryGirl.define do
  factory :snippet, class: BundleNotification::Snippet do
    mailer_class 'TestMailer'
    recipient 'recipient@example.com'
  end
end
