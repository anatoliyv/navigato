#
# Be sure to run `pod lib lint Navigato.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Navigato'
  s.version          = '0.3.2'
  s.summary          = 'iOS library to work with maps and navigation apps on iOS devices.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS library to work with maps and navigation apps on iOS devices. Allows you to:

 * Open navigation/map navigation app with destination point
 * Determinate what apps are installed
                       DESC

  s.homepage         = 'https://github.com/anatoliyv/navigato'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anatoliy Voropay' => 'anatoliy.voropay@gmail.com' }
  s.source           = { :git => 'https://github.com/anatoliyv/navigato.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/anatoliy_v'

  s.ios.deployment_target = '9.0'
  s.source_files = 'Navigato/Classes/**/*'
  s.frameworks = 'CoreLocation'

  # s.resource_bundles = {
  #   'Navigato' => ['Navigato/Assets/*.png']
  # }
  # s.dependency 'AFNetworking', '~> 2.3'
end
