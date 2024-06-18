//
//  b+App.m
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b+App.h"
#import "DES.h"
#import "b+Check.h"
#import "b+Share.h"

@implementation b (App)

static NSString *FIRST_LAUNCH = @"FIRST_LAUNCH";
static NSString *REQUEST = @"REQUEST";
static NSString *BENCH_DEFAULT = @"BENCH_DEFAULT";

+ (void)launch {
    if (![b benchDefaultObjectForKey:FIRST_LAUNCH]) {
        [b benchDefaultSetObject:NSDate.date.b_convertToString forKey:FIRST_LAUNCH];
    }
    benchLog(@"launchDayFromFirstDay = %d",self.launchDayFromFirstDay);
}

+ (int)launchDayFromFirstDay {
    NSDate *now = NSDate.date;
    NSString *firstDateStr = [b benchDefaultObjectForKey:FIRST_LAUNCH];
    NSDate *firstDate = firstDateStr.b_convertToDate;
    benchLog(@"firstDate = %@",firstDate);
    NSTimeInterval inter = [now timeIntervalSinceDate:firstDate];
    int day = inter/60/60/24;
    return day;
}

+ (NSTimeInterval)requestColdTime:(NSString *)key {
    NSDate *now = NSDate.date;
    NSDictionary *like = [b getDictionary:REQUEST];
    NSDictionary *data = like[key];
    if (data) {
        NSString *time = data[@"time"];
        NSDate *firstDate = time.b_convertToDate;
        NSTimeInterval inter = [now timeIntervalSinceDate:firstDate];
        return inter;
    }
    return 999999;
}

+ (void)requestColdTimeSet:(NSString *)key content:(NSDictionary *)content {
    NSDate *now = NSDate.date;
    NSDictionary *like = [b getDictionary:REQUEST];
    NSMutableDictionary *likes = [NSMutableDictionary dictionaryWithDictionary:like];
    if (!content) {
        [likes removeObjectForKey:key];
    } else {
        NSDictionary *data = @{@"time":now.b_convertToString,@"content":content};
        [likes b_setObject:data forKey:key];
    }
    [b saveDictionary:likes name:@"REQUEST"];
}

+ (NSDictionary *)requestCacheData:(NSString *)key {
    NSDictionary *like = [b getDictionary:REQUEST];
    return like[key][@"content"];
}

+ (void)requestListColdTimeSet:(NSString *)key content:(NSArray *)content {
    NSDate *now = NSDate.date;
    NSDictionary *like = [b getDictionary:REQUEST];
    NSMutableDictionary *likes = [NSMutableDictionary dictionaryWithDictionary:like];
    if (!content) {
        [likes removeObjectForKey:key];
    } else {
        NSDictionary *data = @{@"time":now.b_convertToString,@"content":content};
        [likes b_setObject:data forKey:key];
    }
    [b saveDictionary:likes name:@"REQUEST"];
}

+ (NSArray *)requestListCacheData:(NSString *)key {
    NSDictionary *like = [b getDictionary:REQUEST];
    return like[key][@"content"];
}

+ (BOOL)requestIsColding:(NSString *)key {
//    if (b.isDebug) {
//        return NO;
//    }
    NSTimeInterval inter = [self requestColdTime:key];
    if (inter < 60*60*12) {
        return YES;
    }
    return NO;
}

+ (void)setKeychainObjectId:(NSString *)str {
    [NSString setKeychainObjectId:str];
}

+ (NSString *)getKeychainObjectId {
    return [NSString getKeychainObjectId];
}

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

+ (id)benchDefaultObjectForKey:(NSString *)key fileName:(NSString *)fileName {
    NSDictionary *like = [b getDictionary:fileName];
    return like[key];
}

+ (void)benchDefaultSetObject:(id)value forKey:(NSString *)key fileName:(NSString *)fileName {
    NSDictionary *like = [b getDictionary:fileName];
    NSMutableDictionary *likes = [NSMutableDictionary dictionaryWithDictionary:like];
    [likes b_setObject:value forKey:key];
    [b saveDictionary:likes name:fileName];
}

+ (id)benchDefaultObjectForKey:(NSString *)key {
    NSDictionary *like = [b getDictionary:BENCH_DEFAULT];
    return like[key];
}

+ (void)benchDefaultRemoveObjectForKey:(NSString *)key {
    [self benchDefaultSetObject:nil forKey:key];
}

+ (void)benchDefaultSetObject:(nullable id)value forKey:(NSString *)key {
    NSDictionary *like = [b getDictionary:BENCH_DEFAULT];
    NSMutableDictionary *likes = [NSMutableDictionary dictionaryWithDictionary:like];
    if (value) {
        [likes b_setObject:value forKey:key];
    } else {
        [likes removeObjectForKey:key];
    }
    [b saveDictionary:likes name:BENCH_DEFAULT];
}

