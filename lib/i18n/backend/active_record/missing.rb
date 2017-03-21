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
  module Backend
    class ActiveRecord
      module Missing
        include Flatten

        def store_default_translations(locale, key, options = {})
          count, scope, default, separator = options.values_at(:count, :scope, :default, :separator)
          separator ||= I18n.default_separator
          key = normalize_flat_keys(locale, key, scope, separator)

          unless ActiveRecord::Translation.locale(locale).lookup(key).exists?
            interpolations = options.keys - I18n::RESERVED_KEYS
            keys = count ? I18n.t('i18n.plural.keys', :locale => locale).map { |k| [key, k].join(FLATTEN_SEPARATOR) } : [key]
            keys.each { |key| store_default_translation(locale, key, interpolations) }

            # if memoization is included, this refreshes the hash to get new values just stored
            try(:reload!)
          end
        end

        def store_default_translation(locale, key, interpolations)
          translation = ActiveRecord::Translation.new :locale => locale.to_s, :key => key
          translation.interpolations = interpolations
          translation.value = get_value_from_simple_backend(locale, key)
          translation.save
        end

        def translate(locale, key, options = {})
          result = catch(:exception) { super }
          if result.is_a?(I18n::MissingTranslation)
            self.store_default_translations(locale, key, options)
            throw(:exception, result)
          else
            result
          end
        end

        private
          # Check if this backend is chainning with simple
          # then try to get value from its hash.
          def get_value_from_simple_backend(locale, key)
            if I18n.backend.class == Chain &&
              I18n.backend.backends.last.class == Simple
              I18n.backend.backends.last.send(:lookup, locale, key)
            else
              nil
            end
          end
      end
    end
  end
end
