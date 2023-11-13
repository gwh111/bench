//
//  b+App.m
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b+App.h"
#import "DES.h"

@implementation b (App)

+ (NSDictionary *)appBundle {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)appName {
    return [self appBundle][@"CFBundleName"];
}

+ (NSString *)bundleID {
    return [self appBundle][@"CFBundleIdentifier"];
}

+ (NSString *)appVersion {
    return [self appBundle][@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleVersion {
    return [self appBundle][@"CFBundleVersion"];
}

+ (NSString *)sandboxDocPath {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return doc;
}

+ (NSString *)bundlePathWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    return path;
}

+ (NSDictionary *)getDocument:(NSString *)name {
    NSString *service = @"b";
    NSDictionary *data;
    if ([service isEqualToString:@"a"]) {
        data = [b documentsPlistWithPath:name];
    }
    if ([service isEqualToString:@"b"]) {
        id code = [b documentsStringWithPath:[NSString stringWithFormat:@"%@",name]];
        if (!code) {
            return nil;
        }
        NSString *desStr2 = [DES decryptString:code];
        if (!desStr2) {
            return nil;
        }
        data = [b jsonWithString:desStr2];
    }
    return data;
}

//保存到沙盒
+ (void)saveDocument:(NSDictionary *)data name:(NSString *)name {
    NSString *fileKey = [NSString stringWithFormat:@"%@,%@",@"key",name];
    NSString *code = [DES encryptString:fileKey];
    NSMutableDictionary *mutData = data.mutableCopy;
    [mutData b_setObject:code forKey:@"fileKey"];
    
    NSString *service = @"b";
    if ([service isEqualToString:@"a"]) {
        [b saveDataToSandbox:data name:[NSString stringWithFormat:@"%@.plist",name]];
    }
    if ([service isEqualToString:@"b"]) {
        NSString *s = [b stringWithJson:data];
        NSString *desStr = [DES encryptString:s];
        [b saveDataToSandbox:desStr name:name];
    }
}

@end
