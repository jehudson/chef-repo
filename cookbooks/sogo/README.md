sogo Cookbook
=============
This cookbook installs and configures SOGo, an open source groupware server solution.

Requirements
------------

#### Packages

- `sogo` - main package of the solution.
- `sope4.9-gdl1-postgresql` - postgresql connector for SOPE's fork of the GNUstep database libraries.

#### Cookbooks

- `apache2`
- `apt`
- `database`
- `postgreql`

#### Platforms

For now just Debian or Ubuntu. Other Linux based distributions where SOGo works could be supported with some adaptations

#### Testing

Only manual testing has be done

Attributes
----------

- `node['sogo']['db_host']` - server host for SOGo database
- `node['sogo']['db_name']` - name of SOGo database
- `node['sogo']['db_user']` - user to connect to SOGo database
- `node['sogo']['db_password']` - password to connect to SOGo database
- `node['sogo']['web_app_name']` - name to use when creating virtual host file for Apache
- `node['sogo']['use_vhost']` - if true a new virtual host file will be created, if false a file within /etc/apache2/conf.d/ will be created and it's assumed that will work with the existing default virtual host of Apache
- `node['sogo']['web_app_dns_name']` - DNS name to access to the SOGo installation, when using a virtual host
- `node['sogo']['imap_server']` - address of IMAP server that SOGo will connect to
- `node['sogo']['smtp_server']` - address of SMTP server that SOGo will connect to
- `node['sogo']['specific_config_json']` - complementary configuration to get a working SOGo installation. It's specific for each deployment scenario and it's empty by default

Usage
-----
#### sogo::default

To work with a PostgreSQL database for SOGo and the default recipe, some attributes must be set and then include the recipes. A simple example configuration authenticating via LDAP or via SQL will look like this:

```
node.default['sogo']['specific_config_json'] = <<-EOH
{
  "SOGoLanguage": "Spanish",
  "SOGoTimeZone": "America/Caracas",
  "SOGoPageTitle": "My SOGo",
  "SOGoEnableDomainBasedUID": true,
  "domains": {
    "myLdap": {
      "SOGoMailDomain": "yourdomainhere.com",
      "SOGoUserSources": [{
        "id": "myldapId",
        "type": "ldap",
        "CNFieldName": "cn",
        "UIDFieldName": "uid",
        "IDFieldName": "mail",
        "bindFields": ["uid", "mail"],
        "baseDN": "dc=yourdomainhere,dc=com",
        "bindDN": "cn=some_read_only_connection_user,dc=yourdomainhere,dc=com",
        "bindPassword": "a_very_hard_password_that_is_unguessable",
        "canAuthenticate": true,
        "IMAPLoginFieldName": "mail",
        "displayName": "Shared AddressBook",
        "hostname": "ldap://your_ldap_server_host_here:your_ldap_server_port_here",
        "isAddressBook": true
      }]
    },
    "sqlDomains": {
      "SOGoUserSources": [{
        "id": "sqlDomainsId",
        "type": "sql",
        "viewURL": "postgresql://other_connection_user:other_connection_password@other_database_server:5432/other_database_name/other_table_or_view",
        "canAuthenticate": true,
        "isAddressBook": true,
        "displayName": "Another Shared AddressBook",
        "userPasswordAlgorithm": "SHA"
      }]
    }
  }
}
EOH

node.default['sogo']['web_app_dns_name'] = 'your_real_sogo_domain_here.com'
node.default['sogo']['use_vhost'] = true

# order is important: default recipe is needed before pgdb to configure APT repository for SOGo
include_recipe "sogo::default"
include_recipe "sogo::pgdb"
```

Note that the value of `node.default['sogo']['specific_config_json']` will be merged with the hardcoded values of `templates/default/sogo_base_config.json.erb`. In that merging the specific values have higher precedence, so for example, to use another SMTP server just include this value to `node.default['sogo']['specific_config_json']`:

```json
node.default['sogo']['specific_config_json'] = <<-EOH
{
  ...,
  ...,
  "SOGoSMTPServer": "other_smtp.yourdomainhere.com",
  ...,
  ...
}
```

Contributing
------------

Use it, fork it and every improvement, comment and correction will be welcomed.

License and Authors
-------------------

* Author:: Rodolfo Castellanos: rodolfojcj at yahoo.com

* Copyright:: 2014, OpenSinergia

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
