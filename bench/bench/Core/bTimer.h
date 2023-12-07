//
//  CC_TManager.h
//  bench_ios
//
//  Created by gwh on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bThread.h"

@interface bTimer : NSObject

+ (instancetype)shared;

// 注册定时任务
// @param name 定时任务名称
// @param interval 时间间隔
- (void)registerT:(NSString *)name interval:(float)interval block:(void (^)(void))block;

// 取消注册的定时任务
- (void)unRegisterT:(NSString *)name;

- (NSString *)uniqueNowTimestamp;
- (NSString *)nowTimeTimestamp;

- (void)pause;
- (void)play;

@end



