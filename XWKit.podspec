#
# Be sure to run `pod lib lint XWKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "XWKit"
  s.version          = "0.0.1"
  s.summary          = "一个简单的Kit框架。"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       一个简单的框架，如果您希望可以下载使用。
                       DESC

  s.homepage         = "https://github.com/shnuzxw/XWKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "shnuzxw" => "weixiao08@qq.com" }
  s.source           = { :git => "https://github.com/shnuzxw/XWKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

#s.source_files = 'Pod/Classes/**/*'
# s.resource_bundles = {
#   'XWKit' => ['Pod/Assets/*.png']
# }
  s.subspec 'EnvObserver' do |envObserver|
      envObserver.source_files = 'Pod/Classes/EnvObserver/*.{h,m}'
      envObserver.public_header_files = 'Pod/Classes/EnvObserver/*.h'
      envObserver.dependency 'AFNetworking'
  end

  s.subspec 'Manager' do |manager|
      manager.source_files = 'Pod/Classes/Manager/**/*.{h,m}'
      manager.public_header_files = 'Pod/Classes/Manager/**/*.h'
      manager.frameworks = 'MapKit'
      manager.dependency 'PNChart'
      manager.dependency 'JBChartView'
      manager.dependency 'BEMSimpleLineGraph'
  end

  s.subspec 'Utility' do |utility|
      utility.source_files = 'Pod/Classes/Utility/**/*.{h,m}'
      utility.public_header_files = 'Pod/Classes/Utility/**/*.h'
  end

  s.subspec 'Category' do |category|
      category.source_files = 'Pod/Classes/Categories/**/*.{h,m}'
      category.public_header_files = 'Pod/Classes/Categories/**/*.h'
      category.frameworks = 'UIKit'
      category.dependency 'MBProgressHUD'
  end



  # s.public_header_files = 'Pod/Classes/**/*.h'

end
