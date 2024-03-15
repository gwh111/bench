//
//  b+Language.m
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b+Language.h"
#import "b+Check.h"
#import "b+Share.h"
#import "b+App.h"

@implementation b (Language)

+ (NSString *)getTextCh:(NSString *)chtext enText:(NSString *)entext {
//    NSString *key = @"language_index";
//    NSNumber *n = [b getSharedKey:key];
//    if (!n) {
//        [b setSharedKey:key object:@(b.isChinese)];
//        n = [b getSharedKey:key];
//    }
//    BOOL isCh = n.boolValue;
//    if (isCh) {
//        return chtext;
//    }
    if (b.isChinese) {
        return chtext;
    }
    return entext;
}

+ (NSString *)getText:(NSString *)text key:(NSString *)key {
    if (b.isChinese) {
        return text;
    }
    NSString *key1 = [NSString stringWithFormat:@"TEXT_%@",key];
    NSString *path = [b getSharedKey:key1];
    NSDictionary *data = [b bundlePlistWithPath:path];
    // eng
    id v = data[text];
    if ([v isKindOfClass:NSString.class]) {
        return v;
    }
    NSArray *lists = v;
    if (lists.count == 0) {
        return text;
    }
    text = lists.firstObject;
    // other1
    
    // other2
    
    // ...
    return text;
}

+ (void)setDefaultPath:(NSString *)path {
    NSString *key1 = [NSString stringWithFormat:@"TEXT_%@",b.bundleID];
    [b addSharedKey:key1 object:path];
}

+ (void)setPath:(NSString *)path key:(NSString *)key {
    [b addSharedKey:key object:path];
}

@end
