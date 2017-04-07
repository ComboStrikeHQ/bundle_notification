require 'bundler/setup'
require 'bundle_notification'
require 'support/database'
require 'support/factory_girl'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
