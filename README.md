[![Gem Version](https://badge.fury.io/rb/clarification.svg)](https://badge.fury.io/rb/clarification)
[![Build Status](https://travis-ci.org/nicholalexander/clarification.svg?branch=master)](https://travis-ci.org/nicholalexander/clarification)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/cb0dd6cce7ec48a191696780951c5efe)](https://www.codacy.com/app/nicholalexander/clarification?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nicholalexander/clarification&amp;utm_campaign=Badge_Grade)


# Clarification

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
    config.end_points = [:food, :general]
  end
```

This should also work nicely inside a rails initializer.

Each endpoint initialized in your configuration will be called.  _So any predictions using a client configured with :food and :general will make two API requests._

## Usage

```
client = Clarification::Client.new
response = client.predict(some_public_url_of_an_image)
```

### Prediction

The response object returned from the prediction is a hash containing a nicely parsed result for each of the models called.  In our example, we initialized with two models so we will have response[:food] and response[:general].  Each of those model results have an object which has three pieces of relevant information: status, concepts, and response_json.  

Thusly you can do things like this:

```
response[:food].concepts.each do |concept|
  if concept.value > 0.90
    puts "#{concept.name}"
  end
end
```

```
response[:general].response_json
```

```
if response[:food].status.code == 10000
  puts response[:food].status.description
end
```

All the objects are OpenStructs currently, but I suspect this will change shortly.

As a convenience, the client also maintains the parsed response in the last_response variable.

```
client.predict(some_public_url_of_an_image)
client.last_response #=> {:food => Objectifier...}
```

## TODO's

Lots and lots of things.  Amongst them:

* validate public model selections
* error handling
* predict multiple images per call
* predict video
* use workflows
* searching
* training custom models

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nicholalexander/clarification. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

https://codeclimate.com/github/nicholalexander/clarification
https://www.codacy.com/app/nicholalexander/clarification


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Clarification project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nicholalexander/clarification/blob/master/CODE_OF_CONDUCT.md).
