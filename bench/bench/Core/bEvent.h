//
//  bEvent.h
//  bench
//
//  Created by gwh on 2025/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bEvent : NSObject

+ (instancetype)shared;

- (void)subscribeEvent:(NSString *)eventName
                owner:(id)owner
               block:(void (^)(id _Nullable data))block;

- (void)dispatchEvent:(NSString *)eventName
                data:(id _Nullable)data;

@end

NS_ASSUME_NONNULL_END
