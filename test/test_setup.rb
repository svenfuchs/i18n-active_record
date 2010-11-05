$KCODE = 'u' if RUBY_VERSION <= '1.9'

require 'rubygems'
require 'test/unit'
require 'optparse'

# Do not load the i18n gem from libraries like active_support.
#
# This is required for testing against Rails 2.3 because active_support/vendor.rb#24 tries
# to load I18n using the gem method. Instead, we want to test the local library of course.
alias :gem_for_ruby_19 :gem # for 1.9. gives a super ugly seg fault otherwise
def gem(gem_name, *version_requirements)
  puts("skipping loading the i18n gem ...") && return if gem_name =='i18n'
  super(gem_name, *version_requirements)
end

module I18n
  module Tests
    class << self
      def options
        @options ||= { :with => [], :adapter => 'sqlite3' }
      end

      def parse_options!
        OptionParser.new do |o|
          o.on('-w', '--with DEPENDENCIES', 'Define dependencies') do |dep|
            options[:with] = dep.split(',').map { |group| group.to_sym }
          end
        end.parse!

        options[:with].each do |dep|
          case dep
          when :sqlite3, :mysql, :postgres
            @options[:adapter] = dep
          when :r23, :'rails-2.3.x'
            ENV['BUNDLE_GEMFILE'] = 'ci/Gemfile.rails-2.3.x'
          when :r3, :'rails-3.0.x'
            ENV['BUNDLE_GEMFILE'] = 'ci/Gemfile.rails-3.x'
          when :'no-rails'
            ENV['BUNDLE_GEMFILE'] = 'ci/Gemfile.no-rails'
          end
        end

        ENV['BUNDLE_GEMFILE'] ||= 'ci/Gemfile.all'
      end

      def setup_active_record
        begin
          require 'active_record'
          ActiveRecord::Base.connection
          true
        rescue LoadError => e
          puts "can't use ActiveRecord backend because: #{e.message}"
        rescue ActiveRecord::ConnectionNotEstablished
          require 'i18n/backend/active_record'
          require 'i18n/backend/active_record/store_procs'
          connect_active_record
          true
        end
      end

      def connect_active_record
        connect_adapter
        ActiveRecord::Migration.verbose = false
        ActiveRecord::Schema.define(:version => 1) do
          create_table :translations, :force => true do |t|
            t.string :locale
            t.string :key
            t.text :value
            t.text :interpolations
            t.boolean :is_proc, :default => false
          end
          add_index :translations, [:locale, :key], :unique => true
        end
      end

      def connect_adapter
        case options[:adapter].to_sym
        when :sqlite3
          ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
        when :mysql
          # CREATE DATABASE i18n_unittest;
          # CREATE USER 'i18n'@'localhost' IDENTIFIED BY '';
          # GRANT ALL PRIVILEGES ON i18n_unittest.* to 'i18n'@'localhost';
          ActiveRecord::Base.establish_connection(:adapter => "mysql", :database => "i18n_unittest", :username => "i18n", :password => "", :host => "localhost")
        end
      end
    end
  end
end


