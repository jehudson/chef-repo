#
# Cookbook Name:: sogomailserver
# Recipe:: dovecot
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

group "vmail" do
  gid 5000
  action :create
end


user 'vmail' do
  home '/var/vmail'
  shell '/bin/bash'
  uid 5000
  gid 'vmail'
  action :create
end

directory '/var/vmail' do
  owner 'vmail'
  group 'vmail'
  action :create
end

package ['dovecot-imapd', 'dovecot-managesieved', 'dovecot-sieve', 'dovecot-ldap'] do

  action :install
end

template '/etc/dovecot/local.conf' do
  source 'dovecot-local.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/dovecot/dovecot-ldap.conf' do
  source 'dovecot-ldap.conf.erb'
  owner 'root'
  group 'root'
  mode '700'
end

service "dovecot" do
  action :enable
  action :reload
end
