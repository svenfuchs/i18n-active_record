#  This extension stores translation stub records for missing translations to
#  the database.
#
#  This is useful if you have a web based translation tool. It will populate
#  the database with untranslated keys as the application is being used. A
#  translator can then go through these and add missing translations.
#
#  Example usage:
#
#     I18n::Backend::Chain.send(:include, I18n::Backend::ActiveRecord::Missing)
#     I18n.backend = I18n::Backend::Chain.new(I18n::Backend::ActiveRecord.new, I18n::Backend::Simple.new)
#
#  Stub records for pluralizations will also be created for each key defined
#  in i18n.plural.keys.
#
#  For example:
#
#    # en.yml
#    en:
#      i18n:
#        plural:
#          keys: [:zero, :one, :other]
#
#    # pl.yml
#    pl:
#      i18n:
#        plural:
#          keys: [:zero, :one, :few, :other]
#
#  It will also persist interpolation keys in Translation#interpolations so
#  translators will be able to review and use them.
module I18n

  # This ExceptionHandler is needed to be able to store translations when they are missing on lookup.
  # In the initializer, when the backend chain is setup, this has to be called:
  #     I18n.exception_handler = I18n::StoreMissingLookupExceptionHandler.new
  class StoreMissingLookupExceptionHandler < ExceptionHandler
    def call(exception, locale, key, options)
      if exception.is_a?(MissingTranslation)
        back_end = find_backend_implementing_store
        if back_end
          back_end.store_default_translations(locale, key, options)
        end
      end
      super
    end
    def find_backend_implementing_store
      options = []
      if I18n.backend.class == I18n::Backend::Chain
        options = I18n.backend.backends
      else
        options = [I18n.backend]
      end
      options.each do |be|
        if be.respond_to?(:store_default_translations)
          return be
        end
      end
      nil
    end
  end

  module Backend
    class ActiveRecord
      module Missing
        include Flatten

        def store_default_translations(locale, key, options = {})
          count, scope, _, separator = options.values_at(:count, :scope, :default, :separator)
          separator ||= I18n.default_separator
          key = normalize_flat_keys(locale, key, scope, separator)

          unless ActiveRecord::Translation.locale(locale).lookup(key).exists?
            interpolations = options.keys - I18n::RESERVED_KEYS
            keys = count ? I18n.t('i18n.plural.keys', :locale => locale).map { |k| [key, k].join(FLATTEN_SEPARATOR) } : [key]
            keys.each { |the_key| store_default_translation(locale, the_key, interpolations) }
          end
        end

        def store_default_translation(locale, key, interpolations)
          translation = ActiveRecord::Translation.new :locale => locale.to_s, :key => key
          translation.interpolations = interpolations
          translation.save
        end

        def translate(locale, key, options = {})
          super
        rescue I18n::MissingTranslationData => e
          self.store_default_translations(locale, key, options)
          raise e
        end
      end
    end
  end
end

