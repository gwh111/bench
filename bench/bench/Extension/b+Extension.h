//
//  b+Plug.h
//  bench
//
//  Created by apple on 2023/7/12.
//

#import "b.h"
#import "bTalkView.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (Extension)

+ (bTalkView *)playCannotTapTalks:(NSArray *)talks block:(void (^)(void))block;
+ (bTalkView *)playTalks:(NSArray *)talks name:(NSString *)name block:(void (^)(void))block;
+ (void)playTrueTalks:(NSArray *)talks name:(NSString *)name block:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
