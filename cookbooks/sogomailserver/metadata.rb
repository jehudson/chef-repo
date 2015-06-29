name 'sogomailserver'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures sogomailserver'
long_description 'Installs/Configures sogomailserver'
version '0.1.0'

depends "apt"
depends 'mysql2_chef_gem', '~> 1.0.1'
depends 'mysql', '~> 6.0.22'
depends 'database', '~> 4.0.3'
depends 'httpd'
