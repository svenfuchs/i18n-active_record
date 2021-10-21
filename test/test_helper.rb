$KCODE = 'u' if RUBY_VERSION <= '1.9'

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
    ::ActiveRecord::Base.establish_connection adapter: 'postgresql', database: 'i18n_unittest', username: ENV['PG_USER'] || 'i18n', password: '', host: 'localhost'
  when 'mysql'
    ::ActiveRecord::Base.establish_connection adapter: 'mysql2', database: 'i18n_unittest', username: 'root', password: '', host: 'localhost'
  else
    ::ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
  end
  ::ActiveRecord::Migration.verbose = false
  ::ActiveRecord::Schema.define(:version => 1) do
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

TEST_CASE = defined?(Minitest::Test) ? Minitest::Test : MiniTest::Unit::TestCase

class TEST_CASE
  alias :assert_raise :assert_raises
  alias :assert_not_equal :refute_equal

  def assert_nothing_raised(*args)
    yield
  end
end

class I18n::TestCase < TEST_CASE
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

  def translations
    I18n.backend.instance_variable_get(:@translations)
  end

  def store_translations(locale, data)
    I18n.backend.store_translations(locale, data)
  end

  def locales_dir
    File.dirname(__FILE__) + '/test_data/locales'
  end

  def self.test(*args, **opts, &block)
    if !opts.has_key?(:cache_translations)
      super(*args, &block)
    else
      if opts[:cache_translations] != I18n::Backend::ActiveRecord.config.cache_translations
        cache_translations_was = I18n::Backend::ActiveRecord.config.cache_translations

        I18n::Backend::ActiveRecord.config.cache_translations = opts[:cache_translations]
      end

      cache_suffix = "CacheTranslations:#{I18n::Backend::ActiveRecord.config.cache_translations}"

      args[0] = [args[0], cache_suffix].join(" ")

      super(*args, &block)

      if cache_translations_was
        I18n::Backend::ActiveRecord.config.cache_translations = cache_translations_was
      end
    end
  end
end
