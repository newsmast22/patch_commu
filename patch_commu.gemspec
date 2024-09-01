# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)
require_relative "lib/patch_commu/version"

Gem::Specification.new do |spec|
  spec.name = "patch_commu"
  spec.version = PatchCommu::VERSION
  spec.authors = ["minmaung132h"]
  spec.email = ["minmaung132h@prestigein.com"]

  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/newsmast22/patch_commu"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://github.com/newsmast22/patch_commu"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/newsmast22/patch_commu"
  spec.metadata["changelog_uri"] = "https://github.com/newsmast22/patch_commu"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
 
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '~> 7.1.1'
  spec.add_dependency 'byebug'
  spec.add_dependency 'strong_migrations'
  spec.add_dependency 'activestorage', '~> 7.0'
  spec.add_dependency 'react-rails'
end
