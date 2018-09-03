#
# Be sure to run `pod lib lint PSTCustomAlertController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PSTCustomAlertController'
  s.version          = '0.1.0'
  s.summary          = 'A AlertControler base on PSTAlertController and TYAlertController, and can easy toggle between system UI and customized UI. '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A AlertControler base on PSTAlertController and TYAlertController.
PSTAlertController bring a API similar to UIAlertController AlertController, and backwards compatible to iOS 7. Will use the new shiny API when you run iOS 8. It use the iOS system UI elements. TYAlertController is also a API similar to UIAlertController AlertController, but totally use custom UI elements.I\'d like bring them together. So I enhanced PSTAlertController with custom styles, which you can just chose different sytle to swith between the system or custom UI.'

  s.homepage         = 'https://github.com/zzzworm/PSTCustomAlertController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zzzworm@gmail.com' => 'grant.zhou@ximalaya.com' }
  s.source           = { :git => 'https://github.com/zzzworm/PSTCustomAlertController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'PSTCustomAlertController/Classes/**/*'

  # s.resource_bundles = {
  #   'PSTCustomAlertController' => ['PSTCustomAlertController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Masonry'
end
