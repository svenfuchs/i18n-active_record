require 'rails/generators/active_record'

module I18n
  module ActiveRecord
    module Generators
      class  InstallGenerator < ::ActiveRecord::Generators::Base
        desc "Installs i18n-active_record and generates the necessary migrations"

        argument :name, type: :string, default: 'Translation'

        class_option :simple, type: :boolean, default: false, desc: 'Perform the simple setup'

        source_root File.expand_path('templates', __dir__)

        def copy_initializer
          tpl = "#{options[:simple] ? 'simple' : 'advanced'}_initializer.rb.erb"

          template tpl, 'config/initializers/i18n_active_record.rb'
        end

        def create_migrations
          migration_template 'migration.rb.erb', "db/migrate/create_#{table_name}.rb"
        end
      end
    end
  end
end
