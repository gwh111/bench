//
//  b+Plug.m
//  bench
//
//  Created by apple on 2023/7/12.
//

#import "b+Extension.h"

@implementation b (Extension)

+ (void)playTalk:(NSString *)talk rf:(UIFont *)rf block:(void (^)(void))block {
    [self playTalks:@[talk] name:@"" rf:rf block:block];
}

+ (void)playTalk:(NSString *)talk block:(void (^)(void))block {
    [self playTalks:@[talk] name:@"" rf:nil block:block];
}

+ (void)playTalks:(NSArray *)talks block:(void (^)(void))block {
    [self playTalks:talks name:@"" rf:nil block:block];
}

+ (bTalkView *)playCannotTapTalks:(NSArray *)talks block:(void (^)(void))block {
    bTalkView *t = [self playTalks:talks name:@"" rf:nil block:block];
    t.cannotTap = YES;
    return t;
}

+ (bTalkView *)playTalks:(NSArray *)talks name:(NSString *)name rf:(UIFont *)rf block:(void (^)(void))block {

//    if (!bTalkView.shared.talksCacheList) {
//        bTalkView.shared.talksCacheList = NSMutableArray.new;
//    }
//    if (bTalkView.shared.talksCacheList.count > 0) {
//        NSDictionary *cache = @{@"talks":talks,@"name":name,@"block":block};
//        id t = bTalkView.shared.talksCacheList;
//        [bTalkView.shared.talksCacheList addObject:cache];
//        return nil;
//    }
//    NSDictionary *cache = @{@"talks":talks,@"name":name,@"block":block};
//    [bTalkView.shared.talksCacheList addObject:cache];
    
    bTalkView *talk = bTalkView.new;
    talk.talkArr = talks;
    talk.name = name;
    talk.rf = rf;
    [b.ui.currentUIViewController.view addSubview:talk];
    [talk initUI];
    [talk playTalk:block];
    return talk;
}

+ (void)playTrueTalks:(NSArray *)talks name:(NSString *)name block:(void (^)(void))block {
    bTalkView *talk = bTalkView.new;
    talk.talkArr = talks;
    talk.name = name;
    [b.ui.currentUIViewController.view addSubview:talk];
    [talk initUI];
    [talk playTalk:block];
}

@end
