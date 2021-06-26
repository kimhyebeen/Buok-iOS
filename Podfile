# Uncomment the next line to define a global platform for your project

platform :ios, '11.0'
workspace 'Buok'

project 'Buok/HeroUI.xcodeproj'
project 'Buok/HeroCommon.xcodeproj'
project 'Buok/HeroNetwork.xcodeproj'

project 'Buok'

target 'Buok' do
  inhibit_all_warnings!
  use_frameworks!

  # Pods for Buok
  pod 'SnapKit'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'SwiftyJSON'
  pod 'SwiftLint'
  pod 'Promises'
  pod 'Pageboy'
  pod 'lottie-ios'
  pod 'KakaoSDK'
  pod 'Kingfisher'

  target 'BuokTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BuokUITests' do
    # Pods for testing
  end

end

target 'HeroUI' do
  project 'HeroUI/HeroUI'
  pod 'SnapKit'
  pod 'SwiftLint'
end

target 'HeroCommon' do
  project 'HeroCommon/HeroCommon'
  pod 'SwiftLint'
end

target 'HeroNetwork' do
  project 'HeroNetwork/HeroNetwork'
  pod 'Alamofire'
  pod 'SwiftLint'
end
