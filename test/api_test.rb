require 'test_helper'

class I18nActiveRecordApiTest < I18n::TestCase
  def setup
    I18n.backend = I18n::Backend::ActiveRecord.new
    I18n::Backend::ActiveRecord::Translation.send(:include, I18n::Backend::ActiveRecord::StoreProcs)
    super
  end

  include I18n::Tests::Basics
  include I18n::Tests::Defaults
  include I18n::Tests::Interpolation
  include I18n::Tests::Link
  include I18n::Tests::Lookup
  include I18n::Tests::Pluralization
  include I18n::Tests::Procs

  include I18n::Tests::Localization::Date
  include I18n::Tests::Localization::DateTime
  include I18n::Tests::Localization::Time
  include I18n::Tests::Localization::Procs

  test "make sure we use an ActiveRecord backend" do
    assert_equal I18n::Backend::ActiveRecord, I18n.backend.class
  end
end
