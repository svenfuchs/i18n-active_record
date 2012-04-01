require 'rails/generators'
require 'rails/generators/migration'

module I18n
  module ActiveRecord
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      source_root File.expand_path('../templates', __FILE__)

      def copy_migrations
        migration_template "migration.rb", "db/migrate/create_translations.rb"
      end
    end
  end
end