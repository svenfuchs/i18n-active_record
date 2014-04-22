require File.expand_path('../test_helper', __FILE__)

class I18nActiveRecordApiTest < Test::Unit::TestCase
  class I18n::Backend::ActiveRecord
    include I18n::Backend::ActiveRecord::Missing
  end

  def setup
    I18n.backend = I18n::Backend::ActiveRecord.new
    I18n.exception_handler = I18n::StoreMissingLookupExceptionHandler.new
    I18n::Backend::ActiveRecord::Translation.send(:include, I18n::Backend::ActiveRecord::StoreProcs)
    I18n::Backend::ActiveRecord::Translation.delete_all
    super
  end

  def self.can_store_procs?
    I18n::Backend::ActiveRecord::Translation.respond_to?(:bl)
  end

  include I18n::Tests::Basics
  include I18n::Tests::Defaults
  include I18n::Tests::Interpolation
  include I18n::Tests::Link
  include I18n::Tests::Lookup
  include I18n::Tests::Pluralization
  include I18n::Tests::Procs if can_store_procs?

  include I18n::Tests::Localization::Date
  include I18n::Tests::Localization::DateTime
  include I18n::Tests::Localization::Time
  include I18n::Tests::Localization::Procs if can_store_procs?

  test "make sure we use an ActiveRecord backend" do
    assert_equal I18n::Backend::ActiveRecord, I18n.backend.class
  end
end if defined?(ActiveRecord)

