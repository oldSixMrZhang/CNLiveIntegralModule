#
# Be sure to run `pod lib lint CNLiveIntegralModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CNLiveIntegralModule'
  s.version          = '0.0.1'
  s.summary          = 'CNLiveIntegralModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 网家家-积分模块.
                       DESC

  s.homepage         = 'http://bj.gitlab.cnlive.com/ios-team/CNLiveIntegralModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '153993236@qq.com' => 'zhangxiaowen@cnlive.com' }
  s.source           = { :git => 'http://bj.gitlab.cnlive.com/ios-team/CNLiveIntegralModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  # s.source_files = 'CNLiveIntegralModule/Classes/**/*'
  
  # Module
  s.subspec 'Module' do |ss|
      ss.source_files = 'CNLiveIntegralModule/Classes/Module/*.{h,m}'
      ss.dependency 'CNLiveIntegralModule/Controller'
  end
  
  # Controller
  s.subspec 'Controller' do |ss|
      ss.source_files = 'CNLiveIntegralModule/Classes/Controller/*.{h,m}'
      ss.dependency 'CNLiveIntegralModule/Tools'
  end
  
  # View
  s.subspec 'View' do |ss|
      ss.source_files = 'CNLiveIntegralModule/Classes/View/*.{h,m}'
      ss.dependency 'CNLiveIntegralModule/Model'
  end
   
  # Model
  s.subspec 'Model' do |ss|
      ss.source_files = 'CNLiveIntegralModule/Classes/Model/*.{h,m}'
  end
  
  # Tools
  s.subspec 'Tools' do |ss|
      ss.source_files = 'CNLiveIntegralModule/Classes/Tools/*.{h,m}'
      ss.dependency 'CNLiveIntegralModule/View'
  end
  
  s.resource_bundles = {
    'CNLiveIntegralModule' => ['CNLiveIntegralModule/Assets/CNLiveIntegralModule.xcassets','CNLiveIntegralModule/Assets/gold_whereabouts.mp3']
  }

#  s.public_header_files = 'CNLiveIntegralModule/Classes/**/*.h'
  s.frameworks = 'UIKit', 'QuartzCore'
  # s.dependency 'AFNetworking', '~> 2.3'

  # pod
  s.dependency 'CNLiveTripartiteManagement/QMUIKit'
  s.dependency 'CNLiveTripartiteManagement/SDWebImage'
  s.dependency 'CNLiveTripartiteManagement/Masonry'
  s.dependency 'CNLiveTripartiteManagement/MJExtension'
  s.dependency 'CNLiveTripartiteManagement/MJRefresh'
  s.dependency 'CNLiveTripartiteManagement/YYKit'

  # 服务层
  s.dependency 'CNLiveServices'
  
  # 基类
  s.dependency 'CNLiveCommonClass'
  
  # 环境
  s.dependency 'CNLiveEnvironment'

  # 数据请求
  s.dependency 'CNLiveRequestBastKit'
  
  # 用户信息本地化
  s.dependency 'CNLiveUserManagement'
  
  # 用户协议
  s.dependency 'CNLiveUserAgreementManager'
  
  # 管理类
  s.dependency 'CNLiveManager'
  
  #类别
  s.dependency 'CNLiveCategory'
  
  # 
  s.dependency 'CNLiveCustomUI'
  
  # 自定义控件
  s.dependency 'CNLiveCustomControl'

end
