# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundle_notification/version'
Gem::Specification.new do |spec|
  spec.name        = 'bundle_notification'
  spec.version     = BundleNotification::VERSION
  spec.required_ruby_version = '>= 3.0'
  spec.authors     = ['combostrike GmbH']
  spec.email       = ['developers@combostrike.com']

  spec.summary     = 'Bundle ActionMailer notifications'
  spec.description = 'Bundle many ActionMailer messages for the same recipient into a single email'
  spec.homepage    = 'http://combostrike.com'
  spec.license     = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'actionmailer', '~> 6.1.4'
  spec.add_development_dependency 'bundler', '~> 2.2.22'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3', '~> 1.4'

  spec.add_dependency 'activerecord', '~> 6.1.4'
  spec.add_dependency 'activesupport', '~> 6.1.4'
end
# rubocop:enable Metrics/BlockLength
