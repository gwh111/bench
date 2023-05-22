# PM2
Pods Manager  

## 一、安装组件
1. 使用Cornerstone/GitHub客户端 checkout项目
2. 在右测+项目/组件 工程到项目/组件 列表，选择整个项目外面的文件夹
3. 在左侧更新组件列表，从组件市场选择组件+-到列表
4. 点击添加更新podfile
5. 安装

## 二、更新组件
1. 用Cornerstone/GitHub客户端  checkout组件代码
2. 用Xcode编写组件新版代码，用Cornerstone/GitHub客户端 提交代码！
3. 在右侧+组件工程到组件列表
4. 修改版本号，回车
5. 添加示例code
6. 提交
更新组件市场即可查看提交版本

## 三、新建xxx组件
1. 新建xxx文件夹
2. Xcode新建项目到xxx文件夹内，目录如下，目的是为了使用时可以从ccs.xxx 获取实例
```
├── xxx.xcodeproj
├── ...
├── xxx
│   ├── AppDelegate.h
│   ├── ...
│   ├── xxx
│   │   ├── ccs+xxx.h
│   │   ├── ccs+xxx.m
│   │   ├── xxxLib 或 xxx
│   │   ├── ...
```
3. 使用Cornerstone/GitHub客户端  提交代码，Pod文件夹不要提交！（可以用.gitignore）
4. 添加示例code
5. 提交
更新组件市场即可查看提交版本

## 注意：手动编写podfile和podspec时严格按照默认格式
Error：*fatal: could not read Username for 'https://github.com': Device not configured*  
使用GitHub作为仓库时出现该错误可以打开终端手动推送一次 'git push origin master'，然后输入用户名密码。  
或百度该错误找到.git配置文件配置账户  

Error：*/bin/bash: /usr/local/bin/pod: No such file or directory*
sudo gem install -n /usr/local/bin cocoapods
