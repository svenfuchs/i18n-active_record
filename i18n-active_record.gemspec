# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'i18n/active_record/version'

Gem::Specification.new do |s|
  s.name         = 'i18n-active_record'
  s.version      = I18n::ActiveRecord::VERSION
  s.authors      = ['Sven Fuchs']
  s.email        = 'svenfuchs@artweb-design.de'
  s.homepage     = 'http://github.com/svenfuchs/i18n-active_record'
  s.summary      = 'I18n ActiveRecord backend'
  s.description  = 'I18n ActiveRecord backend. Allows to store translations in a database using ActiveRecord, ' \
                   'e.g. for providing a web-interface for managing translations.'
  s.license      = 'MIT'

  s.files        = Dir.glob('{lib,test}/**/**') + %w[MIT-LICENSE README.md Rakefile]
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_dependency 'i18n', '>= 0.5.0'

  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'test_declarative'
end
