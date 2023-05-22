Pod::Spec.new do |spec|

spec.name  = 'PODNAME'
spec.version = '1.0.0'
spec.summary = 'summary'
spec.license = { :type => 'MIT' }
spec.author = { 'PODAUTHOR' => 'email' }
spec.homepage = 'https://github.com/gwh111/bench_ios'
spec.ios.deployment_target  = '7.0'
spec.source = { :git => 'PODSOURCE.git', :tag => "#{spec.name}"+"-"+"#{spec.version}" }
spec.source_files = 'Libs/PODNAME/PODNAME/PODNAME/PODNAME/**/*.{h,m}'
spec.dependency 'bench_ios'

end
