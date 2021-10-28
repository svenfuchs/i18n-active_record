# frozen_string_literal: true

require 'test_helper'

class I18nActiveRecordApiTest < I18n::TestCase
  def setup
    I18n.backend = I18n::Backend::ActiveRecord.new

    super
  end

  def self.can_store_procs?
    I18n::Backend::ActiveRecord.included_modules.include?(I18n::Backend::ActiveRecord::StoreProcs)
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

  test 'make sure we use an ActiveRecord backend' do
    assert_equal I18n::Backend::ActiveRecord, I18n.backend.class
  end
end
