#
# Be sure to run `pod lib lint XYHNetWorking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XYHNetWorking'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XYHNetWorking.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/13779928250@163.com/XYHNetWorking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '13779928250@163.com' => '13779928250@163.com' }
  s.source           = { :git => 'https://github.com/13779928250@163.com/XYHNetWorking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'XYHNetWorking/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XYHNetWorking' => ['XYHNetWorking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ReactiveObjC', '~> 3.1.1'
  s.dependency 'MJExtension', '~> 3.4.1'
  s.dependency 'YTKNetwork', '~> 3.0.6'
  s.dependency 'AFNetworking', '~> 4.0.1'

end
