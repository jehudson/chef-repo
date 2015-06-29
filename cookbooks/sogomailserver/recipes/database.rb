#
# Cookbook Name:: sogomailserver
# Recipe:: database
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

node.set['mysql']['server_root_password'] = 'nidulans'

# Configure the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end



# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password 'nidulans'
  action [:create, :start]
end

# Create the database instance.
mysql_database 'sogo' do
  connection(
    :host => '127.0.0.1',
    :username => 'root',
    :password => 'nidulans'
  )
  action :create
end

# Add a database user.
mysql_database_user 'sogo' do
  connection(
    :host => '127.0.0.1',
    :username => 'root',
    :password => 'nidulans'
  )
  password 'nidulans'
  database_name 'sogo'
  host '127.0.0.1'
  action [:create, :grant]
end
