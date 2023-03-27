//
//  UITapGestureRecognizer+b.m
//  bench
//
//  Created by gwh on 2022/2/11.
//

#import "UITapGestureRecognizer+b.h"
#import <objc/runtime.h>

@implementation UITapGestureRecognizer (b)

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)timeInterval {
    return [objc_getAssociatedObject(self, @selector(timeInterval))doubleValue];
}

@end
