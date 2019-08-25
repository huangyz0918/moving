# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "move"
  spec.version       = "0.1.0"
  spec.authors       = ["huangyz0918"]
  spec.email         = ["huangyz0918@gmail.com"]

  spec.summary       = "A clean and minimalist theme for Jekyll"
  spec.homepage      = "https://github.com/huangyz0918/move"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(_(includes|layouts|sass)/|(LICENSE|README)((\.(txt|md|markdown)|$)))}i)
  end

  spec.add_runtime_dependency "jekyll", "~> 4.0"
  spec.add_runtime_dependency "jekyll-feed", "~> 0.9"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
end
