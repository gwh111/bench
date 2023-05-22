Pod::Spec.new do |spec|

spec.name  = 'PODNAME'
spec.version = '1.0.0'
spec.summary = 'summary'
spec.license = { :type => 'MIT' }
spec.author = { 'email' => 'PODAUTHOR' }
spec.homepage = 'https://github.com/gwh111/bench_ios'
spec.ios.deployment_target  = '7.0'
spec.source = { :svn => 'PODSOURCE/PODNAME', :tag => '#{spec.version}' }
spec.source_files = 'PODNAME/PODNAME/**/*.{h,m,mm,cpp}'
spec.dependency 'bench_ios'

end
