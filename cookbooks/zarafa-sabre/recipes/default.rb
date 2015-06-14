#
# Cookbook Name:: zarafa-sabredav
# Recipe:: default
#
# Copyright 2014, computerlyrik, Christian Fischer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['zarafa']['timezone'].nil?
  Chef::Application.fatal!("Set node['zarafa']['timezone'] !")
end

include_recipe 'zarafa'
include_recipe 'composer'
include_recipe 'application'

application 'zarafa-sabre' do
  path node['zarafa']['sabre']['target']
  owner node['apache']['user']
  group node['apache']['group']
  repository 'git://github.com/bokxing-it/sabre-zarafa.git'
  revision node['zarafa']['sabre']['version'] || 'master'

  mod_php_apache2 do
    webapp_template 'zarafa-sabre.conf.erb'
  end

  php do
    local_settings_file 'config.inc.php'
  end

  before_restart do
    link node['zarafa']['sabre']['root'] do
      to "#{node['zarafa']['sabre']['target']}/current"
    end

    composer_project node['zarafa']['sabre']['root'] do
      action :install
    end

    directory 'data_dir' do
      path "#{node['zarafa']['sabre']['root']}/data"
      mode 0750
      recursive true
    end

    file 'debug_file' do
      path "#{node['zarafa']['sabre']['root']}/debug.txt"
      mode 0640
    end
  end
end
