require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

def execute(command)
  puts command
  system command
end

namespace :bundle do
  task :env do
    db = ENV['DB'].to_s
    db = '' if db == 'sqlite'
    ar = ENV['AR'].to_s

    next if db == 'sqlite' && ar.empty?

    gemfile = 'gemfiles/Gemfile'
    gemfile += ".rails_#{ar}" unless ar.empty?
    gemfile += ".#{db}" unless db.empty?
    raise "Cannot find gemfile at #{gemfile}" unless File.exist?(gemfile)

    ENV['BUNDLE_GEMFILE'] = gemfile
  end

  task install: :env do
    opt = ''
    opt +=  "--gemfile #{ENV['BUNDLE_GEMFILE']}" if ENV['BUNDLE_GEMFILE']
    execute "bundle install #{opt}"
  end
end

Rake::TestTask.new :_test do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task test: 'bundle:env' do
  Rake::Task['_test'].execute
end

task default: :test
