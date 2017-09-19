# Clarification - DO NOT INSTALL - IN DEVELOPMENT

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/clarification`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clarification'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clarification

## Configuration

Configure the gem as you would normally.

```
  Clarification.configure do |config|
    config.api_key = 'a_big_secret_you_got_from_clarifai'
    config.end_points = [:food]
  end
```

This should also work nicely inside a rails initializer.

## Usage

You

client = Clarification::Client.new(:faces, :food)
response = client.analyze(some_public_url)

Each endpoint initialized will be called.  So this analyze action will call two separate API routes and will count as two uses of your key.

```
response[:faces].face_count 
# => 3
response[:food].concepts.first
# => { concept_name: "cake",
       confidence: .89 }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/clarification. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Clarification project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/clarification/blob/master/CODE_OF_CONDUCT.md).
