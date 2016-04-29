Pod::Spec.new do |s|
  s.name         = "CachedApi"
  s.version      = "0.0.1"
  s.summary      = "Cached Data Access API Framework."
  s.homepage     = "https://github.com/wegie/CachedApi"
  s.license      = "MIT"
  s.author       = "wegie"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/wegie/CachedApi.git", :tag => s.version.to_s }
  s.source_files = "CachedApi/**/*.swift"
  s.dependency   'Promise', '~> 0.0.2'
  s.requires_arc = true
end