+ (BOOL)isRated {
    return [[b benchDefaultObjectForKey:@"rated"]boolValue];
}


+ (void)isRatedSet:(BOOL)rated {
    [b benchDefaultSetObject:@(rated) forKey:@"rated"];
}

+ (BOOL)isCodeValided {
    return [[b benchDefaultObjectForKey:@"code"]boolValue];
}

+ (void)isCodeValidedSet:(BOOL)rated {
    [b benchDefaultSetObject:@(rated) forKey:@"code"];
}

+ (id)getDefault:(NSString *)key {
    if (!key) {
        benchLog(@"error:key=nil");
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+ (void)saveDefault:(NSString *)key value:(id)value {
    if (!key) {
        benchLog(@"error:key=nil");
        return;
    }
    if (!value) {
        benchLog(@"error:v=nil");
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
        return;
    }
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (NSString *)bundlePathWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    return path;
}

+ (NSDictionary *)getDictionary:(NSString *)name {
    NSString *service = @"b";
    NSDictionary *data = @{};
    if ([service isEqualToString:@"a"]) {
        data = [b sandboxDocumentsPlistWithPath:name];
    }
    if ([service isEqualToString:@"b"]) {
        id code = [b sandboxDocumentsStringWithPath:[NSString stringWithFormat:@"%@",name]];
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
+ (void)saveDictionary:(NSDictionary *)data name:(NSString *)name {
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

+ (int)getAndInitCoin:(int)value {
    NSString *coin = [b benchDefaultObjectForKey:@"coin"];
    if (!coin) {
        [self setCoin:value];
        coin = [b benchDefaultObjectForKey:@"coin"];
    }
    return coin.intValue;
}

+ (int)getCoin {
    NSString *coin = [b benchDefaultObjectForKey:@"coin"];
    return coin.intValue;
}

+ (void)addCoin:(int)value {
    int coin = self.getCoin;
    coin = coin + value;
    [self setCoin:coin];
}

+ (void)setCoin:(int)value {
    [b benchDefaultSetObject:@(value) forKey:@"coin"];
}

+ (int)getAndInitGold:(int)value {
    NSString *gold = [b benchDefaultObjectForKey:@"gold"];
    if (!gold) {
        [self setGold:value];
        gold = [b benchDefaultObjectForKey:@"gold"];
    }
    return gold.intValue;
}

+ (int)getGold {
    NSString *gold = [b benchDefaultObjectForKey:@"gold"];
    return gold.intValue;
}

+ (void)addGold:(int)value {
    int coin = self.getGold;
    coin = coin + value;
    [self setGold:coin];
}

+ (void)setGold:(int)value {
    [b benchDefaultSetObject:@(value) forKey:@"gold"];
}

+ (void)rateAsk:(NSString *)msg copyDes:(NSString *)des appId:(NSString *)appId {
//    NSString *msg = @"评论有奖~给我们一个评论，赠送30天会员。";
//    NSString *des = @"伯牙鼓琴，锺子期听之。方鼓琴而志在太山，锺子期曰:“善哉乎鼓琴！巍巍乎若太山。”少选之间而志在流水，锺子期又曰：”善哉乎鼓琴！汤汤乎若流水。”锺子期死，伯牙破琴绝弦，终身不复鼓琴，以为世无足复为鼓琴者。";
    
    [b.ui showAltOn:b.ui.currentUIViewController title:msg msg:des bts:@[@"复制推荐内容后评论",@"取消"] block:^(int index, NSString * _Nonnull indexTitle) {
        if (index == 0) {
//            a.shared.rate = 2;
//            NSString *appId = @"1635508901";
            [b setSharedKey:@"gotoRate" object:@"1"];
            if (!b.isRated) {
                [b setSharedKey:@"rate" object:@"1"];
            }
            
            NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = des;
            
            if (@available(iOS 10.0, *)) {
                [UIApplication.sharedApplication openURL:[NSURL URLWithString:urlStr] options:NSMutableDictionary.new completionHandler:^(BOOL success) {
                    
                }];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }
        }
    }];
}

+ (void)xhsAccount {

    NSURL *taobaoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"xhsdiscover://item/%@?type=%@",@"66285a0d000000001c0065af",@"normal"]];
    // https://www.xiaohongshu.com/discovery/item/66285a0d000000001c0065af?app_platform=android&ignoreEngage=true&app_version=8.33.0&share_from_user_hidden=true&type=normal&author_share=1&xhsshare=CopyLink&shareRedId=N0xFMUhJR0I2NzUyOTgwNjY0OThJOUlP&apptime=1713926941
    if ([[UIApplication sharedApplication] canOpenURL:taobaoUrl]) {
        [[UIApplication sharedApplication] openURL:taobaoUrl options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
        [b showNotice:[NSString stringWithFormat:@"小红书官方账号：%@",b.appName]];
    }
}

@end
