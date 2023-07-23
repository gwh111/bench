For developing, download the whole project and setup as following:
放在和你工程同一级目录下即可：

### Podfile

To integrate bench_ios into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'bench', :path =>'../bench'
end
```

Then, run the following command:

```bash
$ pod install
```
========  

在需要的地方引入

```
import "bench.h"
```
[有目录的文档](https://gwh111.github.io/2019/10/11/bench-ios/)  
[解析文章](https://blog.csdn.net/gwh111/article/details/100700830)   
