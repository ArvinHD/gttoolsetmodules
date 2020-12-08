#
# Be sure to run `pod lib lint GTToolsetModules.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GTToolsetModules'
  s.version          = '0.1.71'
  #s.summary          = 'iOS - 项目基础组件库'
  s.summary          = 'basemodule'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#   s.description      = <<-DESC
#   包含数据加密组件、扩展配置组件集合、宏定义组件集合、网络请求基础框架
#                        DESC
s.description      = <<-DESC
  basemoduleincludesecureexternmacronetwork
                       DESC

  s.homepage         = 'https://github.com/ArvinHD/gttoolsetmodules.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xuchunyu-caibaoshuo' => 'xuchunyu@caibaoshuo.com' }
  s.source           = { :git => 'https://github.com/ArvinHD/gttoolsetmodules.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  #s.source_files = 'GTToolsetModules/Classes/**/*'

  #AES
  s.subspec 'AES' do |aes|
      aes.source_files = 'GTToolsetModules/Classes/AES/*.{h,m}'
      aes.dependency 'YYKit'
  end
  
  #Factory
  s.subspec 'Factory' do |fac|
      fac.source_files = 'GTToolsetModules/Classes/Factory/*.{h,m}'
      fac.dependency 'GTToolsetModules/Macros'
      fac.dependency 'YYKit'
  end
  
  #Resources
  s.subspec 'Resources' do |resources|
      resources.source_files = 'GTToolsetModules/Classes/Resources/*.{h,m}'
  end
  
  #RequestURL
   s.subspec 'RequestURL' do |url|
       url.source_files = 'GTToolsetModules/Classes/RequestURL/*.{h,m}'
   end
  
  #Resources
  s.subspec 'LaunchAd' do |ad|
      ad.source_files = 'GTToolsetModules/Classes/LaunchAd/*.{h,m}'
  end
  
  #Category
    s.subspec 'Category' do |category|
        #MBProgressHUB
        category.subspec 'MBProgressHUB' do |hub|
            hub.source_files = 'GTToolsetModules/Classes/Category/MBProgressHUB/*.{h,m}'
            hub.dependency 'GTToolsetModules/Macros'
            hub.dependency 'GTToolsetModules/Resources'
            hub.dependency 'YYKit'
            hub.dependency 'MBProgressHUD', '~> 1.1.0'
            hub.dependency  'GTResourceModules'
            hub.dependency   'lottie-ios', '~> 2.5.3'
            hub.frameworks = 'CoreGraphics','AVFoundation'
        end
        #NSObject
        category.subspec 'UIView' do |view|
            view.source_files = 'GTToolsetModules/Classes/Category/UIView/*.{h,m}'
        end
        
        #NSObject
        category.subspec 'NSObject' do |obj|
            obj.source_files = 'GTToolsetModules/Classes/Category/NSObject/*.{h,m}'
        end
        
        #UIButton
        category.subspec 'UIButton' do |btn|
            btn.source_files = 'GTToolsetModules/Classes/Category/UIButton/*.{h,m}'
        end
        
        #UIViewController
        category.subspec 'UIViewController' do |vc|
            vc.source_files = 'GTToolsetModules/Classes/Category/UIViewController/*.{h,m}'
        end
        
        #UICollectionView
        category.subspec 'UICollectionView' do |collection|
            collection.source_files = 'GTToolsetModules/Classes/Category/UICollectionView/*.{h,m}'
        end
        
        #UITableView
        category.subspec 'UITableView' do |tableview|
            tableview.source_files = 'GTToolsetModules/Classes/Category/UITableView/*.{h,m}'
            tableview.dependency 'GTToolsetModules/Macros'
            tableview.dependency 'YYKit'
        end
    end
    
    #FCUUID
      s.subspec 'FCUUID' do |udid|
          udid.source_files = 'GTToolsetModules/Classes/FCUUID/*.{h,m}'
          udid.framework    = 'Foundation', 'UIKit', 'Security'
          udid.dependency 'UICKeyChainStore', '~> 2.1.0'

      end
      
      #Macros
      s.subspec 'Macros' do |macros|
          macros.source_files = 'GTToolsetModules/Classes/Macros/*.{h,m}'
      end
      
      #NetWork
      s.subspec 'NetWork' do |network|
          network.source_files = 'GTToolsetModules/Classes/NetWork/*.{h,m}'
          network.dependency 'GTToolsetModules/AES'
          network.dependency 'GTToolsetModules/Category/MBProgressHUB'
          network.dependency 'GTToolsetModules/Macros'
          network.dependency 'GTToolsetModules/FCUUID'
          network.dependency 'GTToolsetModules/RequestURL'
          network.dependency 'YYKit'
          network.dependency 'AFNetworking', '~> 3.0'
          network.dependency 'MBProgressHUD', '~> 1.1.0'
      end

   s.resource_bundles = {
     'GTToolsetModules' => ['GTToolsetModules/Assets/*.{json}']
   }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
end
