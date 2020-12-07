Pod::Spec.new do |spec|
  spec.name                  = 'ProductHunt'
  spec.version               = '1.0.4'
  spec.license               = { :type => "MIT", :file => "LICENSE" }
                               
  spec.homepage              = 'https://www.producthunt.com'
  spec.author                = { 'François Boulais' => 'francois@appcraftstudio.com' }
  spec.social_media_url      = 'https://twitter.com/frboulais'

  spec.summary               = 'Product Hunt badge for iOS'
  spec.source                = { :git => 'https://github.com/appcraftstudio/producthunt.git', :tag => "#{spec.version}" }
  
  spec.ios.deployment_target = '11.0'
  spec.platform              = :ios, '11.0'
  spec.swift_version         = '5.0'

  spec.source_files          = 'Sources/**/*.swift', 'Bundle.swift'
  spec.resources             = 'Sources/**/Resources/*'

  spec.ios.framework         = 'UIKit', 'WebKit', 'SwiftUI'
  
  spec.test_spec 'ProductHuntTests' do |test_spec|
    test_spec.source_files   = 'Tests/ProductHuntTests/*.{swift}'
  end
end
