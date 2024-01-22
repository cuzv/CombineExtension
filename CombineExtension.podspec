Pod::Spec.new do |spec|
  spec.name                           = "CombineExtension"
  spec.version                        = "1.0.0"
  spec.summary                        = "Useful functionally extensions for CombineExt."
  spec.homepage                       = "https://github.com/cuzv/CombineExtension"
  spec.license                        = "MIT"
  spec.author                         = { "Shaw" => "cuzval@gmail.com" }
  spec.ios.deployment_target          = "12.0"
  spec.osx.deployment_target          = "10.13"
  # spec.watchos.deployment_target      = "4.0"
  # spec.tvos.deployment_target         = "12.0"
  # spec.visionos.deployment_target     = "1.0"
  spec.source                         = { :git => "https://github.com/cuzv/CombineExtension.git", :tag => "#{spec.version}" }
  spec.source_files                   = "Sources/**/*.swift"
  spec.requires_arc                   = true
  spec.swift_versions                 = '5'
  spec.dependency 'Infra'
  spec.dependency 'CombineExt', '~> 1.7.0'
end
