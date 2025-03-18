//
//  b+Plug.h
//  bench
//
//  Created by apple on 2023/7/12.
//

#import "b.h"
#import "bTalkView.h"
#import "bSelectV.h"
#import "bLabelGroup.h"
#import "bInfoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (Extension)

+ (void)showInfo:(NSMutableAttributedString *)att;
+ (void)showInfoStr:(NSString *)str;

+ (bTalkView *)playCannotTapTalks:(NSArray *)talks block:(void (^)(void))block;

+ (void)playTalk:(NSString *)talk rf:(UIFont *)rf block:(void (^)(void))block;
+ (void)playTalk:(NSString *)talk block:(void (^)(void))block;
+ (void)playTalks:(NSArray *)talks block:(void (^)(void))block;

+ (bTalkView *)playTalks:(NSArray *)talks name:(NSString *)name block:(void (^)(void))block;
+ (void)playTrueTalks:(NSArray *)talks name:(NSString *)name block:(void (^)(void))block;

+ (void)playAsk:(NSString *)askStr selectArr:(NSArray *)selectArr block:(void (^)(NSUInteger select))block;
+ (void)playCanCancelAsk:(NSString *)askStr selectArr:(NSArray *)selectArr block:(void (^)(NSUInteger select))block;

@end

NS_ASSUME_NONNULL_END
