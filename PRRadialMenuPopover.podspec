#
# Be sure to run `pod lib lint PRRadialMenuPopover.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PRRadialMenuPopover"
  s.version          = "0.1.0"
  s.summary          = "Menu of buttons that extends radially from a push point in a collection view actiated by a long press reconizer."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  PRRadialMenu is a menu of buttons that extends radially from a push point in a collection view actiated by a long press reconizer. The menu is shown after a long press. The menu adjusts spacing based off the number of buttons.  It allows users to quickly peform multiple actions on cells in a collectionview. More updates coming soon.
                       DESC

  s.homepage         = "https://github.com/pjryan93/PRRadialMenuPopover"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Patrick Ryan" => "pjryan@my.okcu.edu" }
  s.source           = { :git => "https://github.com/pjryan93/PRRadialMenuPopover.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PRRadialMenuPopover' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
