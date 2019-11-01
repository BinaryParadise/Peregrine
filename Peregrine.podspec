#
# Be sure to run `pod lib lint Peregrine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Peregrine'
  s.version          = '0.5.1'
  s.summary          = 'A short description of Peregrine.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Peregrine is a solution for iOS Application module programs.（路由框架）
                       DESC

  s.homepage         = 'https://github.com/BinaryParadise/Peregrine'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rake Yang' => 'fenglaijun@gmail.com' }
  s.source           = { :git => 'https://github.com/BinaryParadise/Peregrine.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.default_subspec = 'Plugin'

  s.subspec 'Plugin' do |ss|
    ss.source_files = 'Peregrine/**/*'
    if ENV['test'] != '1'
      ss.user_target_xcconfig = {'COMPILER_INDEX_STORE_ENABLE' => 'NO', 'CC' => '${CCROOT}/bin/clang', 'CCROOT' => '/usr/local', 'OTHER_CFLAGS' => '-Xclang -load -Xclang ${CCROOT}/lib/PeregrinePlugin.dylib -Xclang -add-plugin -Xclang PeregrinePlugin -Xclang -plugin-arg-PeregrinePlugin -Xclang ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}${WRAPPER_SUFFIX}/Peregrine.bundle'}
      ss.pod_target_xcconfig = {'COMPILER_INDEX_STORE_ENABLE' => 'NO', 'CC' => '${CCROOT}/bin/clang', 'CCROOT' => '/usr/local', 'OTHER_CFLAGS' => '-Xclang -load -Xclang ${CCROOT}/lib/PeregrinePlugin.dylib -Xclang -add-plugin -Xclang PeregrinePlugin -Xclang -plugin-arg-PeregrinePlugin -Xclang ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}${WRAPPER_SUFFIX}/Peregrine.bundle'}
    end
  end
  
  s.subspec 'LibTooling' do |ss|
      ss.source_files = 'Peregrine/**/*'
  end
  
end
