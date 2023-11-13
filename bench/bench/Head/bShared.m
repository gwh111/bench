//
//  bShared.m
//  bench
//
//  Created by apple on 2023/11/6.
//

#import "bShared.h"

@implementation bShared

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"1");
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"1");
    return YES;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"1");
}

@end
