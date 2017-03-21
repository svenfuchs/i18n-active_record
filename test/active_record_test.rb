require 'test_helper'

class I18nBackendActiveRecordTest < I18n::TestCase
  def setup
    I18n.backend = I18n::Backend::ActiveRecord.new
    store_translations(:en, :foo => { :bar => 'bar', :baz => 'baz' })
  end

  def teardown
    I18n::Backend::ActiveRecord::Translation.destroy_all
    I18n::Backend::ActiveRecord.instance_variable_set :@config, I18n::Backend::ActiveRecord::Configuration.new
    super
  end

  test "store_translations does not allow ambiguous keys (1)" do
    I18n::Backend::ActiveRecord::Translation.delete_all
    I18n.backend.store_translations(:en, :foo => 'foo')
    I18n.backend.store_translations(:en, :foo => { :bar => 'bar' })
    I18n.backend.store_translations(:en, :foo => { :baz => 'baz' })

    translations = I18n::Backend::ActiveRecord::Translation.locale(:en).lookup('foo').all
    assert_equal %w(bar baz), translations.map(&:value)

    assert_equal({ :bar => 'bar', :baz => 'baz' }, I18n.t(:foo))
  end

  test "store_translations does not allow ambiguous keys (2)" do
    I18n::Backend::ActiveRecord::Translation.delete_all
    I18n.backend.store_translations(:en, :foo => { :bar => 'bar' })
    I18n.backend.store_translations(:en, :foo => { :baz => 'baz' })
    I18n.backend.store_translations(:en, :foo => 'foo')

    translations = I18n::Backend::ActiveRecord::Translation.locale(:en).lookup('foo').all
    assert_equal %w(foo), translations.map(&:value)

    assert_equal 'foo', I18n.t(:foo)
  end

  test "can store translations with keys that are translations containing special chars" do
    I18n.backend.store_translations(:es, :"Pagina's" => "Pagina's" )
    assert_equal "Pagina's", I18n.t(:"Pagina's", :locale => :es)
  end

  test "missing translations table does not cause an error in #available_locales" do
    I18n::Backend::ActiveRecord::Translation.expects(:available_locales).raises(::ActiveRecord::StatementInvalid, 'msg')
    assert_equal [], I18n.backend.available_locales
  end

  test "expand_keys" do
    assert_equal %w(foo foo.bar foo.bar.baz), I18n.backend.send(:expand_keys, :'foo.bar.baz')
  end

  test "available_locales returns uniq locales" do
    I18n::Backend::ActiveRecord::Translation.delete_all
    I18n.backend.store_translations(:en, :foo => { :bar => 'bar' })
    I18n.backend.store_translations(:en, :foo => { :baz => 'baz' })
    I18n.backend.store_translations(:de, :foo1 => 'foo')
    I18n.backend.store_translations(:de, :foo2 => 'foo')
    I18n.backend.store_translations(:uk, :foo3 => 'foo')

    available_locales = I18n::Backend::ActiveRecord::Translation.available_locales
    assert_equal 3, available_locales.size
    assert_includes available_locales, :en
    assert_includes available_locales, :de
    assert_includes available_locales, :uk
  end

  test "the default configuration has cleanup_with_destroy == false" do
    refute I18n::Backend::ActiveRecord.config.cleanup_with_destroy
  end

  test "the configuration supports cleanup_with_destroy being set" do
    I18n::Backend::ActiveRecord.configure do |config|
      config.cleanup_with_destroy = true
    end

    assert I18n::Backend::ActiveRecord.config.cleanup_with_destroy
  end

  test "fetching subtree of translations" do
    I18n::Backend::ActiveRecord::Translation.delete_all
    I18n.backend.store_translations(:en, foo: { bar: { fizz: 'buzz', spuz: 'zazz' }, baz: { fizz: 'buzz' } })
    assert_equal I18n.t(:foo), { bar: { fizz: 'buzz', spuz: 'zazz' }, baz: { fizz: 'buzz' } }
  end

  test "build_translation_hash_by_key" do
    translation = I18n::Backend::ActiveRecord::Translation.new(value: 'translation', key: 'foo.bar.fizz.buzz')
    expected_hash = { 'bar' => { 'fizz' => { 'buzz' => 'translation' } } }
    assert_equal I18n.backend.send(:build_translation_hash_by_key, 'foo', translation), expected_hash
  end
end
