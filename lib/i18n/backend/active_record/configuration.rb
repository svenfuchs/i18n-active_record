module I18n
  module Backend
    class ActiveRecord
      class Configuration
        attr_accessor :cleanup_with_destroy

        def initialize
          @cleanup_with_destroy = false
        end
      end
    end
  end
end
