#
#  Be sure to run `pod spec lint MagnifyingView.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "MagnifyingView"
  s.version      = "0.0.1"
  s.summary      = "Magnifying Glass view for iOS."

  s.description  = <<-DESC
  A Magnifying Glass view for iOS.
                   DESC

  s.homepage     = "https://github.com/JyHu/MagnifyingView"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "JyHu" => "auu.aug@gmail.com" }

  s.source       = { :git => "https://github.com/JyHu/MagnifyingView.git", :tag => "0.0.1" }

  s.ios.deployment_target = '8.0'

  s.source_files  = "MagnifyingView/*.{h,m}"
 

end
