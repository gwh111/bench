//
//  bUIModule.m
//  bench
//
//  Created by apple on 2023/7/12.
//

#import "bUIModule.h"
#import "bench.h"

@implementation bUIModule

+ (instancetype)shared {
    NSString *cname = NSStringFromClass(self);
    bUIModule *model = NSClassFromString(cname).new;
    NSString *key = [NSString stringWithFormat:@"UImodule_%@",cname];
    if ([b getSharedKey:key]) {
        return [b getSharedKey:key];
    }
    [b setSharedKey:key object:model];
    return model;
}

@end
