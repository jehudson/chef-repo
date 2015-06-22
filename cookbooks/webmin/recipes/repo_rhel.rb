yum_repository 'webmin' do
    description "Webmin Distribution Neutral"
    baseurl "http://download.webmin.com/download/yum"
    mirrorlist "http://download.webmin.com/download/yum/mirrorlist"
    gpgkey 'http://www.webmin.com/jcameron-key.asc'
    action :create
end
