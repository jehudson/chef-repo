# CHANGELOG for dovecot

This file is used to list changes made in each version of `dovecot` cookbook.

## v2.0.0 (2014-10-28)

* Requires Ruby `>= 1.9.3` (**breaking change**).
* Remove deprecated `::package` recipe (**breaking change**).
* Delete existing configuration files if they are not required.
* Use the `conf_files_user` attribute for configuration file directories owner instead of a hardcoded `'root'`.
* Fix ohai `7` plugin *"`provides` unsupported operation"* warning.
* Some libraries refactored.
* `Dovecot::Auth`: remove code duplication.
* Fix all RuboCop and Foodcritic offenses.
* Add ChefSpec tests.
* Add Serverspec tests.
* Tests integrated with `should_not` gem.
* Remove *shoulds* from integration tests.
* Add some template files: Berksfile, Gemfile, Guardfile and spec_helper.
* Update kitchen.yml files.
* kitchen.yml: add forwarded ports.
* Move *test/kitchen/cookbooks* to *test/cookbooks*.
* Gemfile:
 * Use Berkshelf `3.1`.
 * Use `vagrant-wrapper` gem.
* Vagrantfile refactored and updated to work.
* Add travis.yml file.
* Homogenize license headers.
* README:
 * Fix `install_from` attribute description.
 * Badges: gemnasium, codeclimate and travis-ci.
 * Use shields.io for cookbook badge.
 * Split README file into multiple files.
 * Fix some titles capitalization.
 * Some small documentation improvements.
 * put `>=` between code quotes.
* Add LICENSE file.

## v1.0.1 (2014-10-01)

* README: Added Cookbook badge
* Fixed Ubuntu 14.04 support
* Added TODO file

## v1.0.0 (2014-04-23)

* `kitchen.cloud.yml`:
 * Use `t1.micro-ebs` instances on EC2
 * Use 512MB instances on DigitalOcean
 * `require_chef_omnibus` `true` instead of `latest`
 * Some images updated
* README: fixed some typos ([issue #7](https://github.com/onddo/dovecot-cookbook/pull/7), thanks [Jordi Llonch](https://github.com/llonchj))
* Added `from_package` recipe, `packages` recipe marked for future deprecation ([issue #8](https://github.com/onddo/dovecot-cookbook/pull/8), thanks [Jordi Llonch](https://github.com/llonchj))
* Added integration tests for IMAP protocol
* Package installation and template generation logic standardized using a `Dovecot::Conf#require?` method ([issue #9](https://github.com/onddo/dovecot-cookbook/pull/9), thanks [Jordi Llonch](https://github.com/llonchj) for the help)
 * ***Note:*** This change is ***huge***, but it is supposed to be backwards compatible
* Added Ohai 7 plugins support ([issue #10](https://github.com/onddo/dovecot-cookbook/pull/10))

## v0.3.1 (2014-03-15)

* Fixed Ubuntu-13.10 support
* README: some env variables description improved
* Avoid using EC2_SSH_KEY_PATH when there is an SSH Agent
* kitchen.yml format updated, removed driver_config key

## v0.3.0 (2014-03-13)

* Added Dovecot Ohai Plugin
* kitchen.yml: vagrant boxes updated
* Gemfile: some dependency versions updated
* Tested to work on Fedora 18, Fedora 19 and Amazon
* Add support for anvil service ([issue #5](https://github.com/onddo/dovecot-cookbook/pull/5), thanks [Johan Svensson](https://github.com/loxley))
* Auth-definitions below ldap are a hash, not an array ([issue #6](https://github.com/onddo/dovecot-cookbook/pull/6), thanks [Arnold Krille](https://github.com/kampfschlaefer))
* Protect sensitive config files from read ([issue #4](https://github.com/onddo/dovecot-cookbook/pull/4), thanks [claudex](https://github.com/claudex))

## v0.2.0 (2013-10-28)

* Dict auth support and mailbox_list_index ([issue #3](https://github.com/onddo/dovecot-cookbook/pull/3), thanks [Johan Svensson](https://github.com/loxley))

## v0.1.1 (2013-07-19)

* Typo in auth-passwdfile.conf template ([issue #2](https://github.com/onddo/dovecot-cookbook/pull/2), thanks [Trond Arve Nordheim](https://github.com/tanordheim))
* Fix typo in README.md ([issue #1](https://github.com/onddo/dovecot-cookbook/pull/1), thanks [Andreas Lappe](https://github.com/alappe)) 
* Gemfile improvements

## v0.1.0 (2013-06-08)

* Initial release of `dovecot`
