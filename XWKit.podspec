Pod::Spec.new do |s|
  s.name             = "XWKit"
  s.version          = "0.0.8"
  s.summary          = "一个简单的Kit框架。"
  s.description      = <<-DESC
                       一个简单的框架，如果您希望可以下载使用。
                       DESC

  s.homepage         = "https://github.com/shnuzxw/XWKit"
  s.license          = 'MIT'
  s.author           = { "shnuzxw" => "weixiao08@qq.com" }
  s.source           = { :git => "https://github.com/shnuzxw/XWKit.git", :branch => s.version }
  s.platform     = :ios, '8.0'
  s.requires_arc = true

#s.source_files = 'XWKit/Classes/**/*'
# s.resource_bundles = {
#   'XWKit' => ['Pod/Assets/*.png']
# }
# s.public_header_files = 'XWKit/Classes/**/*.h'
  s.subspec 'XWEnvObserver' do |eo|
      eo.source_files = 'XWKit/Classes/XWEnvObserver/*.{h,m}'
      eo.public_header_files = 'XWKit/Classes/XWEnvObserver/*.h'
  end

  s.subspec 'Manager' do |manager|
      manager.source_files = 'XWKit/Classes/Manager/**/*.{h,m}'
      manager.public_header_files = 'XWKit/Classes/Manager/**/*.h'
      manager.frameworks = 'MapKit'
      manager.dependency 'PNChart'
      manager.dependency 'JBChartView'
      manager.dependency 'BEMSimpleLineGraph'
  end

  s.subspec 'Utility' do |ut|
      ut.source_files = 'XWKit/Classes/Utility/**/*.{h,m}'
      ut.public_header_files = 'XWKit/Classes/Utility/**/*.h'
  end

  s.subspec 'Category' do |cat|
      cat.source_files = 'XWKit/Classes/Categories/**/*.{h,m}'
      cat.public_header_files = 'XWKit/Classes/Categories/**/*.h'
      cat.frameworks = 'UIKit'
      cat.dependency 'MBProgressHUD'
      cat.dependency 'DZNEmptyDataSet'
      cat.dependency 'MJRefresh'
  end
    s.dependency 'AFNetworking'
end
