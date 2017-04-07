# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundle_notification/version'

Gem::Specification.new do |spec|
  spec.name          = 'bundle_notification'
  spec.version       = BundleNotification::VERSION
  spec.authors       = ['ad2games GmbH']
  spec.email         = ['developers@ad2games.com']

  spec.summary       = 'Bundle ActionMailer notifications'
  spec.description   = 'Bundle many ActionMailer messages for the same recipient into a single email'
  spec.homepage      = "http://ad2games.com"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'actionmailer', '>= 4.0', '< 5.2'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'factory_girl'

  spec.add_dependency 'activerecord', '>= 4.0', '< 5.2'
  spec.add_dependency 'activesupport', '>= 4.0', '< 5.2'
end
