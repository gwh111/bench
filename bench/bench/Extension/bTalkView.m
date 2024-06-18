//
//  TalkV.m
//  tower
//
//  Created by gwh on 2018/12/20.
//  Copyright © 2018 gwh. All rights reserved.
//

#import "bTalkView.h"
#import "bench.h"
#import "b+Extension.h"

@interface bTalkView() {
    UIView *popV;
    
    UITextView *desT;
    NSThread *thread;
    int currentPage;
    
    int stopAni;
    
    UILabel *flick;
    int flickCount;
    
    int hasBlock;
}

@end

@implementation bTalkView

- (void)dismiss {
    if (_cannotTap) {
        return;
    }
    [thread cancel];
    _talkArr = nil;
    self->currentPage = 0;
    
//    if (_talksCacheList.count > 0) {
////        NSDictionary *cache = SPData.shared.talksCacheList.firstObject;
//        [_talksCacheList removeObjectAtIndex:0];
//        if (_talksCacheList.count > 0) {
//            NSDictionary *cache = _talksCacheList.firstObject;
//            [b playTrueTalks:cache[@"talks"] name:cache[@"name"] block:cache[@"block"]];
//        }
//    }
    
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//        self.hidden = YES;
    }];
}

- (void)start {
}

- (void)initUI {
    
//    if (popV) {
//        self.alpha = 1;
////        self.hidden = NO;
//        return;
//    }
    
    self.backgroundColor = RGBA(0, 0, 0, 0);
    self.frame = CGRectMake(0, 0, WIDTH(), HEIGHT());
    self.alpha = 0;
    [UIView animateWithDuration:.4f animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    float h = RH(100);
    popV = UIView.new;
    [self addSubview:popV];
    popV.frame = CGRectMake(RH(10), self.height - h - b.ui.safeBottom, WIDTH() - RH(20), h);
    popV.backgroundColor = UIColor.blackColor;
    popV.layer.cornerRadius = 4;
    popV.layer.borderColor = UIColor.whiteColor.CGColor;
    popV.layer.borderWidth = 2;
    
    
    UIButton *close = UIButton.new;
    close.frame = CGRectMake(0, 0, WIDTH(), popV.top);
    [self addSubview:close];
    
    desT = UITextView.new;
    desT.frame = CGRectMake(RH(10), 0, popV.width - RH(20), RH(90));
    desT.backgroundColor = [UIColor clearColor];
    desT.textColor = UIColor.whiteColor;
    desT.editable = NO;
    desT.selectable = NO;
    desT.font = RF(16);
    [popV addSubview:desT];
    
    UIFont *rf = self.rf;
    if (rf) {
        desT.font = rf;
    }
    
    flick = UILabel.new;
    flick.size = CGSizeMake(RH(20), RH(20));
    flick.center = CGPointMake(desT.width - RH(20), desT.height - RH(10));
    flick.textColor = UIColor.b_lightBlue;
    flick.font = RF(16);
    [desT addSubview:flick];
    flick.text = @"▼";
    [self addFlickAni];
    flick.hidden = YES;
    if (rf) {
        flick.font = rf;
    }
}

- (void)addFlickAni {
    if (_stopFlick) {
        return;
    }
    [UIView animateWithDuration:.2f animations:^{
        self->flick.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5f animations:^{
            self->flick.alpha = 1;
        } completion:^(BOOL finished) {
            [self addFlickAni];
        }];
    }];
}

- (void)playAutoTalk:(void (^)(void))block delay:(float)delay {
    currentPage = 0;
    [self startAni];
    
    [b delay:.9 block:^{
        
        UIButton *nextBt = UIButton.new;
        nextBt.frame = self->desT.frame;
        nextBt.height = nextBt.height * 2;
        [self->popV addSubview:nextBt];
        [nextBt addTappedOnceWithBlock:^(UIView *v) {
            [self next:block];
        }];
    }];
    
    [b delay:delay block:^{
        
        [self next:block];
    }];
}

- (void)playTalk:(void (^)(void))block {
    
    currentPage = 0;
    [self startAni];
    
    UIButton *nextBt = UIButton.new;
    nextBt.frame = self->desT.frame;
    nextBt.height = nextBt.height * 2;
    [self->popV addSubview:nextBt];
    if (b.isDebug) {
        [nextBt addTappedOnceWithBlock:^(UIView *v) {
            if (block) {
                [self next:block];
            }
        }];
        return;
    }
    [nextBt addTappedOnceWithBlock:^(UIView *v) {
        if (block) {
            [self next:block];
        }
    }];
}

- (void)next:(void (^)(void))block {
    self->currentPage++;
    if (self->currentPage >= self->_talkArr.count) {
        if (hasBlock == 1) {
            return;
        }
        hasBlock = 1;
        _stopFlick = YES;
        [self dismiss];
        block();
        return ;
    }
    self->stopAni = 1;
    [b delay:.1 block:^{
        self->stopAni = 0;
        self->flick.hidden=YES;
        [self startAni];
    }];
}

- (void)startAni {
    [thread cancel];
    thread = [[NSThread alloc]initWithTarget:self selector:@selector(animationLabel) object:nil];
    [thread start];
}

- (void)animationLabel {
    if (currentPage >= _talkArr.count) {
        return;
    }
    NSString *contentStr = _talkArr[currentPage];
//    NSString *nickN = ccs.nickName;
//    if (nickN) {
//        contentStr = [contentStr stringByReplacingOccurrencesOfString:@"xxx" withString:nickN];
//    }
    if (_name.length > 0) {
        NSMutableAttributedString *att = NSMutableAttributedString.new;
        [att b_appendAttStr:[NSString stringWithFormat:@"%@:",_name] color:UIColor.b_lightYellow font:RF(16)];
        [att b_appendAttStr:contentStr color:UIColor.whiteColor font:RF(16)];
        for (NSInteger i = 0; i < att.length; i++) {
            if (stopAni) {
                break;
            }
            [self performSelectorOnMainThread:@selector(refreshUIWithContentAttStr:) withObject:[att attributedSubstringFromRange:NSMakeRange(0, i + 1)] waitUntilDone:YES];
            float ani = 0.05;
//            if (DEBUG) {
//                ani = 0.01;
//            }
            [NSThread sleepForTimeInterval:ani];
            if (i == att.length - 1) {
                
                [b gotoMain:^{
                    
                    self->flick.hidden = NO;
//                    self->flickCount++;
//                    if (self->flickCount == 10) {
//                        self->stopFlick = YES;
//                        [self dismiss];
//                    }
                }];
            }
        }
        return;
    }
    for (NSInteger i = 0; i < contentStr.length; i++) {
        if (stopAni) {
            break;
        }
        [self performSelectorOnMainThread:@selector(refreshUIWithContentStr:) withObject:[contentStr substringWithRange:NSMakeRange(0, i + 1)] waitUntilDone:YES];
        float ani = 0.05;
//        if (DEBUG) {
//            ani = 0.01;
//        }
        [NSThread sleepForTimeInterval:ani];
        if (i == contentStr.length - 1) {
            
            [b gotoMain:^{
                
                self->flick.hidden = NO;
            }];
        }
    }
}

- (void)what {
    NSLog(@"label");
    UILabel *button = UILabel.new;
    button.left = 210;
}

- (void)refreshUIWithContentStr:(NSString *)contentStr {
    desT.text = contentStr;
}

- (void)refreshUIWithContentAttStr:(NSAttributedString *)contentAttStr {
    desT.attributedText = contentAttStr;
}

@end
