#
# Cookbook Name:: sogo
# Attributes:: default
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

# database
default['sogo']['db_host'] = '127.0.0.1'
default['sogo']['db_name'] = 'sogodb'
default['sogo']['db_user'] = 'sogouser'
default['sogo']['db_password'] = 'nidulans'
# web
default['sogo']['web_app_name'] = 'sogo'
default['sogo']['use_vhost'] = false
default['sogo']['use_ssl_with_vhost'] = false
default['sogo']['apache_ssl_params'] = {
  'SSLCertificateFile' => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
  'SSLCertificateKeyFile' => '/etc/ssl/private/ssl-cert-snakeoil.key',
  '#SSLCertificateChainFile' => '??/etc/ssl/certs/ssl-cert-snakeoil.pem',
  '#SSLCACertificateFile' => '??/etc/ssl/certs/GS_AlphaSSL_CA_bundle.crt'
}
default['sogo']['web_app_dns_name'] = 'sogo.gonad.org.uk'
# mail
default['sogo']['imap_server'] = '127.0.0.1'
default['sogo']['smtp_server'] = '127.0.0.1'
# specific config intended to be used to customize SOGo config file
default['sogo']['specific_config_json'] = ""
