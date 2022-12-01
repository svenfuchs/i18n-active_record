# frozen_string_literal: true

module I18n
  module Backend
    class ActiveRecord
      class Configuration
        attr_accessor :cleanup_with_destroy, :cache_translations, :scope

        def initialize
          @cleanup_with_destroy = false
          @cache_translations = false
          @scope = nil
        end
      end
    end
  end
end
