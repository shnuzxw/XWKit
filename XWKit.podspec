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
    s.subspec 'EnvObserver' do |Observer|
        common.source_files = 'Pod/Classes/EnvObserver/*.{h,m}'
        common.public_header_files = 'Pod/Classes/EnvObserver/*.h'
    end

    s.subspec 'Manager' do |Manager|
        common.source_files = 'Pod/Classes/Manager/*.{h,m}'
        common.public_header_files = 'Pod/Classes/Manager/*.h'
    end


  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'AFNetworking'
  s.dependency 'MBProgressHUD'
  s.dependency 'PNChart'
  s.dependency 'JBChartView'
  s.dependency 'BEMSimpleLineGraph'

end
