# BundleNotification

BundleNotification bundles many ActionMailer messages for the same recipient into a single email

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bundle_notification'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bundle_notification
    
    
Create bundle_notification_snippets table:

    $ rails g migration CreateBundleNotificationSnippets mailer_class:string:index recipient:string data:text sent_at:datetime 
    $ rake db:migrate

## Usage

1. Include `BundleNotification::MailerHelper` to a mailer class.
2. Create any method you want and call `snippet` in the end passing the recipient email and any extra data you want.
3. Implement `bundle_notify` method which receives a recipient_email and an array of data
4. Call your method implemented in step 2 chained with `deliver_later` as you would do with a normal mailer method.
5. Call `deliver_unsent_snippets` for your mailer

Example: 

```ruby
class MyMailer < ActionMailer::Base
  include BundleNotification::MailerHelper #1
  
  def message(recipient_email, snippet_data)
    snippet(recipient_email, snippet_data) #2
  end
  
  def bundle_notify(recipient_email, snippets_data) #3
    @snippets_data = snippets_data
    mail(to: recipient_email)
  end
end

MyMailer.message('recipient_1@example.com', 'message 1').deliver_later #4
MyMailer.message('recipient_1@example.com', 'message 2').deliver_later
MyMailer.message('recipient_2@example.com', 'message 3').deliver_later

MyMailer.deliver_unsent_snippets #5
```

This will send 2 emails: One to <recipient_1@example.com> with `['message 1', 'message 2']` and another to <recipient_2@example.com> with `['message 3']` 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ad2games/bundle_notification.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

