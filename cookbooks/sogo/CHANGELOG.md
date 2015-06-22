sogo CHANGELOG
==============

0.3.8
-----
- Adjustment to work fine with Apache 2.4 or lower versions

0.3.7
-----
- Little fix in hardcode value for FQDN in template comment

0.3.6
-----
- Explicitly declared apache2 service to enable and restart it

0.3.5
-----
- Notify apache service restarting after configuring virtual host

0.3.4
-----
- Documentation is now clear in the order of inclusion of recipes

0.3.3
-----
- Single strings elements generated for sogo.conf file are now surrounded by quotes
- Added newline character at the end of beginning comments in sogo.conf file
- Change in template files to avoid unnecessary file updates when Chef runs

0.3.2
-----
- Added supported platforms in metadata.rb file

0.3.1
-----
- Minor changes
- Removed the dependency with a custom Chef cookbook used to force the updating of APT packages data; instead the inclusion of the `apt` recipe is now placed after the configuration of the SOGo APT repository so such updating is done later

0.3.0
-----
- Added the option to set SSL parameters on Apache virtual host configuration

0.2.2
-----
- Change and fix in the generation of the /etc/sogo/sogo.conf file
- Forced the updating of APT files

0.1.1
-----
- Fix in the inclusion of the deep_merge gem with a hack (the previous approach with chef_gem actually did not work)

0.1.0
-----
- Working version

0.1.0
-----
- First attempt
