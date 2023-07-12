//
//  TalkV.h
//  tower
//
//  Created by gwh on 2018/12/20.
//  Copyright © 2018 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bUIModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface bTalkView : bUIModule

@property(nonatomic,retain) NSArray *talkArr;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSMutableArray *talksCacheList;

@property(nonatomic,assign) int stopFlick;
//@property(strong) void (^finishTalkBlock)(void);
@property(nonatomic,assign) int cannotTap;

- (void)initUI;
- (void)playTalk:(void (^)(void))block;
//- (void)playAutoTalk:(void (^)(void))block delay:(float)delay;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
