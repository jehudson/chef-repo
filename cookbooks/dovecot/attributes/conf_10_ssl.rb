# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_ssl
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL. (www.onddo.com)
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

# conf.d/10-ssl.conf

default['dovecot']['conf']['ssl'] = nil
case node['platform']
when 'redhat', 'centos', 'scientific', 'fedora', 'suse', 'amazon' then
  default['dovecot']['conf']['ssl_cert'] = '</etc/pki/dovecot/certs/dovecot.pem'
  default['dovecot']['conf']['ssl_key'] =
    '</etc/pki/dovecot/private/dovecot.pem'
when 'debian'
  default['dovecot']['conf']['ssl_cert'] = '</etc/dovecot/dovecot.pem'
  default['dovecot']['conf']['ssl_key'] = '</etc/dovecot/private/dovecot.pem'
when 'ubuntu'
  if node['platform_version'].to_f >= 14.04
    default['dovecot']['conf']['ssl_cert'] = '</etc/dovecot/dovecot.pem'
    default['dovecot']['conf']['ssl_key'] = '</etc/dovecot/private/dovecot.pem'
  else
    default['dovecot']['conf']['ssl_cert'] = '</etc/ssl/certs/dovecot.pem'
    default['dovecot']['conf']['ssl_key'] = '</etc/ssl/private/dovecot.pem'
  end
else
  default['dovecot']['conf']['ssl_cert'] = '</etc/ssl/certs/dovecot.pem'
  default['dovecot']['conf']['ssl_key'] = '</etc/ssl/private/dovecot.pem'
end
default['dovecot']['conf']['ssl_key_password'] = nil
default['dovecot']['conf']['ssl_ca'] = nil
default['dovecot']['conf']['ssl_verify_client_cert'] = nil
default['dovecot']['conf']['ssl_cert_username_field'] = nil
default['dovecot']['conf']['ssl_parameters_regenerate'] = nil
default['dovecot']['conf']['ssl_cipher_list'] = nil
