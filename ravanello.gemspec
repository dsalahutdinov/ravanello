
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ravanello/version"

Gem::Specification.new do |spec|
  spec.name          = "ravanello"
  spec.version       = Ravanello::VERSION
  spec.authors       = ["Salahutdinov Dmitry"]
  spec.email         = ["dsalahutdinov@gmail.com"]

  spec.summary       = %q{Ravanello gem}
  spec.description   = %q{Ravanello gem}
  spec.homepage      = "https://github.com/dsalahutdinov/ravanello"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

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
