//
//  NSArray+b.h
//  bench
//
//  Created by gwh on 2023/5/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (b)

- (NSArray *)b_sortedLocal;
- (NSMutableArray *)b_addObject:(id)obj;

@end

NS_ASSUME_NONNULL_END
