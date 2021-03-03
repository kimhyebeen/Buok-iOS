# Uncomment the next line to define a global platform for your project

platform :ios, '12.0'
workspace 'BucketList'

xcodeproj 'BucketList/HeroUI.xcodeproj'
xcodeproj 'BucketList/HeroCommon.xcodeproj'

project 'BucketList' , 'Inhouse(Debug)' => :debug, 'Sandbox(Debug)' => :debug

target 'BucketList' do
  inhibit_all_warnings!
  use_frameworks!

  # Pods for BucketList
  pod 'SnapKit'
  pod 'Alamofire'
  pod 'Alamofire-SwiftyJSON'
  pod ‘AlamofireObjectMapper’
  pod 'SwiftyJSON'
  pod 'SwiftLint'
  pod 'Promises'
  pod 'Kingfisher'

  target 'BucketListTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BucketListUITests' do
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
end
