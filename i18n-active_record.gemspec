# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'i18n/active_record/version'

Gem::Specification.new do |s|
  s.name         = "i18n-active_record"
  s.version      = I18n::ActiveRecord::VERSION
  s.authors      = ["Sven Fuchs"]
  s.email        = "svenfuchs@artweb-design.de"
  s.homepage     = "http://github.com/svenfuchs/i18n-active_record"
  s.summary      = "I18n ActiveRecord backend"
  s.description  = "I18n ActiveRecord backend. Allows to store translations in a database using ActiveRecord, e.g. for providing a web-interface for managing translations."

  s.files        = Dir.glob("{ci,lib,test}/**/**") + %w(MIT-LICENSE README.textile Rakefile)
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_dependency 'i18n', '>= 0.5.0'
end
