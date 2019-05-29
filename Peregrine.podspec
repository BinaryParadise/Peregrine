#
# Be sure to run `pod lib lint Peregrine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Peregrine'
  s.version          = '0.1.2'
  s.summary          = 'A short description of Peregrine.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/BinaryParadise/Peregrine'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rake Yang' => 'mylcode.ali@gmail.com' }
  s.source           = { :git => 'https://github.com/BinaryParadise/Peregrine.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Peregrine/Classes/**/*'

  # s.user_target_xcconfig = {'CC' => '${CCROOT}/bin/clang', 'CCROOT' => '/usr/local/opt/peregrine', 'OTHER_CFLAGS' => '$(inherited) -isysroot ${SDK_DIR} -Xclang -load -Xclang ${CCROOT}/lib/PeregrinePlugin.dylib -Xclang -add-plugin -Xclang PeregrinePlugin -Xclang -plugin-arg-PeregrinePlugin -Xclang ${METAL_LIBRARY_OUTPUT_DIR}'}
  s.user_target_xcconfig = {'COMPILER_INDEX_STORE_ENABLE' => 'NO', 'CC' => '${CCROOT}/bin/clang', 'CCROOT' => '${HOME}/Github/llvm_xcode/Debug', 'OTHER_CFLAGS' => '$(inherited) -isysroot ${SDK_DIR} -Xclang -load -Xclang ${CCROOT}/lib/PeregrinePlugin.dylib -Xclang -add-plugin -Xclang PeregrinePlugin -Xclang -plugin-arg-PeregrinePlugin -Xclang ${METAL_LIBRARY_OUTPUT_DIR}'}
  s.pod_target_xcconfig = {'COMPILER_INDEX_STORE_ENABLE' => 'NO'}

  # s.resource_bundles = {
  #   'Peregrine' => ['Peregrine/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
