# -*- encoding: utf-8 -*-
# stub: jekyll-katex 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-katex".freeze
  s.version = "1.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jerry Lin".freeze]
  s.date = "2019-09-26"
  s.description = "Adds a liquid tag you can use to do server-side rendering of latex math using KaTeX".freeze
  s.email = "linjer@gmail.com".freeze
  s.homepage = "https://github.com/linjer/jekyll-katex".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Jekyll plugin for easy KaTeX math server-side rendering.".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<execjs>.freeze, ["~> 2.7".freeze])
  s.add_runtime_dependency(%q<jekyll>.freeze, [">= 3.6".freeze, "< 5.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 12.3".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7".freeze])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.74.0".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16".freeze])
end