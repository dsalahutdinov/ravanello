
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ravanello/version"

Gem::Specification.new do |spec|
  spec.name          = "ravanello"
  spec.version       = Ravanello::VERSION
  spec.authors       = ["Salahutdinov Dmitry"]
  spec.email         = ["dsalahutdinov@gmail.com"]

  spec.summary       = %q{Ravanello is the cli for analyzing redis keys (using debug)}
  spec.description   = %{
    Ravanello is the cli for analyze keys in redis and size of it's values.

    Example of usage:
    ```bash
      gem install ravanello
      ravanello --version
      REDIS_URL="redis://localhost/db" ravanello analyze --rules rules.yml
    ```

    The rules files specifies the structure of the redis keys (splitted by :)
    and should looks like this:
    ```yml
    rules:
      resque:
        - 'delayed'
        - 'resque-retry'
        - 'timestamps'
        - 'lock'
        - 'meta'
    ```

    After analyzing you will get the report in console:
    ```
    Q-ty  Size  Key (sample)
    4     24    * (hello)
    1     6     denormalized:companies:* (denormalized:companies:99585213)
    ```

  }
  spec.homepage      = "https://github.com/dsalahutdinov/ravanello"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ['ravanello']
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redis"
  spec.add_runtime_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rubocop", "~> 0.49"
  spec.add_development_dependency "simplecov"
end
