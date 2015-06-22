#
# Cookbook Name:: sogo
# Recipe:: default
#
# Copyright 2014, OpenSinergia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Resource::Template.send(:include, Sogo::Helper)
::Chef::Resource::RubyBlock.send(:include, Sogo::Helper)

apt_repository 'sogo' do
  # deb http://inverse.ca/ubuntu precise precise
  # deb http://inverse.ca/debian wheezy wheezy
  uri          "http://inverse.ca/" + node['lsb']['id'].downcase
  distribution node['lsb']['codename']
  components   [node['lsb']['codename']]
  keyserver    'keys.gnupg.net'
  key          '810273C4'
end

include_recipe "apt"

package 'sogo'

config_base_json = Chef::Config[:file_cache_path] + "/" + "sogo_base_config" + ".json"
template config_base_json do
  source 'sogo_base_config.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables({
    :db_user => node['sogo']['db_user'],
    :db_password => node['sogo']['db_password'],
    :db_host => node['sogo']['db_host'],
    :db_name => node['sogo']['db_name'],
    :imap_server => node['sogo']['imap_server'],
    :smtp_server => node['sogo']['smtp_server']
  })
end

ruby_block 'generate-sogo-config-file' do
  block do
    require 'fileutils'
    config_file = '/etc/sogo/sogo.conf'
    base_config = File.read(config_base_json)
    specific_config = node['sogo']['specific_config_json']
    plist = generate_plist(merge_json_to_hash(base_config, specific_config))
    File.open(config_file, 'w') {|f|
      f << "/*\n"
      f << "* Generated by Chef for " + node[:fqdn] + "\n"
      f << "* Local modifications will be overwritten.\n"
      f << "*/\n"
      f << "{\n"
      plist.each {|l|
        f << l + "\n"
      }
      f << "}"
    }
    FileUtils.chown('root', 'sogo', config_file)
    FileUtils.chmod(0640, config_file)
  end
end

if node['sogo']['use_vhost'] == true
  # apache virtual host
  web_app node['sogo']['web_app_name'] do
    server_name node['sogo']['web_app_dns_name']
    #docroot ???
    template "SOGo_apache_vhost.conf.erb" if node['sogo']['use_ssl_with_vhost'] == false
    if node['sogo']['use_ssl_with_vhost'] == true
      template "SOGo_apache_vhost_ssl.conf.erb"
      ssl_params node['sogo']['apache_ssl_params']
    end
    log_dir node['apache']['log_dir']
    notifies :restart, 'service[apache2]', :delayed
  end
else
  # location within a virtual host
  directory "/etc/apache2/conf.d" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
  template '/etc/apache2/conf.d/SOGo.conf' do
    source 'SOGo_apache_location.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables({
      :server_name => node['sogo']['web_app_dns_name'],
      :server_url => 'http://' + node['sogo']['web_app_dns_name']
    })
    notifies :restart, 'service[apache2]', :delayed
  end
end

include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl" if node['sogo']['use_ssl_with_vhost'] == true

# needed for SOGo, just to read the new configuration
service 'sogo' do
  action [:enable, :restart]
end

service 'apache2' do
  action [:enable, :restart]
end

node.default['sogo']['specific_config_json'] = <<-EOH
{
  "SOGoLanguage": "English",
  "SOGoTimeZone": "Europe/London",
  "SOGoPageTitle": "Gonad Mail",
  "SOGoEnableDomainBasedUID": true,
  "domains": {
    "myLdap": {
      "SOGoMailDomain": "gonad.org.uk",
      "SOGoUserSources": [{
        "id": "myldapId",
        "type": "ldap",
        "CNFieldName": "cn",
        "UIDFieldName": "uid",
        "IDFieldName": "mail",
        "bindFields": ["uid", "mail"],
        "baseDN": "ou=users,dc=gonad,dc=org,dc=uk",
        "bindDN": "cn=admin,dc=gonad,dc=org,dc=uk",
        "bindPassword": "nidulans",
        "canAuthenticate": true,
        "IMAPLoginFieldName": "mail",
        "displayName": "Shared AddressBook",
        "hostname": "ldap://127.0.0.1:389",
        "isAddressBook": true
      }]
    },
    "sqlDomains": {
      "SOGoUserSources": [{
        "id": "sqlDomainsId",
        "type": "sql",
        "viewURL": "postgresql://sogouser:nidulans@localhost:5432/sogodb/other_table_or_view",
        "canAuthenticate": true,
        "isAddressBook": true,
        "displayName": "Shared AddressBook",
        "userPasswordAlgorithm": "SHA"
      }]
    }
  }
}
EOH

node.default['sogo']['web_app_dns_name'] = 'sogo.gonad.org.uk'
node.default['sogo']['use_vhost'] = true

# order is important: default recipe is needed before pgdb to configure APT repository for SOGo
include_recipe "sogo::default"
include_recipe "sogo::pgdb"