#  
#  Be sure to run `pod spec lint TestPodSpec.podspec' to ensure this is a  
#  valid spec and to remove all comments including this before submitting the spec.  
#  
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html  
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/  
#  
  
Pod::Spec.new do |s|  
  
  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  These will help people to find your library, and whilst it  
  #  can feel like a chore to fill in it's definitely to your advantage. The  
  #  summary should be tweet-length, and the description more in depth.  
  #  
  
  s.name         = "FFNetwork"
  s.version      = "1.0"
  s.summary      = ""
  
  # This description is used to generate tags and improve search results.  
  #   * Think: What does it do? Why did you write it? What is the focus?  
  #   * Try to keep it short, snappy and to the point.  
  #   * Write the description between the DESC delimiters below.  
  #   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description  = <<-DESC  
                   DESC  
  
  s.homepage     = "https://github.com/kingundertree/FFNetworking"
  # s.screenshots  = ""  
  
  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  Licensing your code is important. See http://choosealicense.com for more info.  
  #  CocoaPods will detect a license file if there is a named LICENSE*  
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.  
  #  
  
    s.license      = "MIT (example)"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }  
  
  
  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  Specify the authors of the library, with email addresses. Email addresses  
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also  
  #  accepts just a name if you'd rather not provide an email address.  
  #  
  #  Specify a social_media_url where others can refer to, for example a twitter  
  #  profile URL.  
  #  
  
  s.author             = { "徐山" => "kingundertree@163.com" }
  # Or just: s.author    = ""  
  # s.authors            = { "" => "" }  
  # s.social_media_url   = "http://twitter.com/"  
  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  If this Pod runs only on iOS or OS X, then specify the platform and  
  #  the deployment target. You can optionally include the target after the platform.  
  #  
  
  s.description  = ""
  s.ios.deployment_target = '6.0'
  s.platform     = :ios, '6.0'

  # s.platform     = :ios  
  # s.platform     = :ios, "5.0"  
  
  #  When using multiple platforms  
  # s.ios.deployment_target = "5.0"  
  # s.osx.deployment_target = "10.7"  
  # s.watchos.deployment_target = "2.0"  
  # s.tvos.deployment_target = "9.0"  
  
  
  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  Specify the location from where the source should be retrieved.  
  #  Supports git, hg, bzr, svn and HTTP.  
  #  
  
  s.source       = { :git => "https://github.com/kingundertree/FFNetworking.git" }
  
  
  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  CocoaPods is smart about how it includes source code. For source files  
  #  giving a folder will include any swift, h, m, mm, c & cpp files.  
  #  For header files it will include any header in the folder.  
  #  Not including the public_header_files will make all headers public.  
  #  
  
  s.source_files  = 'FFNetwork', 'FFNetwork/*.{h,m}'
  s.exclude_files = "FFNetwork"  
  
  s.subspec 'Assist' do |ss|
      ss.source_files = 'FFNetwork/Assist/*.{h,m}'
  end

  s.subspec 'Category' do |ss|
      ss.source_files = 'FFNetwork/Category/*.{h,m}'
      ss.frameworks = 'Security'
  end

  s.subspec 'Components' do |ss|
      ss.source_files = 'FFNetwork/Components/*.{h,m}'
      ss.frameworks = 'SystemConfiguration'
  end

  s.subspec 'Debug' do |ss|
      ss.source_files = 'FFNetwork/Debug/*.{h,m}'
  end

  s.subspec 'FFNetService' do |ss|
      ss.source_files = 'FFNetwork/FFNetService/*.{h,m}'

      ss.subspec 'ServiceConfig' do |sss|
          sss.source_files = 'FFNetwork/FFNetService/ServiceConfig/*.{h,m}'
      end
  end

  s.subspec 'FFResponse' do |ss|
      ss.source_files = 'FFNetwork/FFResponse/*.{h,m}'
  end  

  s.subspec 'FFSignatureGenerator' do |ss|
      ss.source_files = 'FFNetwork/FFSignatureGenerator/*.{h,m}'
  end  

  # s.public_header_files = "Classes/**/*.h"  
  
  
  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  A list of resources included with the Pod. These are copied into the  
  #  target bundle with a build phase script. Anything else will be cleaned.  
  #  You can preserve files from being cleaned, please don't preserve  
  #  non-essential files like tests, examples and documentation.  
  #  
  
  # s.resource  = "icon.png"  
  # s.resources = "Resources/*.png"  
  
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"  
  
  
  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  Link your library with frameworks, or libraries. Libraries do not include  
  #  the lib prefix of their name.  
  #  
  
  # s.framework  = "SomeFramework"  
  # s.frameworks = "SomeFramework", "AnotherFramework"  
  
  # s.library   = "iconv"  
  # s.libraries = "iconv", "xml2"  
  
  
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #  
  #  
  #  If your library depends on compiler flags you can set them in the xcconfig hash  
  #  where they will only apply to your library. If you depend on other Podspecs  
  #  you can include multiple dependencies to ensure it works.  
  
  #   
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }  
  # s.dependency "JSONKit", "~> 1.4"  
  
end