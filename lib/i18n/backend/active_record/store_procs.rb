# This module is intended to be mixed into the ActiveRecord backend to allow
# storing Ruby Procs as translation values in the database.
#
#   I18n.backend = I18n::Backend::ActiveRecord.new
#   I18n::Backend::ActiveRecord::Translation.send(:include, I18n::Backend::ActiveRecord::StoreProcs)

module I18n
  module Backend
    class ActiveRecord
      module StoreProcs
        require 'sourcify'
        def self.included base
          base.extend(ClassMethods)
        end
        module ClassMethods
          def value=(v)
            case v
            when Proc
              write_attribute(:value, v.to_source)
              write_attribute(:is_proc, true)
            else
              write_attribute(:value, v)
            end
          end

          def value
            value = read_attribute(:value)
            if is_proc
              Kernel.eval(value)
            elsif value == I18n::Backend::ActiveRecord::Translation::FALSY_CHAR
              false
            elsif value == I18n::Backend::ActiveRecord::Translation::TRUTHY_CHAR
              true
            else
              value
            end
          end
        end
      end
    end
  end
end

