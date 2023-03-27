//
//  NSDictionary+b.h
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (b)

@end

@interface NSMutableDictionary (b)

- (void)b_setObject:(id)anObject forKey:(id)aKey;
- (void)b_removeObjectForKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
