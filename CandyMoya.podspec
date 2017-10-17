Pod::Spec.new do |s|

    s.name         = 'CandyMoya'
    s.version      = '0.0.4'
    s.summary      = '封装网络请求'
    s.homepage     = 'https://github.com/J-yezi/CandyMoya'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { "J-yezi" => 'yehao1020@gmail.com' }
    s.source       = { :git => 'https://github.com/J-yezi/CandyMoya.git', :tag => s.version }

    s.ios.deployment_target = '8.0'

    s.default_subspec = 'Core'

    s.subspec 'Core' do |ss|
        ss.source_files = 'Sources/CandyMoya/*.swift'
        ss.frameworks   = 'Foundation'
        ss.dependency 'Moya', '8.0.5'
    end

    s.subspec 'RxSwift' do |ss|
        ss.source_files = 'Sources/RxCandyMoya/*.swift'
        ss.dependency 'CandyMoya/Core'
        ss.dependency 'Moya/RxSwift', '8.0.5'
    end

end
