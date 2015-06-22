apt_repository 'webmin' do
    uri          'http://download.webmin.com/download/repository'
    distribution 'sarge'
    components   ['contrib']
    key          'http://www.webmin.com/jcameron-key.asc'
end
