#
# Cookbook Name:: sogomailserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe = "apt"
include_recipe = "httpd"

apt_repository 'inverse' do
  uri   'http://inverse.ca/ubuntu'
  distribution 'trusty'
  components ['trusty']
  keyserver 'keys.gnupg.net'
  key     '0x810273C4'
end

package ['acl', 'attr', 'samba', 'samba-common-bin'] do

  action :install
end

template '/etc/samba/smb.conf' do
  source 'smb.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end



template '/run/resolvconf/resolv.conf' do
  source 'resolv.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service "smbd" do
  action [:enable, :start]

end

package ['openchangeserver', 'sogo-openchange', 'openchangeproxy', 'openchange-ocsmanager', 'openchange-rpcproxy', 'python-mysqldb'] do
  action :install
end

# Install Sogo

package ['sogo', 'sope4.9-gdl1-mysql',  'sogo-activesync'] do
  action :install
end
include_recipe = 'sogomailserver::database'

template '/etc/sogo/sogo.conf' do
  source 'sogo.conf.erb'
  owner 'root'
  group 'sogo'
  mode '0755'
end



httpd_config 'sogo' do
  instance 'sogo'
  source 'sogo.gonad.org.uk.conf.erb'

end




httpd_module 'proxy' do
  instance 'sogo'
  action :create
end

httpd_module 'proxy_http' do
  instance 'sogo'
  action :create
end

httpd_module 'headers' do
  instance 'sogo'
  action :create
end

httpd_module 'rewrite' do
  instance 'sogo'
  action :create
end

httpd_module 'reqtimeout' do
  instance 'sogo'

  action :create
  notifies :restart, 'httpd_service[sogo]'
end

httpd_service 'sogo' do

  action [:create, :start]
end
