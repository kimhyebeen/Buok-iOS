# Uncomment the next line to define a global platform for your project

platform :ios, '12.0'
workspace 'Nadam'

xcodeproj 'Nadam/HeroUI.xcodeproj'
xcodeproj 'Nadam/HeroCommon.xcodeproj'
xcodeproj 'Nadam/HeroNetwork.xcodeproj'

project 'Nadam' , 'Inhouse(Debug)' => :debug, 'Sandbox(Debug)' => :debug

target 'Nadam' do
  inhibit_all_warnings!
  use_frameworks!

  # Pods for Nadam
  pod 'SnapKit'
  pod 'Alamofire'
  pod 'Alamofire-SwiftyJSON'
  pod 'SwiftyJSON'
  pod 'SwiftLint'
  pod 'Promises'

  target 'NadamTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NadamUITests' do
    # Pods for testing
  end

end

target 'NadamWidgetExtension' do
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
