//
//  NSDictionary+b.m
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import "NSDictionary+b.h"
#import "b.h"

@implementation NSDictionary (b)

@end

@implementation NSMutableDictionary (b)

- (void)b_setObject:(id)anObject forKey:(id)aKey {
    if (!aKey) {
        benchLog(@"aKey=nil");
        return;
    }
    if (!anObject) {
        [self removeObjectForKey:aKey];
        return;
    }
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)b_removeObjectForKey:(id)aKey {
    if (!aKey) {
        return;
    }
    [self removeObjectForKey:aKey];
}

@end
