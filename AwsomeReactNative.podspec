#
#  Be sure to run `pod spec lint AwsomeReactNative.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1'

Pod::Spec.new do |s|
  
  s.name         = 'AwsomeReactNative'
  s.version      = '0.0.6'
  s.summary      = "It's an awsome reactnative project."
  s.description  = <<-DESC
  It's an awsome reactnative project. I try to put react native in a separate project.
  DESC
  s.homepage     = 'https://github.com/wuqiuhao/AwsomeReactNative'
  s.license      = 'MIT'

  s.author             = { 'wuqiuhao' => 'wqiuhao@gmail.com' }
  s.source       = { :git => 'https://github.com/wuqiuhao/AwsomeReactNative.git', :tag => "#{s.version}" }
  s.default_subspec = 'yoga', 'Core', 'CxxBridge', 'DevSupport', 'RCTWebSocket', 'RCTText', 'RCTAnimation', 'RCTImage'
  s.platform    = :ios, '9.0'
  s.module_name  = 'React'
  s.swift_version = '4.1'
#  s.source_files  = 'Classes', 'Classes/**/*.{swift}'
  s.pod_target_xcconfig = {
      'CLANG_CXX_LANGUAGE_STANDARD' => 'c++14',
      'OTHER_LDFLAGS' => '-ObjC',
      'HEADER_SEARCH_PATHS' => '\'$(PODS_TARGET_SRCROOT)/node_modules/react-native/ReactCommon\' \'$(PODS_ROOT)/Folly\' \'$(PODS_ROOT)/boost-for-react-native\' \'$(PODS_ROOT)/DoubleConversion\''
  }
  
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  
  # if debug you need dependency this module
  s.subspec 'NodeModule' do |ss|
      ss.source_files         = 'node_modules/react-native/**/*.{js,json}',
      							            'package.json'
      ss.exclude_files        = 'node_modules/react-native/local-cli/templates/**/*'
  end
  
  s.subspec 'yoga' do |ss|
      ss.source_files         = 'node_modules/react-native/ReactCommon/yoga/**/*.{h,c}'
  end
  
  s.subspec 'Core' do |ss|
      ss.dependency             'AwsomeReactNative/yoga'
      ss.source_files         = 'node_modules/react-native/React/**/*.{c,h,m,mm,S}'
      ss.exclude_files        =
                                '**/__tests__/*',
                                'IntegrationTests/*',
                                'node_modules/react-native/React/DevSupport/*',
                                'node_modules/react-native/React/Inspector/*',
                                'node_modules/react-native/ReactCommon/yoga/*',
                                'node_modules/react-native/React/Cxx*/*',
                                'node_modules/react-native/React/Base/RCTBatchedBridge.mm',
                                'node_modules/react-native/React/Executors/*'
      ss.ios.exclude_files    = 'node_modules/react-native/React/**/RCTTVView.*'
      ss.header_dir           = 'node_modules/react-native/React'
      ss.framework            = 'JavaScriptCore'
      ss.libraries            = 'stdc++'
  end
  
  s.subspec 'BatchedBridge' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.dependency             'AwsomeReactNative/cxxreact_legacy'
      ss.source_files         = 'node_modules/react-native/React/Base/RCTBatchedBridge.mm',
      'node_modules/react-native/React/Executors/*'
  end
  
  s.subspec 'CxxBridge' do |ss|
      ss.dependency             'Folly', '2016.09.26.00'
      ss.dependency             'AwsomeReactNative/Core'
      ss.dependency             'AwsomeReactNative/cxxreact'
      ss.compiler_flags       = folly_compiler_flags
      ss.private_header_files = 'node_modules/react-native/React/Cxx*/*.h'
      ss.source_files         = 'node_modules/react-native/React/Cxx*/*.{h,m,mm}'
  end
  
  s.subspec 'DevSupport' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.dependency             'AwsomeReactNative/RCTWebSocket'
      ss.source_files         = 'node_modules/react-native/React/DevSupport/*',
                                'node_modules/react-native/React/Inspector/*'
  end
  
  s.subspec 'jschelpers_legacy' do |ss|
      ss.source_files         = 'node_modules/react-native/ReactCommon/jschelpers/{JavaScriptCore,JSCWrapper,InspectorInterfaces}.{cpp,h}',
                                'node_modules/react-native/ReactCommon/jschelpers/systemJSCWrapper.cpp'
      ss.private_header_files = 'node_modules/react-native/ReactCommon/jschelpers/{JavaScriptCore,JSCWrapper,InspectorInterfaces}.h'
      ss.framework            = 'JavaScriptCore'
  end
  
  s.subspec 'cxxreact_legacy' do |ss|
      ss.dependency             'AwsomeReactNative/jschelpers_legacy'
      ss.source_files         = 'node_modules/react-native/ReactCommon/cxxreact/{JSBundleType,oss-compat-util}.{cpp,h}'
      ss.private_header_files = 'node_modules/react-native/ReactCommon/cxxreact/{JSBundleType,oss-compat-util}.h'
  end
  
  s.subspec 'jschelpers' do |ss|
      ss.dependency             'Folly', '2016.09.26.00'
      ss.dependency             'AwsomeReactNative/PrivateDatabase'
      ss.compiler_flags       = folly_compiler_flags
      ss.source_files         = 'node_modules/react-native/ReactCommon/jschelpers/*.{cpp,h}'
      ss.private_header_files = 'node_modules/react-native/ReactCommon/jschelpers/*.h'
      ss.framework            = 'JavaScriptCore'
  end
  
  s.subspec 'PrivateDatabase' do |ss|
      ss.source_files         = 'node_modules/react-native/ReactCommon/privatedata/*.{cpp,h}'
      ss.private_header_files = 'node_modules/react-native/ReactCommon/privatedata/*.h'
  end
  
  s.subspec 'cxxreact' do |ss|
      ss.dependency             'AwsomeReactNative/jschelpers'
      ss.dependency             'boost-for-react-native', '1.63.0'
      ss.dependency             'Folly', '2016.09.26.00'
      ss.compiler_flags       = folly_compiler_flags
      ss.source_files         = 'node_modules/react-native/ReactCommon/cxxreact/*.{cpp,h}'
      ss.exclude_files        = 'node_modules/react-native/ReactCommon/cxxreact/SampleCxxModule.*'
      ss.private_header_files = 'node_modules/react-native/ReactCommon/cxxreact/*.h'
  end
  
  s.subspec 'ART' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/ART/**/*.{h,m}'
  end
  
  s.subspec 'RCTActionSheet' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/ActionSheetIOS/*.{h,m}'
  end
  
  s.subspec 'RCTAnimation' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/NativeAnimation/{Drivers/*,Nodes/*,*}.{h,m}'
      ss.header_dir           = 'RCTAnimation'
  end
  
  s.subspec 'RCTBlob' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/Blob/*.{h,m,mm}'
      ss.preserve_paths       = 'node_modules/react-native/Libraries/Blob/*.js'
  end
  
  s.subspec 'RCTCameraRoll' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.dependency             'AwsomeReactNative/RCTImage'
      ss.source_files         = 'node_modules/react-native/Libraries/CameraRoll/*.{h,m}'
  end
  
  s.subspec 'RCTGeolocation' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/Geolocation/*.{h,m}'
  end
  
  s.subspec 'RCTImage' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.dependency             'AwsomeReactNative/RCTNetwork'
      ss.source_files         = 'node_modules/react-native/Libraries/Image/*.{h,m}'
  end
  
  s.subspec 'RCTNetwork' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/Network/*.{h,m,mm}'
  end
  
  s.subspec 'RCTPushNotification' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/PushNotificationIOS/*.{h,m}'
  end
  
  s.subspec 'RCTSettings' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/Settings/*.{h,m}'
  end
  
  s.subspec 'RCTText' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/Text/**/*.{h,m}'
  end
  
  s.subspec 'RCTVibration' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/Vibration/*.{h,m}'
  end
  
  s.subspec 'RCTWebSocket' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.dependency             'AwsomeReactNative/RCTBlob'
      ss.dependency             'AwsomeReactNative/fishhook'
      ss.source_files         = 'node_modules/react-native/Libraries/WebSocket/*.{h,m}'
  end
  
  s.subspec 'fishhook' do |ss|
      ss.header_dir           = 'fishhook'
      ss.source_files         = 'node_modules/react-native/Libraries/fishhook/*.{h,c}'
  end
  
  s.subspec 'RCTLinkingIOS' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.source_files         = 'node_modules/react-native/Libraries/LinkingIOS/*.{h,m}'
  end
  
#  s.subspec 'RCTTest' do |ss|
#      ss.dependency             'AwsomeReactNative/Core'
#      ss.source_files         = 'node_modules/react-native/Libraries/RCTTest/**/*.{h,m}'
#      ss.frameworks           = 'XCTest'
#  end
  
  s.subspec '_ignore_me_subspec_for_linting_' do |ss|
      ss.dependency             'AwsomeReactNative/Core'
      ss.dependency             'AwsomeReactNative/CxxBridge'
  end
end
