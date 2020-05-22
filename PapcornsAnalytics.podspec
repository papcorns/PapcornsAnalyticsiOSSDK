
Pod::Spec.new do |spec|

  spec.name         = "PapcornsAnalytics"
  spec.version      = "1.0.1"
  spec.summary      = "Papcorns Analytics Tool iOS SDK"

  spec.description  = "Internal Papcorns Analytics Tool iOS SDK"

  spec.homepage     = "https://www.papcorns.com"


  spec.license      = { :type => "GNU", :file => "LICENSE" }


  spec.authors      = { "Kaan" => "kaan@papcorns.com" }


  spec.source       = { :git => "https://github.com/papcorns/PapcornsAnalyticsiOSSDK.git", :tag => "#{spec.version}" }


  spec.swift_version = '5.0'
  spec.ios.deployment_target  = '11.0'
  spec.source_files  = "PapcornsAnalytics/**/*"

end