# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'i18n_active_record/version'

Gem::Specification.new do |s|
  s.name         = "i18n-active_record"
  s.version      = I18n::ActiveRecord::VERSION
  s.authors      = ["Sven Fuchs"]
  s.email        = "svenfuchs@artweb-design.de"
  s.homepage     = "http://github.com/svenfuchs/i18n-active_record"
  s.summary      = "[summary]"
  s.description  = "[description]"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
end
