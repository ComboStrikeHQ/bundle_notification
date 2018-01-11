# frozen_string_literal: true

require 'bundle_notification/mailer_helper'
require 'bundle_notification/version'

module BundleNotification
  def self.configure
    @config = Config.new
    yield(@config)
    @config
  end

  def self.config
    @config ||= Config.new
  end
end
