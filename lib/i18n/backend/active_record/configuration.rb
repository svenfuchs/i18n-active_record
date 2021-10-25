module I18n
  module Backend
    class ActiveRecord
      class Configuration
        attr_accessor :cleanup_with_destroy
        attr_accessor :cache_translations

        def initialize
          @cleanup_with_destroy = false
          @cache_translations = false
        end
      end
    end
  end
end
