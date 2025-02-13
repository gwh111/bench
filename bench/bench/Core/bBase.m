//
//  PandoraBase.m
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import "bBase.h"
//#import <sys/stat.h>
#import "b.h"

static bBase *userManager = nil;
static dispatch_once_t onceToken;

@implementation bBase

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[super allocWithZone:NULL]init];
        userManager.data = NSMutableDictionary.new;
        userManager.sharedData = NSMutableDictionary.new;
    });
    return userManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return self.shared;
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

+ (NSArray *)bundleFilePathsWithPath:(NSString *)name
                                type:(NSString *)type {
    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:type
                                                        inDirectory:name];
    return paths;
}

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name
                                type:(NSString *)type {
    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:type
                                                        inDirectory:name];
    NSMutableArray *mutList = NSMutableArray.new;
    for (int i = 0; i < paths.count; i++) {
        NSString *path = paths[i];
        NSArray *sets = [path componentsSeparatedByString:@"/"];
        NSString *name = sets.lastObject;
        if (name.length <= 0) {
            continue;
        }
        [mutList addObject:name];
    }
    return mutList.copy;
}

+ (NSData *)bundleFileWithPath:(NSString *)name
                          type:(NSString *)type {
    if (!name) return nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (!filePath)
    {
        benchLog(@"cannot find file path '%@'",name);
        return nil;
    }
    
    return [NSData dataWithContentsOfFile:filePath options:0 error:NULL];
}

+ (NSString *)bundleStringWithPath:(NSString *)name type:(NSString *)type {
    if (!name) return nil;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    NSString *data = [[NSString alloc] initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    
    if (!data) {
        benchLog(@"cannot find file '%@'",name);
    }
    return data;
}

+ (NSDictionary *)bundlePlistWithPath:(NSString *)name {
    if (!name) return nil;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    if (!plistPath) {
        plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    NSString *s = [b stringWithJson:data];
    
//    NSString *desStr = [DES encryptString:s];
    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        // 拼接文件路径
//    NSString *path = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"asdfff"]];
//    s = [s stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    s = [s stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
//    s = [s stringByReplacingOccurrencesOfString:@"%" withString:@"%%"];
//    s = [s stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//    [s writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
//
//
//    NSString *sss = @"";
//
//    sss = [sss stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
//    NSDictionary *ddd = [b jsonWithString:sss];
    
    if (!data) {
        benchLog(@"cannot find plist '%@'",name);
    }
    return data;
}

+ (BOOL)saveDataToSandbox:(id)data name:(NSString *)name {
    if (!name) {
        benchLog(@"no name");
        return NO;
    }
    
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 拼接文件路径
    NSString *path = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    NSLog(@"save to path %@",path);
    if ([data isKindOfClass:UIImage.class]) {
        UIImage *image = data;
        NSData *data = UIImageJPEGRepresentation(image, 1);
        return [data writeToFile:path atomically:YES];
    }
    
    NSError *error;
    return [data writeToFile:path atomically:YES];
}

+ (void)removeSandboxFile:(NSString *)name {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 拼接文件路径
    NSString *path = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (BOOL)copyBundleFileToSandboxToPath:(NSString *)name type:(NSString *)type {
    if (!name) {
        benchLog(@"no name");
        return NO;
    }
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *sbPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,type]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (!filePath) {
        benchLog(@"cannot find file path '%@'",name);
        return NO;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:sbPath]) {
        return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:sbPath error:nil];
    }
    if (![[NSFileManager defaultManager] removeItemAtPath:sbPath error:nil]) {
        return NO;
    }
    return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:sbPath error:nil];
}

+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name {
    return [self copyBundleFileToSandboxToPath:name type:@"plist"];
}

+ (id)documentsStringWithPath:(NSString *)name {
    if (!name) return nil;
    //读取本地沙盒中的数据
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    //判断路径是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        NSError *error;
        NSString *data = [[NSString alloc] initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"%@",error);
        return data;
    }
//    NSLog(@"no such file '%@'",name);
    return nil;
}

+ (id)documentsPlistWithPath:(NSString *)name {
    if (!name) return nil;
    //读取本地沙盒中的数据
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *fileName;
    if ([name hasSuffix:@".plist"]) {
        fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    } else {
        fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    }
    //判断路径是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        NSMutableDictionary *setupDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
        if (setupDic) {
            return setupDic;
        }
        NSArray *find = [NSArray arrayWithContentsOfFile:fileName];
        
        return find;
    }
//    NSLog(@"no such file '%@'",name);
    return nil;
}

+ (UIImage *)benchBundleImage:(NSString *)imgName {
    return [self bundleImage:imgName bundleName:@"bench_swift"];
}

+ (UIImage *)bundleImage:(NSString *)imgName bundleName:(NSString *)bundleName {

    UIImage *backImage;
    NSBundle *mainBundle = [NSBundle bundleForClass:self.class];
    if ([mainBundle pathForResource:bundleName ofType:@"bundle"]) {
        NSString *myBundlePath = [mainBundle pathForResource:bundleName ofType:@"bundle"];
        NSBundle *myBundle = [NSBundle bundleWithPath:myBundlePath];
        backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:imgName ofType:@"png"]];
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@2x",imgName] ofType:@"png"]];
        }
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@3x",imgName] ofType:@"png"]];
        }
    } else {
        NSString *appBundlePath = [mainBundle pathForResource:bundleName ofType:@"bundle"];
        NSBundle *appBundle = [NSBundle bundleWithPath:appBundlePath];
        NSString *myBundlePath = [appBundle pathForResource:@"Bundle" ofType:@"bundle"];
        NSBundle *myBundle = [NSBundle bundleWithPath:myBundlePath];
        backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:imgName ofType:@"png"]];
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@2x",imgName] ofType:@"png"]];
        }
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@3x",imgName] ofType:@"png"]];
        }
    }
    return backImage;
}

+ (id)jsonWithString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return object;
}

+ (NSString *)stringWithJson:(id)object {
    if (!object) {
        return @"";
    }
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
//    if (![object isKindOfClass:[NSDictionary class]]) {
//        return object;
//    }
    NSError *error;
    // Pass 0 if you don't care about the readability of the generated string
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonStr=@"";
    if (!jsonData){
        benchLog(@"error: %@",error);
    }else{
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonStr;
}

+ (void)delay:(double)delayInSeconds block:(void (^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        block();
    });
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//       // 在子线程中执行需要延时的代码
//       [NSThread sleepForTimeInterval:delayInSeconds]; // 休眠3秒钟
//
//       dispatch_async(dispatch_get_main_queue(), ^{
//          // 回到主线程中执行剩余操作
//          // ...
//           block();
//       });
//    });
}

//+ (id)getDefault:(NSString *)key {
//    if (!key) {
//        benchLog(@"error:key=nil");
//        return nil;
//    }
//    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
//}
//
//+ (void)saveDefault:(NSString *)key value:(id)value {
//    if (!key) {
//        benchLog(@"error:key=nil");
//        return;
//    }
//    if (!value) {
//        benchLog(@"error:v=nil");
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
//        return;
//    }
//    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//}

//+ (NSDate *)getAppInstallDate {
//    NSDate *date;
//    NSString *key = @"AppInstallDate";
//    date = [self getDefault:key];
//    if (!date) {
//        date = NSDate.b_localDate;
//        [self saveDefault:key value:date];
//    }
//    return date;
//}



@end
