Pod::Spec.new do |s|
  s.name         = 'CachedApi'
  s.version      = '0.0.2'
  s.summary      = 'Cached Data Access API Framework.'
  s.homepage     = 'https://github.com/wegie/CachedApi'
  s.license      = 'MIT'
  s.author       = 'wegie'
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/wegie/CachedApi.git', :tag => s.version.to_s }
  s.requires_arc = true

  s.dependency 'Promise', '~> 0.0.2'

  s.subspec 'Core' do |core|
    core.source_files = 'CachedApi/**/{Api,Cache}/*.swift'
  end

  s.subspec 'HTTPRequesting' do |http|
    http.source_files = 'CachedApi/**/HTTPRequesting/*.swift'
    http.dependency 'CachedApi/Core'
    http.dependency 'AlamofireJsonData', '~> 0.0.1'
  end

end
