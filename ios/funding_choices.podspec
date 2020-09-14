#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint funding_choices.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'funding_choices'
  s.version          = '0.5.1'
  s.summary          = 'A flutter library to unofficially support Google Funging Choices, a google service to handle GDPR and CCPA Consent'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://pub.dev/packages/funding_choices'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'MicroPP' => 'info@micropp.net' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  
  s.dependency 'GoogleUserMessagingPlatform', '~> 1.1.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
