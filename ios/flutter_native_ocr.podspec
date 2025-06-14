Pod::Spec.new do |s|
  s.name             = 'flutter_native_ocr'
  s.version          = '0.1.0'
  s.summary          = 'A Flutter plugin for native OCR using Apple Vision framework and Google ML Kit.'
  s.description      = <<-DESC
A Flutter plugin that provides native OCR (Optical Character Recognition) capabilities using Apple's Vision framework on iOS and Google ML Kit on Android.
                       DESC
  s.homepage         = 'https://github.com/shrawank039/flutter_native_ocr'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Shrawan Thakur' => 'shrawank039@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.ios.deployment_target = '13.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  
  s.ios.frameworks = 'Vision'
end
