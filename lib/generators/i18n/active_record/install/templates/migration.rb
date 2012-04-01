class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string  :locale
      t.string  :key
      t.text    :value
      t.text    :interpolations
      t.boolean :is_proc, :default => false

      t.timestamps
    end

    add_index :translations, [:locale, :key], :unique => true
  end
end
