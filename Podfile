# Uncomment the next line to define a global platform for your project

platform :ios, '12.0'
workspace 'Buok'

xcodeproj 'Buok/HeroUI.xcodeproj'
xcodeproj 'Buok/HeroCommon.xcodeproj'
xcodeproj 'Buok/HeroNetwork.xcodeproj'

project 'Buok' , 'Inhouse(Debug)' => :debug, 'Sandbox(Debug)' => :debug

target 'Buok' do
  inhibit_all_warnings!
  use_frameworks!

  # Pods for Buok
  pod 'SnapKit'
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'Alamofire'
  pod 'Alamofire-SwiftyJSON'
  pod 'SwiftyJSON'
  pod 'SwiftLint'
  pod 'Promises'

  target 'BuokTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BuokUITests' do
    # Pods for testing
  end

end

target 'BuokWidgetExtension' do
  inherit! :search_paths
  use_frameworks!

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
  pod 'Alamofire-SwiftyJSON'
  pod 'SwiftLint'
end
