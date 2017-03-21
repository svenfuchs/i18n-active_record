require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

def execute(command)
  puts command
  system command
end

def bundle_options
  opt = ''
  opt +=  "--gemfile #{ENV['BUNDLE_GEMFILE']}" if ENV['BUNDLE_GEMFILE']
end

def each_database(&block)
  ['sqlite', 'postgres', 'mysql'].each &block
end

namespace :bundle do
  task :env do
    ar = ENV['AR'].to_s

    next if ar.empty?

    gemfile = "gemfiles/Gemfile.rails_#{ar}"
    raise "Cannot find gemfile at #{gemfile}" unless File.exist?(gemfile)

    ENV['BUNDLE_GEMFILE'] = gemfile
    puts "Using gemfile: #{gemfile}"
  end

  task install: :env do
    execute "bundle install #{bundle_options}"
  end

  task :install_all do
    [nil, '3', '4', '5', 'master'].each do |ar|
      opt = ar && "AR=#{ar}"
      execute "rake bundle:install #{opt}"
    end
  end
end

task :test do
  each_database { |db| execute "rake #{db}:test" }
end

Rake::TestTask.new :_test do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

each_database do |db|
  namespace db do
    task(:env) { ENV['DB'] = db }
    task test: ['env', 'bundle:env', '_test']
  end
end

task default: :test
