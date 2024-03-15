//
//  CC_TManager.m
//  bench_ios
//
//  Created by gwh on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "bTimer.h"
#import "bThread.h"
#import "bBase.h"

@interface bTimer() {
}

@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, retain) NSMutableArray *registerNameMutArr;
@property (nonatomic, retain) NSMutableArray *registerBlockMutArr;
@property (nonatomic, retain) NSMutableArray *registerTimeMutArr;
@property (nonatomic, retain) NSMutableDictionary *registerMutDic;

@property (nonatomic, retain) NSDate *lastDate;
@property (nonatomic, retain) NSLock *lock;

@property (nonatomic, assign) float minF;

@property (nonatomic, assign) NSString *currentUniqueTimeStamp;
@property (nonatomic, assign) int currentUniqueTimeStampCount;

@end

@implementation bTimer
@synthesize registerNameMutArr,registerBlockMutArr,registerTimeMutArr,registerMutDic,lastDate,minF,currentUniqueTimeStamp,currentUniqueTimeStampCount,lock;

static bTimer *userManager = nil;
static dispatch_once_t onceToken;

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[bTimer alloc]init];
        [userManager start];
    });
    return userManager;
}

//+ (instancetype)shared {
//    CC_Timer *timer = CC_Timer.new;
//    [timer start];
//    [bBase.shared addSharedKey:@"timer" object:timer];
//    return timer;
//}

- (void)start {
    lock = NSLock.new;
    minF = 0.1;
    registerMutDic = NSMutableDictionary.new;
    registerBlockMutArr = NSMutableArray.new;
    registerNameMutArr = NSMutableArray.new;
    registerTimeMutArr = NSMutableArray.new;
    [self initTimer];
}

- (void)initTimer {
    if (!self.timer) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self->minF target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]run];
        });
    }
}

- (void)pause {
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)play {
    [_timer setFireDate:[NSDate date]];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)runTimer {
    if (registerTimeMutArr.count == 0) {
        return;
    }
    [lock lock];
    NSTimeInterval add = 0;
    NSDate *d2 = [NSDate date];
    if (!lastDate) {
        add = minF;
    } else {
        add = [d2 timeIntervalSinceDate:lastDate];;
    }
    lastDate = d2;
    
    for (int i = 0; i < registerTimeMutArr.count; i++) {
        float getT = [registerTimeMutArr[i] floatValue];
        NSString *name = registerNameMutArr[i];
        float need = [registerMutDic[name] floatValue];
        if (getT + add < need) {
            [registerTimeMutArr replaceObjectAtIndex:i withObject:@(getT + add)];
        }else{
            //            float plus = getT + add - need;
            
            [registerTimeMutArr replaceObjectAtIndex:i withObject:@(0)];
            
            [bThread.shared gotoMain:^{
                if (self->registerBlockMutArr.count > i) {
                    void (^myBlock)(void) = self->registerBlockMutArr[i];
                    //                    NSLog(@"lastDate%@ %d %f",lastDate,registerTimeMutArr.count,plus);
                    myBlock();
                }
            }];
        }
    }
    [lock unlock];
}

- (void)registerWithRunT:(NSString *)name interval:(float)interval block:(void (^)(void))block {
    [self registerT:name interval:interval block:block];
    block();
}

- (void)registerT:(NSString *)name interval:(float)interval block:(void (^)(void))block {
    if (!name) {
        NSLog(@"no name");
    }
    if (!interval) {
        NSLog(@"interval invalid");
    }
    if (registerMutDic[name]) {
        NSLog(@"已经注册了 '%@' 替换成新的定时任务",name);
        [self unRegisterT:name];
    }
    //防重复
    [lock lock];
    [registerMutDic setObject:@(interval) forKey:name];
    [registerNameMutArr addObject:name];
    [registerBlockMutArr addObject:block];
    [registerTimeMutArr addObject:@(0)];
    [lock unlock];
    [self initTimer];
}

- (void)unRegisterT:(NSString *)name {
    if (!name) {
        NSLog(@"no name");
    }
    if (registerNameMutArr.count == 0) {
        return;
    }
    [lock lock];
    //写保护
    [registerMutDic removeObjectForKey:name];
    int index = -1;
    for (int i = 0; i < registerNameMutArr.count; i++) {
        if ([registerNameMutArr[i]isEqualToString:name]) {
            index = i;
        }
    }
    if (index >= 0) {
        [registerNameMutArr removeObjectAtIndex:index];
        [registerBlockMutArr removeObjectAtIndex:index];
        [registerTimeMutArr removeObjectAtIndex:index];
    }
    [lock unlock];
    if (registerNameMutArr.count == 0) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (NSString *)uniqueNowTimestamp {
    NSString *timestamp = [self nowTimeTimestamp];
    if (currentUniqueTimeStamp) {
        if ([currentUniqueTimeStamp isEqualToString:timestamp]) {
            //如果相等 即是出现并发
            currentUniqueTimeStampCount++;

            return [NSString stringWithFormat:@"%@_%d",currentUniqueTimeStamp,currentUniqueTimeStampCount];
        }else{
            
            currentUniqueTimeStampCount = 0;
            currentUniqueTimeStamp = timestamp;
            return timestamp;
        }
    }
    currentUniqueTimeStampCount = 0;
    currentUniqueTimeStamp = timestamp;
    return timestamp;
}

- (NSString *)nowTimeTimestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

@end
