# frozen_string_literal: true

module I18n
  module Backend
    class ActiveRecord
      class Configuration
        attr_accessor :cleanup_with_destroy, :cache_translations, :translation_model, :scope

        def initialize
          @cleanup_with_destroy = false
          @cache_translations = false
          @translation_model = I18n::Backend::ActiveRecord::Translation
          @scope = nil
        end
      end
    end
  end
end
