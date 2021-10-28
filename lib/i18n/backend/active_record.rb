# frozen_string_literal: true

require 'i18n/backend/base'
require 'i18n/backend/active_record/translation'

module I18n
  module Backend
    class ActiveRecord
      autoload :Missing,       'i18n/backend/active_record/missing'
      autoload :StoreProcs,    'i18n/backend/active_record/store_procs'
      autoload :Translation,   'i18n/backend/active_record/translation'
      autoload :Configuration, 'i18n/backend/active_record/configuration'

      include Base
      include Flatten

      class << self
        def configure
          yield(config) if block_given?
        end

        def config
          @config ||= Configuration.new
        end
      end

      def initialize(*args)
        super

        reload!
      end

      def available_locales
        Translation.available_locales
      rescue ::ActiveRecord::StatementInvalid
        []
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

          Translation.create(locale: locale.to_s, key: key.to_s, value: value)
        end

        reload! if ActiveRecord.config.cache_translations
      end

      def reload!
        @translations = nil

        self
      end

      def initialized?
        !@translations.nil?
      end

      def init_translations
        @translations = Translation.to_hash
      end

      def translations(do_init: false)
        init_translations if do_init || !initialized?
        @translations ||= {}
      end

      protected

      def lookup(locale, key, scope = [], options = {})
        key = normalize_flat_keys(locale, key, scope, options[:separator])
        key = key[1..] if key.first == '.'
        key = key[0..-2] if key.last == '.'

        if ActiveRecord.config.cache_translations
          init_translations if @translations.nil? || @translations.empty?

          keys = ([locale] + key.split(I18n::Backend::Flatten::FLATTEN_SEPARATOR)).map(&:to_sym)

          return translations.dig(*keys)
        end

        result = if key == ''
          Translation.locale(locale).all
        else
          Translation.locale(locale).lookup(key)
        end

        if result.empty?
          nil
        elsif result.first.key == key
          result.first.value
        else
          result = result.inject({}) do |hash, translation|
            hash.deep_merge build_translation_hash_by_key(key, translation)
          end
          result.deep_symbolize_keys
        end
      end

      def build_translation_hash_by_key(lookup_key, translation)
        hash = {}

        chop_range = if lookup_key == ''
          0..-1
        else
          (lookup_key.size + FLATTEN_SEPARATOR.size)..-1
        end
        translation_nested_keys = translation.key.slice(chop_range).split(FLATTEN_SEPARATOR)
        translation_nested_keys.each.with_index.inject(hash) do |iterator, (key, index)|
          iterator[key] = translation_nested_keys[index + 1] ?  {} : translation.value
          iterator[key]
        end

        hash
      end

      # For a key :'foo.bar.baz' return ['foo', 'foo.bar', 'foo.bar.baz']
      def expand_keys(key)
        key.to_s.split(FLATTEN_SEPARATOR).inject([]) do |keys, k|
          keys << [keys.last, k].compact.join(FLATTEN_SEPARATOR)
        end
      end
    end
  end
end
