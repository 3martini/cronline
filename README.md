# CronLine

Code goes in `lib/cronline`. To experiment with that code, run `bin/console` for an interactive prompt.

Converts a cron expression into a series of instants in time. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cronline'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cronline

## Usage

Create a simulator. You don't have to provide any parameters but you can optionally override them using the builder. Default timezone is the local time for the system.

    sim = Cronline::Simulator.builder
      .set_duration(2.weeks)
      .set_timezone('Eastern Time (US & Canada)')
      .build
    times = sim.simulate_cron('0 30 7 ? * MON,WED *')

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cronline/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
