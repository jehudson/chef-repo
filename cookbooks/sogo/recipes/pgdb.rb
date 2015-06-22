#
# Cookbook Name:: sogo
# Recipe:: pgdb
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

##
# PostgreSQL database configuration
##

include_recipe "postgresql::server"
include_recipe "postgresql::ruby"
include_recipe "database"

postgresql_connection_info = {
  :host     => node['sogo']['db_host'],
  :port     => node['postgresql']['config']['port'],
  # TODO: attribute to generalize a privileged username
  :username => 'postgres',
  # TODO: attribute to generalize a privileged password
  :password => node['postgresql']['password']['postgres'],
}

postgresql_database_user node['sogo']['db_user'] do
  connection postgresql_connection_info
  password node['sogo']['db_password']
  action :create
end

postgresql_database node['sogo']['db_name'] do
  connection postgresql_connection_info
  owner node['sogo']['db_user']
  action :create
end

node.default['postgresql']['pg_hba'] << {
  :comment => '# Sogo Mail Groupware User',
  :type => 'host',
  :db => node['sogo']['db_name'],
  :user => node['sogo']['db_user'],
  :addr => node['sogo']['db_host'] + "/32",
  :method => 'md5'
}

package 'sope4.9-gdl1-postgresql'
