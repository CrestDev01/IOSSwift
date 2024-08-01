# Uncomment the next line to define a global platform for your project
 platform :ios, '14.0'

target 'IOSSwift' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for IOSSwift

pod 'Alamofire'
pod 'SwiftyJSON' 
pod 'SVProgressHUD'
pod 'BRYXBanner'
pod 'IQKeyboardManagerSwift'
pod 'CropViewController'
pod 'DropDown'
end


post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "14.0"
             end
          end
      end
    end
  end
end
