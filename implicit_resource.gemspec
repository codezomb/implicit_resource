# frozen_string_literal: true

require_relative "lib/implicit_resource/version"

Gem::Specification.new do |spec|
  spec.name        = "implicit_resource"
  spec.version     = ImplicitResource::VERSION
  spec.authors     = ["Mike Kelley"]
  spec.email       = ["mike@codezombie.org"]
  spec.homepage    = "https://github.com/codezomb/implicit_resource"
  spec.summary     = "ImplicitResource"
  spec.description = "Rails Controller Boilerplate"
  spec.license     = "MIT"

  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["homepage_uri"]    = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "responders", "~> 3"
  spec.add_dependency "has_scope",  "~> 0"
  spec.add_dependency "rails",      "~> 7"
end
