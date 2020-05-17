require_relative 'lib/trail_finder/version'

Gem::Specification.new do |spec|
  spec.name          = "trail_finder"
  spec.version       = TrailFinder::VERSION
  spec.authors       = ["satodd1967"]
  spec.email         = ["seth.todd@outlook.com"]

  spec.summary       = %q{gets mountain bike trails}
  # spec.description   = %q{Allows a user to find mountain bike trails surrounding any major US city}
  # spec.homepage      = "https://github.com/satodd1967/trail_finder"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/satodd1967/trail_finder"
  spec.metadata["changelog_uri"] = "https://github.com/satodd1967/trail_finder."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_dependency "json"
  spec.add_dependency "dotenv"

end
