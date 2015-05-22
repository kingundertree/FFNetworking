Pod::Spec.new do |s|

  s.name         = "FFNetworking"
  s.version      = "1.0"
  s.summary      = ""
  s.description  = ""
  s.ios.deployment_target = '6.0'
  s.platform     = :ios, '6.0'
  s.homepage     = "https://github.com/kingundertree/FFNetworking"
  s.license      = "MIT (example)"
  s.author             = { "徐山" => "kingundertree@163.com" }
  s.source       = { :git => "https://github.com/kingundertree/FFNetworking.git" }


  s.source_files  = 'FFNetworking', 'FFNetworking/FFNetworking/*.{h,m}'

  s.subspec 'Assist' do |ss|
      ss.source_files = 'FFNetworking/FFNetworking/Assist/*.{h,m}'
  end

  s.subspec 'Category' do |ss|
      ss.source_files = 'FFNetworking/FFNetworking/Category/*.{h,m}'
      ss.frameworks = 'Security'
  end

  s.subspec 'Components' do |ss|
      ss.source_files = 'FFNetworking/FFNetworking/Components/*.{h,m}'
      ss.frameworks = 'SystemConfiguration'
  end

  s.subspec 'Debug' do |ss|
      ss.source_files = 'FFNetworking/FFNetworking/Debug/*.{h,m}'
  end

  s.subspec 'FFNetService' do |ss|
      ss.source_files = 'FFNetworking/FFNetworking/FFNetService/*.{h,m}'

      ss.subspec 'ServiceConfig' do |sss|
          sss.source_files = 'FFNetworking/FFNetworking/FFNetService/ServiceConfig/*.{h,m}'
      end
  end

  s.subspec 'FFResponse' do |ss|
      ss.source_files = 'FFNetworking/FFNetworking/FFResponse/*.{h,m}'
  end  

  s.subspec 'FFSignatureGenerator' do |ss|
      ss.source_files = 'FFNetworking/FFNetworking/FFSignatureGenerator/*.{h,m}'
  end  

end
