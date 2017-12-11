# Ravanello

This is the cli tool for analyze redis keys, what is very actual when you have many data in your redis.

## Installation

Just install gem to your local environment

    $ gem install ravanello

Or install it yourself as:

    $ gem install ravanello

## Usage

```bash
FETCH_LIMIT=1000 REDIS_URL='redis://localhost/mydb' ravanello --rules rules.yml
```

You need to pass rules yml file, providing information about proposal keys structure

```yml
rules:
  resque:
    - 'delayed'
    - "resque-retry"
    - "timestamps"
    - 'lock'
    - 'meta'
  denormalization:
    - 'users'
    - 'companies'
    - 'orders'
    - 'tenders'
    - 'processed_batches'
    - 'managers'
  companies:
    - 'dummy'
```

Samples of unclassified keys will be printer after analyze, and you will be able
to add them to rules file.

The FETCH_LIMIT is not required and is used for tests runs monstry (and for grouping key)
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ravanello. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ravanello project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ravanello/blob/master/CODE_OF_CONDUCT.md).
