//
//  b.m
//  bench
//
//  Created by gwh on 2022/1/8.
//

#import "b.h"
#import <sys/utsname.h>
#include <sys/sysctl.h>
// must private
#import "bBase.h"

@implementation b

+ (void)test {
    NSString *s;
//    NSDictionary *t = @{@"a":s};
}

+ (void)load {
    benchLog(@"bench loaded");
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    benchLog(@"%@",doc);
    benchLog(@"w=%f,h=%f",WIDTH(), HEIGHT());
}

+ (bShared *)shared {
    return bShared.shared;
}

+ (bBase *)base {
    return bBase.shared;
}

+ (NSString *)version {
    return bBase.shared.version;
}

+ (NSString *)deviceType {
    NSString *deviceModel = [[UIDevice currentDevice] model];  // 返回如"iPhone"、"iPad"等通用名称
    NSString *localizedModel = [[UIDevice currentDevice] localizedModel];  // 返回本地化名称（如中文显示"iPhone"）
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machine = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *sysname = [NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding];

    size_t size = 256;
    char *name = (char *)malloc(size);
    sysctlbyname("hw.model", name, &size, NULL, 0);
    NSString *hardwareModel = [NSString stringWithUTF8String:name];
    free(name);
    
    NSString *res = [NSString stringWithFormat:@"%@_%@_%@",localizedModel,machine,hardwareModel];
    NSLog(@"%@",res);
    return res;
}

+ (NSString *)deviceSystemVersion {
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];  // 返回如"16.4.1"
    return systemVersion;
}

+ (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2 {
    return [bBase.shared compareVersion:v1 cutVersion:v2];
}

+ (NSString *)randomString:(NSInteger)number {
    return [bBase.shared randomString:number];
}

+ (bDataBaseStore *)database {
    return bDataBaseStore.shared;
}



//+ (NSDate *)appInstallDate {
//    return [bBase getAppInstallDate];
//}

//+ (NSString *)containForbiddenWords:(NSString *)text {
//    return [bBase containForbiddenWords:text];
//}

+ (bHttpTask *)httpTask {
    return bHttpTask.new;
}

+ (bTimer *)timer {
    return bTimer.shared;
}

+ (bMusicBox *)music {
    return bMusicBox.getInstance;
}

+ (bThread *)thread {
    return bThread.shared;
}

+ (bSort *)sort {
    return bSort.shared;
}

//UI
+ (bUI *)ui {
    return bUI.shared;
}

+ (bEvent *)event {
    return bEvent.shared;
}

+ (void)setupRootWindow:(UIWindow *)window andRootViewController:(UIViewController *)vc {
    [bUI.shared setupRootWindow:window andRootViewController:vc];
}

//+ (NSDictionary *)jsonDicWithString:(id)object {
//    return [bBase jsonWithString:object];
//}

+ (NSArray *)jsonArrWithString:(id)object {
    return [bBase jsonWithString:object];
}

+ (NSDictionary *)jsonWithString:(id)object {
    return [bBase jsonWithString:object];
}

+ (NSString *)stringWithJson:(id)object {
    return [bBase stringWithJson:object];
}

+ (void)delay:(double)delayInSeconds block:(void (^)(void))block {
    return [bBase delay:delayInSeconds block:block];
}

+ (void)gotoMain:(void (^)(void))block {
    [bThread.shared gotoMain:block];
}

+ (void)gotoThread:(void (^)(void))block {
    [bThread.shared gotoThread:block];
}

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name
                                type:(NSString *)type {
    return [bBase bundleFileNamesWithPath:name type:type];
}

+ (NSArray *)bundleFilePathsWithPath:(NSString *)name
                                type:(NSString *)type {
    return [bBase bundleFilePathsWithPath:name type:type];
}

+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name {
    return [bBase copyBundlePlistToSandboxToPath:name];
}

+ (BOOL)saveDataToSandbox:(id)data name:(NSString *)name {
    return [bBase saveDataToSandbox:data name:name];
}

+ (BOOL)savePlistToSandbox:(id)data name:(NSString *)name {
    if (![name hasSuffix:@"plist"]) {
        name = [NSString stringWithFormat:@"%@.plist",name];
    }
    return [bBase saveDataToSandbox:data name:name];
}

+ (void)removeSandboxFile:(NSString *)name {
    [bBase removeSandboxFile:name];
}

+ (void)showNotice:(NSString *)noticeStr {
    [bUI.shared showNotice:noticeStr];
}

+ (void)showNotice:(NSString *)noticeStr atView:(UIView *)view {
    [bUI.shared showNotice:noticeStr atView:view];
}

+ (void)showLoading:(NSString *)noticeStr {
    [bUI.shared showLoading:noticeStr];
}

+ (void)showCannotTapLoading:(NSString *)noticeStr {
    [bUI.shared showCannotRemoveLoading:noticeStr];
}

+ (void)stopLoading {
    [bUI.shared stopLoading];
}

+ (id)sandboxDocumentsStringWithPath:(NSString *)name {
    return [bBase documentsStringWithPath:name];
}

+ (id)sandboxDocumentsPlistWithPath:(NSString *)name {
    return [bBase documentsPlistWithPath:name];
}

+ (id)documentsStringWithPath:(NSString *)name {
    return [bBase documentsStringWithPath:name];
}
+ (id)documentsPlistWithPath:(NSString *)name {
    return [bBase documentsPlistWithPath:name];
}

+ (NSString *)bundleStringWithPath:(NSString *)name type:(NSString *)type {
    return [bBase bundleStringWithPath:name type:type];
}

+ (NSDictionary *)bundlePlistWithPath:(NSString *)name {
    return [bBase bundlePlistWithPath:name];
}

@end
