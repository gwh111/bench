//
//  b+Check.m
//  bench
//
//  Created by gwh on 2023/2/28.
//

#import "b+Check.h"
#import "b+App.h"

//typedef void (^benchSafeBlock)(BOOL isSafe);

@implementation b (Check)

+ (BOOL)isDebug {
#if DEBUG
    return YES;
#endif
    return NO;
}

+ (int)compareV1:(NSString *)v1 cutV2:(NSString *)v2 {
    if (!v1||!v2) {
//        CCLOG("不能为空");
        return -100;
    }
    if (v1.length<v2.length) {
        for (int i=0; i<(v2.length-v1.length)/2; i++) {
            v1=[NSString stringWithFormat:@"%@.0",v1];
        }
    }else if (v2.length<v1.length){
        for (int i=0; i<(v1.length-v2.length)/2; i++) {
            v2=[NSString stringWithFormat:@"%@.0",v2];
        }
    }
    NSArray  *arr1 = [v1 componentsSeparatedByString:@"."];
    NSArray  *arr2 = [v2 componentsSeparatedByString:@"."];
    NSInteger c1=arr1.count;
    NSInteger c2=arr2.count;
    if (c1==0||c2==0) {
//        CCLOG("分割错误");
        return -100;
    }
    for (int i=0; i<arr1.count; i++) {
        int item1=[arr1[i] intValue];
        int item2=[arr2[i] intValue];
        if (item1>item2) {
            return 1;
        }else if (item1<item2){
            return -1;
        }
    }
    
    if (c1>c2) {
        return 1;
    }else if (c1<c2){
        return -1;
    }else{
        return 0;
    }
    
    return 999;
}

+ (void)setIsSafeReviewVersion:(NSString *)reviewVersion inReview:(BOOL)inReview {
    if (!inReview) {
        [b benchDefaultSetObject:@(YES) forKey:@"isSafe"];
    } else {
        NSString *version = b.version;
        if ([b compareVersion:reviewVersion cutVersion:version] > 0) {
            [b benchDefaultSetObject:@(YES) forKey:@"isSafe"];
        } else {
            [b benchDefaultSetObject:@(NO) forKey:@"isSafe"];
        }
    }
}

+ (BOOL)isDateBefore:(NSString *)dataStr {
    NSString *time = @"2022-09-18 08:08:08";
    time = dataStr;
    NSDate *localD = NSDate.b_localDate;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *resDate = [dateFormatter dateFromString:time];
    if (!resDate) {
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss z"];
        resDate = [dateFormatter dateFromString:time];
    }

    NSTimeInterval timeInterval = [resDate timeIntervalSinceDate:localD];
    if (timeInterval > 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPad {
    float per = HEIGHT()/WIDTH();
    if (per < 2) {
        return YES;
    }
    return NO;
}

+ (void)setIsSafeTime:(NSString *)time {
    [b benchDefaultSetObject:time forKey:@"safe-time"];
}

+ (BOOL)isSafe {
//    return NO;
    NSString *time = [b benchDefaultObjectForKey:@"safe-time"];
    if ([b isDateBefore:time]) {
        return false;
    }
    return true;
    BOOL safe = [[b benchDefaultObjectForKey:@"isSafe"]boolValue];
    if (self.isDebug) {
        if (!safe) {
            [b showNotice:@"not safe"];
//            return NO;
        }
        return YES;
    }
    return safe;
    
    
//    {
//        NSString *time = @"2022-09-18 08:08:08";
//        NSDate *localD = NSDate.b_localDate;
//        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
//        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//        NSDate *resDate = [dateFormatter dateFromString:time];
//        if (!resDate) {
//            [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss z"];
//            resDate = [dateFormatter dateFromString:time];
//        }
//        
//        NSTimeInterval timeInterval = [resDate timeIntervalSinceDate:localD];
//    }
//    
//    NSArray *languages = [NSLocale preferredLanguages];
//    NSString *currentLanguage = [languages objectAtIndex:0];
//    if (![currentLanguage containsString:@"zh"]) {
//        return NO;
//    }
//    return YES;
}

+ (BOOL)isProxyStatus {
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //检测到抓包
        if ([self fetchHttpProxy]) {
            //二次确认
            return YES;
        }
        return NO;
    }
    return NO;
}

+ (id)fetchHttpProxy {
    CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings();
    const CFStringRef proxyCFstr = (const CFStringRef)CFDictionaryGetValue(dicRef,
                                                                           (const void*)kCFNetworkProxiesHTTPProxy);
    NSString *proxy = (__bridge NSString *)proxyCFstr;
    return proxy;
}

+ (BOOL)isJailBreak {
    #if TARGET_IPHONE_SIMULATOR
        return false;
    #elif TARGET_OS_IPHONE
    #endif
    //判断这些文件是否存在，只要有存在的，就可以认为手机已经越狱了。
    NSArray *jailbreak_tool_paths = @[
                                     @"/Applications/Cydia.app",
                                     @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                     @"/bin/bash",
                                     @"/usr/sbin/sshd",
                                     @"/etc/apt"
                                     ];
    for (int i=0; i<jailbreak_tool_paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    
    //根据是否能打开cydia判断
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
//        NSLog(@"The device is jail broken!");
//        return YES;
//    }
    
    //根据是否能获取所有应用的名称判断
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
        NSLog(@"The device is jail broken!");
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil];
        NSLog(@"appList = %@", appList);
        return YES;
    }
    
//    struct stat stat_info;
//    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
//        exit(0);
//    }
    
    return NO;
}

