# Changelog

## [Unreleased](https://github.com/svenfuchs/i18n-active_record/tree/HEAD)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.4.1...HEAD)

**Closed issues:**

- Falling docker build [\#117](https://github.com/svenfuchs/i18n-active_record/issues/117)

## [v0.4.1](https://github.com/svenfuchs/i18n-active_record/tree/v0.4.1) (2021-08-24)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.4.0...v0.4.1)

**Closed issues:**

- Generator with class name in a module produces invalid migration [\#115](https://github.com/svenfuchs/i18n-active_record/issues/115)
- Error encountered when creating a DB [\#114](https://github.com/svenfuchs/i18n-active_record/issues/114)
- path for form helper [\#105](https://github.com/svenfuchs/i18n-active_record/issues/105)
- config/initializers/i18n\_active\_record.rb not working [\#104](https://github.com/svenfuchs/i18n-active_record/issues/104)

**Merged pull requests:**

- Handle namespaced classes correctly [\#116](https://github.com/svenfuchs/i18n-active_record/pull/116) ([timfjord](https://github.com/timfjord))
- README with syntax highlighting [\#113](https://github.com/svenfuchs/i18n-active_record/pull/113) ([dorianmariefr](https://github.com/dorianmariefr))
- Simplify generated migration [\#112](https://github.com/svenfuchs/i18n-active_record/pull/112) ([dorianmariefr](https://github.com/dorianmariefr))
- Update dependencies [\#109](https://github.com/svenfuchs/i18n-active_record/pull/109) ([timfjord](https://github.com/timfjord))
- Bump rake from 12.0.0 to 13.0.1 [\#102](https://github.com/svenfuchs/i18n-active_record/pull/102) ([dependabot[bot]](https://github.com/apps/dependabot))

## [v0.4.0](https://github.com/svenfuchs/i18n-active_record/tree/v0.4.0) (2020-02-27)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.3.0...v0.4.0)

**Closed issues:**

- The generated class for the migration is missing an s on CreateTranslations [\#100](https://github.com/svenfuchs/i18n-active_record/issues/100)
- i18n search yaml file first, then if not found refer to database [\#96](https://github.com/svenfuchs/i18n-active_record/issues/96)
- Error /app/app/models/translation.rb:1:in `\<top \(required\)\>': superclass mismatch for class Translation \(TypeError\) [\#92](https://github.com/svenfuchs/i18n-active_record/issues/92)

**Merged pull requests:**

- Pluralize the class name [\#101](https://github.com/svenfuchs/i18n-active_record/pull/101) ([PWKad](https://github.com/PWKad))
- Add \#translations, \#init\_translations and \#intialized? [\#97](https://github.com/svenfuchs/i18n-active_record/pull/97) ([vipera](https://github.com/vipera))
- Fix Travis [\#95](https://github.com/svenfuchs/i18n-active_record/pull/95) ([timfjord](https://github.com/timfjord))

## [v0.3.0](https://github.com/svenfuchs/i18n-active_record/tree/v0.3.0) (2019-09-27)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.2.2...v0.3.0)

**Closed issues:**

- Feature request: Generator for migration and initializer [\#93](https://github.com/svenfuchs/i18n-active_record/issues/93)
- Using I18nAR in isolation [\#89](https://github.com/svenfuchs/i18n-active_record/issues/89)
- New translations appears in front only after restarting the server \(Rails 5.1.3 / Gem Rails\_Admin\) [\#85](https://github.com/svenfuchs/i18n-active_record/issues/85)
- Bug in Activerecord/YAML chained backend? [\#84](https://github.com/svenfuchs/i18n-active_record/issues/84)
- Conflict with Rails 5 initializers order [\#78](https://github.com/svenfuchs/i18n-active_record/issues/78)
- Rails app crashes when a null locale is present [\#59](https://github.com/svenfuchs/i18n-active_record/issues/59)
- old translations reappearing [\#13](https://github.com/svenfuchs/i18n-active_record/issues/13)

**Merged pull requests:**

- Add i18n:active\_record:install [\#94](https://github.com/svenfuchs/i18n-active_record/pull/94) ([timfjord](https://github.com/timfjord))
- Missed a file rename in readme [\#91](https://github.com/svenfuchs/i18n-active_record/pull/91) ([mejackreed](https://github.com/mejackreed))
- Rename recommended initializer for Rails 5 compatibility [\#90](https://github.com/svenfuchs/i18n-active_record/pull/90) ([mejackreed](https://github.com/mejackreed))

## [v0.2.2](https://github.com/svenfuchs/i18n-active_record/tree/v0.2.2) (2017-12-20)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.2.1...v0.2.2)

**Merged pull requests:**

- Handle accessing keys with a leading period [\#87](https://github.com/svenfuchs/i18n-active_record/pull/87) ([gingermusketeer](https://github.com/gingermusketeer))

## [v0.2.1](https://github.com/svenfuchs/i18n-active_record/tree/v0.2.1) (2017-11-17)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.2.0...v0.2.1)

**Merged pull requests:**

- Fix inconsistency with other I18n backends [\#86](https://github.com/svenfuchs/i18n-active_record/pull/86) ([gingermusketeer](https://github.com/gingermusketeer))

## [v0.2.0](https://github.com/svenfuchs/i18n-active_record/tree/v0.2.0) (2017-03-21)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.1.2...v0.2.0)

**Closed issues:**

- Fetch translations subtree [\#79](https://github.com/svenfuchs/i18n-active_record/issues/79)
- Q: for what interpolations field? [\#77](https://github.com/svenfuchs/i18n-active_record/issues/77)

**Merged pull requests:**

- Improve test suite [\#81](https://github.com/svenfuchs/i18n-active_record/pull/81) ([timfjord](https://github.com/timfjord))
- fix Translations subtree fetch [\#80](https://github.com/svenfuchs/i18n-active_record/pull/80) ([fatbeard2](https://github.com/fatbeard2))

## [v0.1.2](https://github.com/svenfuchs/i18n-active_record/tree/v0.1.2) (2016-08-24)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.1.1...v0.1.2)

**Closed issues:**

- User defined methods for I18n::Backend::ActiveRecord::Translation [\#74](https://github.com/svenfuchs/i18n-active_record/issues/74)

**Merged pull requests:**

- Disabling logger in Translation nullify it everywhere [\#75](https://github.com/svenfuchs/i18n-active_record/pull/75) ([timfjord](https://github.com/timfjord))

## [v0.1.1](https://github.com/svenfuchs/i18n-active_record/tree/v0.1.1) (2016-08-22)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/v0.1.0...v0.1.1)

**Closed issues:**

- add nice blog post to readme? [\#72](https://github.com/svenfuchs/i18n-active_record/issues/72)
- What happened to the rails-4-release branch? [\#69](https://github.com/svenfuchs/i18n-active_record/issues/69)
- Translations don't get updated quickly [\#67](https://github.com/svenfuchs/i18n-active_record/issues/67)
- Refactoring: renaming of column Translation\#key because it's a reserved word for MySQL [\#60](https://github.com/svenfuchs/i18n-active_record/issues/60)
- Present unique available locales [\#51](https://github.com/svenfuchs/i18n-active_record/issues/51)
- Added to attributes on the translation [\#34](https://github.com/svenfuchs/i18n-active_record/issues/34)
- Storing Procs [\#25](https://github.com/svenfuchs/i18n-active_record/issues/25)
- Hooks in Translation model don't work? [\#9](https://github.com/svenfuchs/i18n-active_record/issues/9)

**Merged pull requests:**

- Setup travis [\#71](https://github.com/svenfuchs/i18n-active_record/pull/71) ([timfjord](https://github.com/timfjord))
- Disable logger [\#70](https://github.com/svenfuchs/i18n-active_record/pull/70) ([timfjord](https://github.com/timfjord))
- Use destroy over delete when deleting translation records [\#61](https://github.com/svenfuchs/i18n-active_record/pull/61) ([mpataki](https://github.com/mpataki))

## [v0.1.0](https://github.com/svenfuchs/i18n-active_record/tree/v0.1.0) (2016-03-17)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/rails-3.0...v0.1.0)

**Closed issues:**

- How to use table of different name? [\#66](https://github.com/svenfuchs/i18n-active_record/issues/66)
- Time for a push to rubygems? [\#63](https://github.com/svenfuchs/i18n-active_record/issues/63)
- Rails4 compatible release [\#58](https://github.com/svenfuchs/i18n-active_record/issues/58)
- Backend chain not working for complex keys? [\#57](https://github.com/svenfuchs/i18n-active_record/issues/57)
- active\_record/missing no longer functions [\#56](https://github.com/svenfuchs/i18n-active_record/issues/56)
- PG::Error: ERROR:  relation "translations" does not exist [\#49](https://github.com/svenfuchs/i18n-active_record/issues/49)
- How to make tests suite work [\#48](https://github.com/svenfuchs/i18n-active_record/issues/48)
- License missing from gemspec [\#41](https://github.com/svenfuchs/i18n-active_record/issues/41)
- Can't run tests [\#28](https://github.com/svenfuchs/i18n-active_record/issues/28)
- throw/catch in the ActiveRecord::Missing [\#22](https://github.com/svenfuchs/i18n-active_record/issues/22)
- Gem release for Rails 3.1 compatibility [\#21](https://github.com/svenfuchs/i18n-active_record/issues/21)
- is\_proc question [\#18](https://github.com/svenfuchs/i18n-active_record/issues/18)
- I18n is not missing constant ActiveRecord! [\#17](https://github.com/svenfuchs/i18n-active_record/issues/17)
- I18n is not missing constant RESERVED\_KEYS! [\#7](https://github.com/svenfuchs/i18n-active_record/issues/7)
- serialize problems [\#4](https://github.com/svenfuchs/i18n-active_record/issues/4)

**Merged pull requests:**

- Fix test suit and missing backend [\#65](https://github.com/svenfuchs/i18n-active_record/pull/65) ([timfjord](https://github.com/timfjord))
- Update README.textile [\#62](https://github.com/svenfuchs/i18n-active_record/pull/62) ([tomfast](https://github.com/tomfast))
- Make Translation.available\_locales select distinct values. [\#54](https://github.com/svenfuchs/i18n-active_record/pull/54) ([kaspth](https://github.com/kaspth))
- Improves documentation [\#50](https://github.com/svenfuchs/i18n-active_record/pull/50) ([agustinf](https://github.com/agustinf))
- Rails 4 [\#40](https://github.com/svenfuchs/i18n-active_record/pull/40) ([pawelnguyen](https://github.com/pawelnguyen))

## [rails-3.0](https://github.com/svenfuchs/i18n-active_record/tree/rails-3.0) (2011-09-08)

[View Diff](https://github.com/svenfuchs/i18n-active_record/compare/0482a489a1f66bce5bf9b33237105055da47b8e9...rails-3.0)

**Closed issues:**

- Serialize value field and accent [\#10](https://github.com/svenfuchs/i18n-active_record/issues/10)

**Merged pull requests:**

- Second example documentation fix [\#16](https://github.com/svenfuchs/i18n-active_record/pull/16) ([Houdini](https://github.com/Houdini))
- Compatability with rails 3.1 + documentation update [\#15](https://github.com/svenfuchs/i18n-active_record/pull/15) ([Houdini](https://github.com/Houdini))
- fix readme [\#14](https://github.com/svenfuchs/i18n-active_record/pull/14) ([avakhov](https://github.com/avakhov))
