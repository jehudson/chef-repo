name             'zarafa-sabre'
maintainer       'computerlyrik, Christian Fischer'
maintainer_email 'chef-cookbooks@computerlyrik.de'
license          'Apache 2.0'
description      'Installs/Configures zarafa-sabredav'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'application'
depends 'application_php'
depends 'composer'
depends 'zarafa'

