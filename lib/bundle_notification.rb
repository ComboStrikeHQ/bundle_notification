# frozen_string_literal: true

require 'bundle_notification/mailer_helper'
require 'bundle_notification/version'

module BundleNotification
  def self.config
    if block_given?
      @config = Config.new
      yield(@config)
    end
    @config ||= Config.new
  end
end
