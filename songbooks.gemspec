# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'songbooks/version'

Gem::Specification.new do |spec|
  spec.name          = 'songbooks'
  spec.version       = Songbooks::VERSION
  spec.authors       = ['Stefan Exner']
  spec.email         = ['stex@sterex.de']

  spec.summary       = 'Chords songbook generator + viewer'
  spec.description   = 'Chordfile (Lyrics + Chords) display and PDF generation using Sinatra and Prawn'
  spec.homepage      = 'https://www.github.com/stex/songbooks'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|bin)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.2'

  # Template rendering
  spec.add_dependency 'haml', '~> 4.0'
  spec.add_dependency 'tilt-jbuilder', '~> 0.7'

  # Server
  spec.add_dependency 'sinatra', '~> 1.4'
  spec.add_dependency 'thin', '~> 1.7'

  # The usual convenience we are used from Rails projects
  spec.add_dependency 'activesupport', '~> 5.0'

  # PDF rendering
  spec.add_dependency 'prawn', '~> 2.1'
  spec.add_dependency 'dberkom-sinatra-prawn', '~> 0.9'

  # CLI
  spec.add_dependency 'thor', '~> 0.19'

  # File watchers
  spec.add_dependency 'listen', '~> 3.1'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sass', '~> 3.4'
  spec.add_development_dependency 'coffee', '~> 0.0'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-coffeescript', '~> 2.0'
  spec.add_development_dependency 'guard-sass', '~> 1.6'
  spec.add_development_dependency 'byebug', '~> 9'
end
