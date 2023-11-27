//
//  b.m
//  bench
//
//  Created by gwh on 2022/1/8.
//

#import "b.h"

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

+ (void)setupRootWindow:(UIWindow *)window andRootViewController:(UIViewController *)vc {
    [bUI.shared setupRootWindow:window andRootViewController:vc];
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

+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name {
    return [bBase copyBundlePlistToSandboxToPath:name];
}

+ (BOOL)saveDataToSandbox:(id)data name:(NSString *)name {
    return [bBase saveDataToSandbox:data name:name];
}

+ (BOOL)savePlistToSandbox:(id)data name:(NSString *)name {
    return [bBase saveDataToSandbox:data name:[NSString stringWithFormat:@"%@.plist",name]];
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

+ (id)documentsStringWithPath:(NSString *)name {
    return [bBase documentsStringWithPath:name];
}

+ (NSDictionary *)documentsPlistWithPath:(NSString *)name {
    return [bBase documentsPlistWithPath:name];
}

+ (NSString *)bundleStringWithPath:(NSString *)name type:(NSString *)type {
    return [bBase bundleStringWithPath:name type:type];
}

+ (NSDictionary *)bundlePlistWithPath:(NSString *)name {
    return [bBase bundlePlistWithPath:name];
}

@end
