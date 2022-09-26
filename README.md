# I18n::Backend::ActiveRecord [![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop) [![Tests Status](https://github.com/svenfuchs/i18n-active_record/actions/workflows/test.yml/badge.svg)](https://github.com/svenfuchs/i18n-active_record/actions) [![Linter Status](https://github.com/svenfuchs/i18n-active_record/actions/workflows/linter.yml/badge.svg)](https://github.com/svenfuchs/i18n-active_record/actions)

This repository contains the I18n ActiveRecord backend and support code that has been extracted from the `I18n` gem: http://github.com/svenfuchs/i18n.
It is fully compatible with Rails 4, 5 and 6.

## Installation

For Bundler put the following in your Gemfile:

```ruby
gem 'i18n-active_record', require: 'i18n/active_record'
```

After updating your bundle, run the installer

    $ rails g i18n:active_record:install

It creates a migration:

```ruby
class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :locale
      t.string :key
      t.text :value
      t.text :interpolations
      t.boolean :is_proc, default: false

      t.timestamps
    end
  end
end
```

To specify table name use:

    $ rails g i18n:active_record:install MyTranslation

With the translation model you will be able to manage your translation, and add new translations or languages through
it.

By default the installer creates a new file in `config/initializers` named `i18n_active_record.rb` with the following content.

```ruby
require 'i18n/backend/active_record'

Translation = I18n::Backend::ActiveRecord::Translation

if Translation.table_exists?
  I18n.backend = I18n::Backend::ActiveRecord.new

  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
  I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
  I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

  I18n.backend = I18n::Backend::Chain.new(I18n::Backend::Simple.new, I18n.backend)
end
```

To perform a simpler installation use:

    $ rails g i18n:active_record:install --simple

It generates:

```ruby
require 'i18n/backend/active_record'
I18n.backend = I18n::Backend::ActiveRecord.new
```

You may also configure whether the ActiveRecord backend should use `destroy` or `delete` when cleaning up internally.

```ruby
I18n::Backend::ActiveRecord.configure do |config|
  config.cleanup_with_destroy = true # defaults to false
end
```

To configure the ActiveRecord backend to cache translations(might be useful in production) use:

```ruby
I18n::Backend::ActiveRecord.configure do |config|
  config.cache_translations = true # defaults to false
end
```

## Usage

You can now use `I18n.t('Your String')` to lookup translations in the database.

## Missing Translations

### Usage

In order to make the `I18n::Backend::ActiveRecord::Missing` module working correctly pluralization rules should be configured properly.
The `i18n.plural.keys` translation key should be present in any of the backends.
See https://github.com/svenfuchs/i18n-active_record/blob/master/lib/i18n/backend/active_record/missing.rb for more information.

```yaml
en:
  i18n:
    plural:
      keys:
        - :zero
        - :one
        - :other
```

### Interpolations

The `interpolations` field in the `translations` table is used by `I18n::Backend::ActiveRecord::Missing` to store the interpolations seen the first time this Translation was requested.  This will help translators understand what interpolations to expect, and thus to include when providing the translations.

The `interpolations` field is otherwise unused since the "value" in `Translation#value` is actually used for interpolation during actual translations.

## Examples

* http://collectiveidea.com/blog/archives/2016/05/31/beyond-yml-files-dynamic-translations/ ([use `before_action`](https://github.com/svenfuchs/i18n-active_record/issues/138) for Rails 5.1+)

## Contributing

### Test suite

The test suite can be run with:

    bundle exec rake

By default it runs the tests for SQLite database, to specify a database the `DB` env variable can be used:

    DB=postgres bundle exec rake
    DB=mysql bundle exec rake

To run tests for a specific rails version see [Appraisal](https://github.com/thoughtbot/appraisal):

    bundle exec appraisal rails-4 rake test

## Maintainers

* Sven Fuchs
* Tim Masliuchenko
