#
# Be sure to run `pod lib lint XWKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "XWKit"
  s.version          = "0.0.3"
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
  s.source           = { :git => "https://github.com/shnuzxw/XWKit.git", :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

#s.source_files = 'XWKit/Classes/**/*'
# s.resource_bundles = {
#   'XWKit' => ['Pod/Assets/*.png']
# }
  s.subspec 'XWEnvObserver' do |envObserver|
      envObserver.source_files = 'XWKit/Classes/XWEnvObserver/*.{h,m}'
      envObserver.public_header_files = 'XWKit/Classes/XWEnvObserver/*.h'
  end

  s.subspec 'Manager' do |manager|
      manager.source_files = 'XWKit/Classes/Manager/**/*.{h,m}'
      manager.public_header_files = 'XWKit/Classes/Manager/**/*.h'
      manager.frameworks = 'MapKit'
      manager.dependency 'PNChart'
      manager.dependency 'JBChartView'
      manager.dependency 'BEMSimpleLineGraph'
  end

  s.subspec 'Utility' do |utility|
      utility.source_files = 'XWKit/Classes/Utility/**/*.{h,m}'
      utility.public_header_files = 'XWKit/Classes/Utility/**/*.h'
  end

  s.subspec 'Category' do |category|
      category.source_files = 'XWKit/Classes/Categories/**/*.{h,m}'
      category.public_header_files = 'XWKit/Classes/Categories/**/*.h'
      category.frameworks = 'UIKit'
      category.dependency 'MBProgressHUD'
      category.dependency 'DZNEmptyDataSet'
      category.dependency 'MJRefresh'
  end
    s.dependency 'AFNetworking'



  # s.public_header_files = 'XWKit/Classes/**/*.h'

end
