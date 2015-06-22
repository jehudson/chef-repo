case node["platform_family"]
when "debian"
    include_recipe 'webmin::repo_deb'
    include_recipe 'apt::default'
when "rhel"
    include_recipe 'webmin::repo_rhel'
    include_recipe 'yum::default'
end

package [node['webmin']['package_name']]
