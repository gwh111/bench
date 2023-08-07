//
//  bModule.m
//  bench
//
//  Created by apple on 2023/7/10.
//

#import "bModule.h"
#import "bench.h"

@implementation bModule

- (void)setup {
    NSString *cname = NSStringFromClass(self.class);
    NSString *key = [NSString stringWithFormat:@"module_%@",cname];
    NSLog(@"【%@ shared】 setup finish",key);
}

+ (instancetype)shared {
    NSString *cname = NSStringFromClass(self);
    NSString *key = [NSString stringWithFormat:@"module_%@",cname];
    bModule *model = NSClassFromString(cname).new;
    if ([b getSharedKey:key]) {
        return [b getSharedKey:key];
    }
    [model setup];
    [b setSharedKey:key object:model];
    return model;
}

@end
