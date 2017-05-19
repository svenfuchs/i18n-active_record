require 'i18n/backend/base'
require 'i18n/backend/active_record/translation'

module I18n
  module Backend
    class ActiveRecord
      autoload :Missing,       'i18n/backend/active_record/missing'
      autoload :StoreProcs,    'i18n/backend/active_record/store_procs'
      autoload :Translation,   'i18n/backend/active_record/translation'
      autoload :Configuration, 'i18n/backend/active_record/configuration'

      class << self
        def configure
          yield(config) if block_given?
        end

        def config
          @config ||= Configuration.new
        end
      end

      module Implementation
        include Base, Flatten

        def available_locales
          begin
            Translation.available_locales
          rescue ::ActiveRecord::StatementInvalid
            []
          end
        end

        def store_translations(locale, data, options = {})
          escape = options.fetch(:escape, true)
          flatten_translations(locale, data, escape, false).each do |key, value|
            translation = Translation.locale(locale).lookup(expand_keys(key))

            if ActiveRecord.config.cleanup_with_destroy
              translation.destroy_all
            else
              translation.delete_all
            end

            Translation.create(:locale => locale.to_s, :key => key.to_s, :value => value)
          end
        end

      protected

        def lookup(locale, key, scope = [], options = {})
          key = normalize_flat_keys(locale, key, scope, options[:separator])
          results = Translation.locale(locale).lookup(key).order(key: :desc)

          if results.empty?
            nil
          elsif results.first.key == key
            results.first.value
          else
            results.inject({}) do |hash, translation|
              hash.deep_merge build_translation_hash_by_key(key, translation)
            end.deep_symbolize_keys
          end
        end

        def build_translation_hash_by_key(lookup_key, translation)
          chop_range = (lookup_key.size + FLATTEN_SEPARATOR.size)..-1
          translation_nested_keys = translation.key.slice(chop_range)
          return {} if translation_nested_keys.nil?
          translation_nested_keys = translation_nested_keys.split(FLATTEN_SEPARATOR)

          translation_nested_keys.each.with_index.inject({}) do |iterator, (key, index)|
            iterator.merge(key => translation_nested_keys[index + 1] ? {} : translation.value)
          end
        end

        # For a key :'foo.bar.baz' return ['foo', 'foo.bar', 'foo.bar.baz']
        def expand_keys(key)
          key.to_s.split(FLATTEN_SEPARATOR).inject([]) do |keys, key|
            keys << [keys.last, key].compact.join(FLATTEN_SEPARATOR)
          end
        end
      end

      include Implementation
    end
  end
end
