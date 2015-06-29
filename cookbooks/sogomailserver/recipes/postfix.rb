#
# Cookbook Name:: sogomailserver
# Recipe:: postfix
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package ['postfix', 'postfix-ldap'] do

  action :install
end

template '/etc/postfix/main.cf' do
  source 'postfix-main.cf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/mailname' do
  source 'mailname.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/postfix/master.cf' do
  source 'postfix-master.cf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/postfix/ldap_aliases.cf' do
  source 'postfix-ldap_aliases.cf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service "postfix" do
  action :enable
  action :reload
end
