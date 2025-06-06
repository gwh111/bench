//
//  b+Share.m
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b+Share.h"
#import "bBase.h"

@implementation b (Share)

+ (void)copyToPastBoard:(NSString *_Nullable )text {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
}

+ (NSString *)pasteboardText {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *text = pasteboard.string;
    return text;
}

+ (void)removeSharedKey:(NSString *)key {
    if (!key) {
        return;
    }
    [bBase.shared.sharedData removeObjectForKey:key];
}

+ (void)setSharedKey:(NSString *)key object:(id)object {
    if (!bBase.shared.sharedData) {
        bBase.shared.sharedData = NSMutableDictionary.new;
    }
    [bBase.shared.sharedData b_setObject:object forKey:key];
}

+ (void)addSharedKey:(NSString *)key object:(id)object {
    if (!bBase.shared.sharedData) {
        bBase.shared.sharedData = NSMutableDictionary.new;
    }
    if (bBase.shared.sharedData[key]) {
        assert("has such key, use another");
    }
    [bBase.shared.sharedData b_setObject:object forKey:key];
}

+ (id)getSharedKey:(NSString *)key {
    return bBase.shared.sharedData[key];
}

@end
