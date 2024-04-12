Pod::Spec.new do |s|
  s.name                           = "CombineExtension"
  s.version                        = "1.0.0"
  s.summary                        = "Useful functionally extensions for CombineExt."
  s.homepage                       = "https://github.com/cuzv/CombineExtension"
  s.license                        = "MIT"
  s.author                         = { "Shaw" => "cuzval@gmail.com" }
  
  s.ios.deployment_target          = "13.0"
  s.osx.deployment_target          = "10.15"
  # s.watchos.deployment_target      = "4.0"
  # s.tvos.deployment_target         = "12.0"
  # s.visionos.deployment_target     = "1.0"
  
  s.source                         = { :git => "https://github.com/cuzv/CombineExtension.git", :tag => "#{s.version}" }
  s.source_files                   = "Sources/**/*.swift"
  s.requires_arc                   = true
  s.swift_versions                 = '5'
  
  s.resource_bundles = {
    'CombineExtension' => ['Resources/PrivacyInfo.xcprivacy']
  }

  s.dependency 'CombineExt'
  s.dependency 'CombineCocoa'
  s.dependency 'Infra'
end
