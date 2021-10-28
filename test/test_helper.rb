# frozen_string_literal: true

require 'bundler/setup'
require 'minitest/autorun'
require 'mocha/minitest'
require 'test_declarative'

require 'i18n/active_record'
require 'i18n/tests'

begin
  require 'active_record'
  ::ActiveRecord::Base.connection
rescue LoadError => e
  puts "can't use ActiveRecord backend because: #{e.message}"
rescue ::ActiveRecord::ConnectionNotEstablished
  require 'i18n/backend/active_record'

  case ENV['DB']
  when 'postgres'
    ::ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      database: 'i18n_unittest',
      username: ENV['PG_USER'] || 'postgres',
      password: ENV['PG_PASSWORD'] || 'postgres',
      host: 'localhost'
    )
  when 'mysql'
    ::ActiveRecord::Base.establish_connection(
      adapter: 'mysql2',
      database: 'i18n_unittest',
      username: ENV['MYSQL_USER'] || 'root',
      password: ENV['MYSQL_PASSWORD'] || '',
      host: '127.0.0.1'
    )
  else
    ::ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
  end

  ::ActiveRecord::Migration.verbose = false
  ::ActiveRecord::Schema.define(version: 1) do
    create_table :translations, force: true do |t|
      t.string :locale
      t.string :key
      t.text :value
      t.text :interpolations
      t.boolean :is_proc, default: false
    end
    add_index :translations, %i[locale key], unique: true
  end
end

TEST_CASE = defined?(Minitest::Test) ? Minitest::Test : MiniTest::Unit::TestCase

class TEST_CASE # rubocop:disable Naming/ClassAndModuleCamelCase
  alias assert_raise assert_raises
  alias assert_not_equal refute_equal

  def assert_nothing_raised(*_args)
    yield
  end
end

module I18n
  class TestCase < TEST_CASE
    def setup
      I18n.enforce_available_locales = false
      I18n.available_locales = []
      I18n.locale = :en
      I18n.default_locale = :en
      I18n.load_path = []
      super
    end

    def teardown
      I18n.enforce_available_locales = false
      I18n.available_locales = []
      I18n.locale = :en
      I18n.default_locale = :en
      I18n.load_path = []
      I18n.backend = nil
      super
    end

    def store_translations(locale, data)
      I18n.backend.store_translations(locale, data)
    end

    def locales_dir
      "#{File.dirname(__FILE__)}/test_data/locales"
    end
  end
end
