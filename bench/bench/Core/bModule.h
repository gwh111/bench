//
//  bModule.h
//  bench
//
//  Created by apple on 2023/7/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bModule : NSObject

+ (instancetype)shared;
- (void)setup;

@end

NS_ASSUME_NONNULL_END
