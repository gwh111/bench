//
//  bModule.m
//  bench
//
//  Created by apple on 2023/7/10.
//

#import "bModule.h"
#import "bench.h"

@implementation bModule

+ (instancetype)shared {
    NSString *cname = NSStringFromClass(self);
    bModule *model = NSClassFromString(cname).new;
    NSString *key = [NSString stringWithFormat:@"module_%@",cname];
    if ([b getSharedKey:key]) {
        return [b getSharedKey:key];
    }
    [b setSharedKey:key object:model];
    return model;
}

@end
