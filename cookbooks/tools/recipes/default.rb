#
# Cookbook Name:: tools
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['default']['tools'].each do |pkg|
  package pkg
end