+ (BOOL)isChinese {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    // 是否使用中文作为iphone语言
    return [currentLanguage containsString:@"zh"]||[currentLanguage containsString:@"yue"];
}

+ (BOOL)isSimplifiedChinese {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    // 是否使用中文作为iphone语言
    return [currentLanguage containsString:@"zh-Hans-CN"];
}

+ (NSString *)version {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2 {
    if (!v1||!v2) {
        benchLog(@"benchLog:不能为空");
        return -100;
    }
    if (v1.length < v2.length) {
        for (int i=0; i<(v2.length-v1.length)/2; i++) {
            v1=[NSString stringWithFormat:@"%@.0",v1];
        }
    }else if (v2.length < v1.length){
        for (int i=0; i<(v1.length-v2.length)/2; i++) {
            v2=[NSString stringWithFormat:@"%@.0",v2];
        }
    }
    NSArray  *arr1 = [v1 componentsSeparatedByString:@"."];
    NSArray  *arr2 = [v2 componentsSeparatedByString:@"."];
    NSInteger c1 = arr1.count;
    NSInteger c2 = arr2.count;
    if (c1 == 0 || c2 == 0) {
        NSLog(@"benchLog:分割错误");
        return -100;
    }
    for (int i=0; i<arr1.count; i++) {
        int item1 = [arr1[i] intValue];
        int item2 = [arr2[i] intValue];
        if (item1 > item2) {
            return 1;
        }else if (item1 < item2){
            return -1;
        }
    }
    
    if (c1 > c2) {
        return 1;
    }else if (c1 < c2){
        return -1;
    }else{
        return 0;
    }
    
    return 999;
}

+ (NSString *)randomString:(NSInteger)number {
    
    NSString *ramdom;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i ; i ++) {
        int a = (arc4random() % 122);
        if (a > 96) {
            char c = (char)a;
            [array addObject:[NSString stringWithFormat:@"%c",c]];
            if (array.count == number) {
                break;
            }
        } else continue;
    }
    ramdom = [array componentsJoinedByString:@""];
    return ramdom;
}

+ (NSString *)textChinese:(NSString *)ch andEnglish:(NSString *)eng {
    if (self.isChinese) {
        return ch;
    }
    return eng;
}

+ (NSArray *)textChineseList:(NSArray *)chList andEnglishList:(NSArray *)engList {
    if (self.isChinese) {
        return chList;
    }
    return engList;
}

+ (NSString *)containForbiddenWords:(NSString *)text {
    NSArray *words = self.forbiddenWords;
    for (int i = 0; i < words.count; i++) {
        NSString *word = words[i];
        if ([text containsString:word]) {
            return word;
        }
    }
    return nil;
}

+ (BOOL)containForbiddenWordsCheck:(NSString *)text {
    NSString *word = [self containForbiddenWords:text];
    if (word) {
        [b showNotice:[NSString stringWithFormat:@"请文明用语。【%@】",word]];
        return YES;
    }
    return NO;
}

+ (NSArray *)forbiddenWords {
    NSArray *words = @[@"操",@"妈",@"死",@"爷",@"贱",@"爸",@"垃圾",@"逼",@"狗",@"TM",@"日",@"家",@"毛",@"平",@"泽",@"克强"];
    return words;
}

+ (BOOL)isRand100LessThan:(int)value {
    if (value <= 0) {
        return NO;
    }
    int v100 = arc4random()%100;
    if (v100 < value) {
        return YES;
    }
    return NO;
}

+ (int)randValue:(int)value {
    if (value <= 0) {
        return 0;
    }
    return arc4random()%value;
}

+ (void)printFontNames {
    NSDictionary *dic = [b benchDefaultObjectForKey:@"temp"];
        NSMutableDictionary *mut = NSMutableDictionary.new;
    NSArray *arr = [UIFont familyNames];
    for (NSString *family in arr) {
        //打印字体族名
        NSLog(@"%@", family);
        NSArray *arr2 = [UIFont fontNamesForFamilyName:family];
        for (NSString *name in arr2) {
            NSLog(@"***%@", name);
                [mut setObject:@"" forKey:name];
            if (!dic[name]) {
                NSLog(@"find");
            }
        }
    }
    NSLog(@"familyNames=%lu",(unsigned long)arr.count);
        [b benchDefaultSetObject:mut forKey:@"temp"];
//    b benchDefaultSetObject:<#(nonnull id)#> forKey:<#(nonnull NSString *)#>
}


@end
