# encoding: UTF-8
#
# Cookbook Name:: postfix-dovecot
# Recipe:: default
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2013 Onddo Labs, SL. (www.onddo.com)
# License:: Apache License, Version 2.0
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

include_recipe 'postfix-dovecot::vmail'
include_recipe 'postfix-dovecot::spam'
include_recipe 'postfix-dovecot::postfix'
include_recipe 'postfix-dovecot::postfixadmin'
include_recipe 'postfix-dovecot::dovecot'

node.default['postfix-dovecot']['postmaster_address'] = 'postmaster@gonad.org.uk'
node.default['postfix-dovecot']['hostname'] = 'sogo.gonad.org.uk'

include_recipe 'postfix-dovecot::default'

postfixadmin_admin 'admin@gonad.org.uk' do
  password 'nidulans'
  action :create
end

postfixadmin_domain 'gonad.org.uk' do
  login_username 'admin@gonad.org.uk'
  login_password 'nidulans'
end
