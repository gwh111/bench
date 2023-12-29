//
//  bHttpTask.h
//  bench
//
//  Created by gwh on 2022/6/10.
//

#import <Foundation/Foundation.h>
#import "bHttpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface bHttpTask : NSObject

- (void)getTime:(void(^)(NSString *date))block;
- (void)requestURL:(NSString *)url block:(void(^)(bHttpModel *result))block;

@end

NS_ASSUME_NONNULL_END
