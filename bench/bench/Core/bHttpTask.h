//
//  bHttpTask.h
//  bench
//
//  Created by gwh on 2022/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bHttpTask : NSObject

- (void)getTime:(void(^)(NSString *date))block;

@end

NS_ASSUME_NONNULL_END
