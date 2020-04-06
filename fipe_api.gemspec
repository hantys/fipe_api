# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fipe_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'fipe_api'
  spec.version       = FipeApi::VERSION
  spec.authors       = ['Caio Teixeira']
  spec.email         = ['caiofct@gmail.com']

  spec.summary       = 'A ruby client to consume Tabela Fipe api data - https://veiculos.fipe.org.br/'
  spec.description   = 'This application is a ruby client to the Tabela Fipe Api - https://veiculos.fipe.org.br/. It makes use of the excellent http gem to make http requests and nokogiri to parse the responses.'
  spec.homepage      = 'https://github.com/caiofct/fipe_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 1.9'
  spec.add_development_dependency 'byebug', '>= 11.1.1'
  spec.add_development_dependency 'rake', '>= 13.0'
  spec.add_development_dependency 'rspec', '~> 3.3'

  spec.add_dependency 'http', '~> 2.2.2'
  spec.add_dependency 'nokogiri', '~> 1.10'

  spec.required_ruby_version = '>= 2.0'
  spec.required_rubygems_version = '>= 1.3.5'
end
