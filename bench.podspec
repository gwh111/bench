
Pod::Spec.new do |spec|
  spec.name         = 'bench'
  spec.version      = '3.0.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/gwh111/bench'
  spec.authors      = { 'apple' => '173695508@qq.com' }
  spec.summary      = 'iOS bench tool for developer'
  spec.source       = { :git  => 'https://github.com/gwh111/bench.git' }
  spec.frameworks   = 'UIKit'  
  spec.module_name  = 'b'

  spec.ios.deployment_target  = '7.0'

  spec.source_files       = 'bench/bench/*'
  spec.resources          = 'bench/bench/bench.bundle'
  
  spec.subspec 'B' do |ss|
    ss.source_files = 'bench/bench/B/**/*'
  end
  
  spec.subspec 'Core' do |ss|
    ss.source_files = 'bench/bench/Core/**/*'
  end

  spec.subspec 'Extension' do |ss|
    ss.source_files = 'bench/bench/Extension/**/*'
  end

end
