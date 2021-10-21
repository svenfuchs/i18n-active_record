require 'test_helper'

class I18nActiveRecordMissingTest < I18n::TestCase
  class Backend < I18n::Backend::ActiveRecord
    include I18n::Backend::ActiveRecord::Missing
  end

  def setup
    I18n.backend.store_translations(:en, :bar => 'Bar', :i18n => { :plural => { :keys => [:zero, :one, :other] } })
    I18n.backend = I18n::Backend::Chain.new(Backend.new, I18n.backend)
    I18n::Backend::ActiveRecord::Translation.delete_all
  end

  [false, true].each do |cache_translations|
    test "can persist interpolations", cache_translations: cache_translations do
      translation = I18n::Backend::ActiveRecord::Translation.new(:key => 'foo', :value => 'bar', :locale => :en)
      translation.interpolations = %w(count name)
      translation.save
      assert translation.valid?
    end

    test "lookup persists the key", cache_translations: cache_translations do
      I18n.t('foo.bar.baz')

      assert_equal 1, I18n::Backend::ActiveRecord::Translation.count
      assert I18n::Backend::ActiveRecord::Translation.locale(:en).find_by_key('foo.bar.baz')
    end

    test "lookup does not persist the key twice", cache_translations: cache_translations do
      2.times { I18n.t('foo.bar.baz') }
      assert_equal 1, I18n::Backend::ActiveRecord::Translation.count
      assert I18n::Backend::ActiveRecord::Translation.locale(:en).find_by_key('foo.bar.baz')
    end

    test "lookup persists interpolation keys when looked up directly", cache_translations: cache_translations do
      I18n.t('foo.bar.baz', :cow => "lucy" )  # creates stub translation.
      translation_stub = I18n::Backend::ActiveRecord::Translation.locale(:en).lookup('foo.bar.baz').first
      assert translation_stub.interpolates?(:cow)
    end

    test "creates one stub per pluralization", cache_translations: cache_translations do
      I18n.t('foo', :count => 999)
      translations = I18n::Backend::ActiveRecord::Translation.locale(:en).where key: %w{ foo.zero foo.one foo.other }
      assert_equal 3, translations.length
    end

    test "creates no stub for base key in pluralization", cache_translations: cache_translations do
      I18n.t('foo', :count => 999)
      assert_equal 3, I18n::Backend::ActiveRecord::Translation.locale(:en).lookup("foo").count
      assert !I18n::Backend::ActiveRecord::Translation.locale(:en).find_by_key("foo")
    end

    test "creates a stub when a custom separator is used", cache_translations: cache_translations do
      I18n.t('foo|baz', :separator => '|')
      I18n::Backend::ActiveRecord::Translation.locale(:en).lookup("foo.baz").first.update(:value => 'baz!')
      assert_equal 'baz!', I18n.t('foo|baz', :separator => '|')
    end

    test "creates a stub per pluralization when a custom separator is used", cache_translations: cache_translations do
      I18n.t('foo|bar', :count => 999, :separator => '|')
      translations = I18n::Backend::ActiveRecord::Translation.locale(:en).where key: %w{ foo.bar.zero foo.bar.one foo.bar.other }
      assert_equal 3, translations.length
    end

    test "creates a stub when a custom separator is used and the key contains the flatten separator (a dot character)", cache_translations: cache_translations do
      key = 'foo|baz.zab'
      I18n.t(key, :separator => '|')
      I18n::Backend::ActiveRecord::Translation.locale(:en).lookup("foo.baz\001zab").first.update(:value => 'baz!')
      assert_equal 'baz!', I18n.t(key, :separator => '|')
    end
  end
end
