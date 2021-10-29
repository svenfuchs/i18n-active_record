# frozen_string_literal: true

require 'rake/testtask'
require 'bundler/gem_tasks'

Rake::TestTask.new :test do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
