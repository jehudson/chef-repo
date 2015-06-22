name             'webmin'
maintainer       'Folklore'
maintainer_email 'dev@atelierfolklore.ca'
license          'MIT'
description      'Installs webmin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

supports 'debian'
supports 'ubuntu'
# supports 'centos'

depends 'apt', '~> 2.7.0'
# depends 'yum', '~> 3.6.1'

recipe 'webmin', 'Installs webmin'
