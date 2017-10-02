[![Gem Version](https://badge.fury.io/rb/clarification.svg)](https://badge.fury.io/rb/clarification)
[![Build Status](https://travis-ci.org/nicholalexander/clarification.svg?branch=master)](https://travis-ci.org/nicholalexander/clarification)
[![Test Coverage](https://codeclimate.com/github/nicholalexander/clarification/badges/coverage.svg)](https://codeclimate.com/github/nicholalexander/clarification/coverage)
[![Code Climate](https://codeclimate.com/github/nicholalexander/clarification/badges/gpa.svg)](https://codeclimate.com/github/nicholalexander/clarification)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/cb0dd6cce7ec48a191696780951c5efe)](https://www.codacy.com/app/nicholalexander/clarification?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=nicholalexander/clarification&amp;utm_campaign=Badge_Grade)

# Clarification

An unofficial Ruby wrapper for the [Clarifai](http://clarifai.com) API.  This currently uses v2 of the API and was partially created because other Ruby gems are using v1 which is being depricated in late 2017.

Clarifai is an awesome service and hopefully this gem makes it easier to use it and to use AI image tagging in your Ruby apps.  Please let me know if there's something you'd like to see but don't or if you see something you wish you didn't.  Thanks!

This gem is currently in development and there is lots likely to change so please be aware!

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

Configure the gem as you would normally configure a wonderful happy gem.

```ruby
  Clarification.configure do |config|
    config.api_key = 'a_big_secret_you_got_from_clarifai'
    config.default_public_models = [:food, :general]
  end
```

This should also work nicely inside a rails initializer.

**Each endpoint initialized in your configuration will be called by default from the client.  So any predictions using a client configured with `:food` and `:general` will make two API requests.**

**When [Workflow](https://clarifai.com/developer/guide/workflow#workflow) is implemented in the gem, you will be able to call against your workflow instead of the public models.**

You can also configure the client on the fly with  `client.set_active_models_by_public_key([:food, :general])`, `client.set_active_models_from_hash({food: 'fasldfsadflkjasdf'})` (useful for custom models) or `client.set_active_models(model)` where model is a Clarification::Model.  See more in Training.

## Basic Usage

```ruby
client = Clarification::Client.new
response = client.predict.by_url(some_public_url_of_an_image)
```

### Prediction

The response object returned from the prediction is a hash containing a nicely parsed result for each of the models called.  In the above configuration example we have two models.  So we will have response[:food] and response[:general] after asking for a prediction.  Each of those model results have an object which has three pieces of relevant information: status, concepts, and response_json.

Thusly you can do things like this:

```ruby
response[:food].concepts.each do |concept|
  if concept.value > 0.90
    puts "#{concept.name}"
  end
end
```

```ruby
if response[:food].status.code == 10000
  puts response[:food].status.description
end
```

If you want the actual api response, it's here:

```ruby
response[:general].response_json
```

All the objects are OpenStructs currently, but I suspect this will change shortly.

As a convenience, the client also maintains the parsed response in the last_response variable.

```ruby
client.predict.by_url(some_public_url_of_an_image)
client.predict.last_response #=> {:food => Objectifier...}
```

### Search

The client has a search object which can be used to index images with the Clarifai application identified by the API key.  

Thusly you can do like this:

```ruby
image_array = [ url_to_picture_of_kitten, url_to_picture_of_pizza, url_to_picture_of_drake]
client.search.index_images(image_array)
```

Once you have your images indexed, you can go and search them by concepts that might be in your pictures as identified by Clarifai's general prediction model.

```ruby
results = client.search.by_concept('cat')
results.hits.each do |hit|
  puts hit.url if hit.score > .90
end
```

The search client also saves the last search and searched concept as a matter of convenience.

```ruby
client.search.last_search.hits.count
client.search.last_search.concept
```

Go and do likewise.

### Train

There are three steps to setting up a custom model:

* Add images with concepts.  
* Create a model with the same concepts that you've associated with images.
* Train said model.

These three steps can be accomplished thusly:

```ruby
cat_related_concepts = ["cat", "feline", "superior"]
client.train.add_image(some_url_of_a_cat, cat_related_concepts)
model = client.train.create_model('cat', cat_related_concepts)
client.train.train_model(model)
```

Now that you have the model created and trained, you should be able to predict against it.  Though you may need to wait for Clarifai to finish the model training.

```ruby
client.set_active_models([model])
client.predict.by_url(some_public_url)
```

Walla, as they say in France.

## TODO's

Lots and lots of things.  Amongst them:

* error handling
* predict multiple images per call
* predict video
* better testing
* documentation
* use workflows

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

The repo intentionally includes an api key in bin/console to make experimenting easy and quick.  If you plan on making a bunch of requests, you can easily sign up for [your own free key](https://clarifai.com/signup/).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nicholalexander/clarification. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

You can also see various code reporting / CI info here:  
[travis ci](https://travis-ci.org/nicholalexander/clarification)  
[codacy](https://www.codacy.com/app/nicholalexander/clarification)  
[code climate](https://codeclimate.com/github/nicholalexander/clarification)   

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Clarification project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nicholalexander/clarification/blob/master/CODE_OF_CONDUCT.md).
