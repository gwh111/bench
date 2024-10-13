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

+ (NSArray *)getPlistTextChs:(NSArray *)chtexts {
    NSMutableArray *list = NSMutableArray.new;
    for (int i = 0; i < chtexts.count; i++) {
        NSString *text = chtexts[i];
        NSString *find = [self getPlistTextCh:text];
        [list addObject:find];
    }
    return list;
}

+ (NSString *)getPlistTextCh:(NSString *)chtext {
    if (b.isChinese) {
        return chtext;
    }
    NSString *path = @"text/ch_en";
    id d = [b getSharedKey:path];
    if (d) {
        return d;
    }
    NSMutableDictionary *data = NSMutableDictionary.new;
    NSString *content = [b bundleStringWithPath:path type:@"md"];
    if (content.length <= 10) {
        return chtext;
    }
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    for (int i = 0; i < lines.count; i++) {
        NSString *line = lines[i];
        if (line.length <= 0) {
            continue;
        }
        NSArray *kvs = [line componentsSeparatedByString:@"="];
        NSString *key = kvs[0];
        NSString *v = kvs[1];
        [data setObject:v forKey:key];
    }
    [b setSharedKey:@"text/ch_en" object:data];
//    NSDictionary *data = [b bundlePlistWithPath:path];
    if (!data[chtext]) {
        return chtext;
    }
    return data[chtext];
}

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
