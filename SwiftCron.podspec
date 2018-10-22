Pod::Spec.new do |s|
  s.name             = "SwiftCron"
  s.version          = "0.4.8"
  s.summary          = "Cron expression parser."


  s.description      = <<-DESC
A cron expression parser written in Swift that can take a cron string and give you the next run date and time specified in the string.
                       DESC

  s.homepage         = "https://github.com/TheCodedSelf/SwiftCron"
  s.license          = 'MIT'
  s.author           = { "Keegan Rush" => "thecodedself@gmail.com" }
  s.source           = { :git => "https://github.com/TheCodedSelf/SwiftCron.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://twitter.com/RushKeegan'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/**/*'
end
