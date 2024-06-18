//
//  NSObject+b.m
//  bench
//
//  Created by gwh on 2022/2/10.
//

#import "NSObject+b.h"
#import <objc/runtime.h>
#import "bench.h"

@implementation NSObject (b)

+ (instancetype)shared {
    NSString *cname = NSStringFromClass(self);
    id model = NSClassFromString(cname).new;
    NSString *key = [NSString stringWithFormat:@"benchShared_%@",cname];
    if ([b getSharedKey:key]) {
        return [b getSharedKey:key];
    }
    [b setSharedKey:key object:model];
    return model;
}

- (id)b_copy {
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

#pragma mark kv help
- (id)b_setClassKVDic:(NSDictionary *)dic {
    NSArray *names = [self b_getClassNameListWithout_];
    for (int i = 0; i < names.count; i++) {
        NSString *name = names[i];
        id value = [dic objectForKey:name];
        if (!value) {
            continue;
        }
        [self setValue:value forKey:name];
    }
    if (![self.superclass isMemberOfClass:NSObject.class]) {
        NSArray *names = [self.superclass b_getClassNameListWithout_];
        for (int i = 0; i < names.count; i++) {
            NSString *name = names[i];
            id value = [dic objectForKey:name];
            if (!value) {
                continue;
            }
            [self setValue:value forKey:name];
        }
    }
    return self;
}

- (NSDictionary *)b_getClassKVDic {
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
    NSArray *names = [self b_getClassNameList];
    for (int i = 0; i < names.count; i++) {
        NSString *name = names[i];
        id value = [self valueForKey:name];
        if (!value) {
            continue;
        }
        [mutDic setObject:[self valueForKey:name] forKey:name];
    }
    if (![self.superclass isMemberOfClass:NSObject.class]) {
        NSArray *names = [self.superclass b_getClassNameListWithout_];
        for (int i = 0; i < names.count; i++) {
            NSString *name = names[i];
            id value = [self valueForKey:name];
            if (!value) {
                continue;
            }
            [mutDic setObject:[self valueForKey:name] forKey:name];
        }
    }
    return mutDic;
}

- (NSDictionary *)b_getClassKVDicWithout_ {
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
    NSArray *names = [self b_getClassNameList];
    for (int i = 0; i < names.count; i++) {
        NSString *name = names[i];
        if (name.length > 1) {
            name = [name substringFromIndex:1];
        }
        id value = [self valueForKey:name];
        if (!value) {
            continue;
        }
        [mutDic setObject:[self valueForKey:name] forKey:name];
    }
    return mutDic;
}

- (NSArray *)b_getClassNameList {
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars + i);
        NSString *name = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        [mutArr addObject:name];
    }
    free(ivars);
    return mutArr;
}

- (NSArray *)b_getClassNameListWithout_ {
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars + i);
        NSString *name = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        if ([name hasPrefix:@"_"]) {
            name = [name substringFromIndex:1];
        }
        [mutArr addObject:name];
    }
    free(ivars);
    return mutArr;
}

- (NSArray *)b_getClassTypeList {
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        // 取出成员变量类型
        Ivar ivar = *(ivars + i);
        NSString *name = [NSString stringWithFormat:@"%s",ivar_getTypeEncoding(ivar)];
        name = [name stringByReplacingOccurrencesOfString:@"@" withString:@""];
        name = [name stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [mutArr addObject:name];
    }
    free(ivars);
    return mutArr;
}

@end
