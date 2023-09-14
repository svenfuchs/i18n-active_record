# frozen_string_literal: true

# This module is intended to be mixed into the ActiveRecord backend to allow
# storing Ruby Procs as translation values in the database.
#
#   I18n.backend = I18n::Backend::ActiveRecord.new
#   I18n::Backend::ActiveRecord::Translation.send(:include, I18n::Backend::ActiveRecord::StoreProcs)
#
# The StoreProcs module requires the ParseTree and ruby2ruby gems and therefor
# was extracted from the original backend.
#
# ParseTree is not compatible with Ruby 1.9.

begin
  require 'ruby2ruby'
  require 'parse_tree'
  require 'parse_tree_extensions'
rescue LoadError => e
  puts "can't use StoreProcs because: #{e.message}"
end

module I18n
  module Backend
    class ActiveRecord
      module StoreProcs
        extend TranslationModel

        def value=(val)
          case val
          when Proc
            write_attribute(:value, val.to_ruby)
            write_attribute(:is_proc, true)
          else
            write_attribute(:value, val)
          end
        end

        translation_model.send(:include, self) if method(:to_s).respond_to?(:to_ruby)
      end
    end
  end
end
