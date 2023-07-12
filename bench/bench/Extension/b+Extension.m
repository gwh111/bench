//
//  b+Plug.m
//  bench
//
//  Created by apple on 2023/7/12.
//

#import "b+Extension.h"

@implementation b (Extension)

+ (void)playTalks:(NSArray *)talks block:(void (^)(void))block {
    [self playTalks:talks name:@"" block:block];
}

+ (bTalkView *)playCannotTapTalks:(NSArray *)talks block:(void (^)(void))block {
    bTalkView *t = [self playTalks:talks name:@"" block:block];
    t.cannotTap = YES;
    return t;
}

+ (bTalkView *)playTalks:(NSArray *)talks name:(NSString *)name block:(void (^)(void))block {

    if (!bTalkView.shared.talksCacheList) {
        bTalkView.shared.talksCacheList = NSMutableArray.new;
    }
    if (bTalkView.shared.talksCacheList.count > 0) {
        NSDictionary *cache = @{@"talks":talks,@"name":name,@"block":block};
        [bTalkView.shared.talksCacheList addObject:cache];
        return nil;
    }
    NSDictionary *cache = @{@"talks":talks,@"name":name,@"block":block};
    [bTalkView.shared.talksCacheList addObject:cache];
    
    bTalkView *talk = bTalkView.new;
    talk.talkArr = talks;
    talk.name = name;
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
