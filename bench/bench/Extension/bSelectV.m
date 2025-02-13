//
//  SelectV.m
//  tower
//
//  Created by gwh on 2018/12/21.
//  Copyright © 2018 gwh. All rights reserved.
//

#import "bSelectV.h"
#import "bLabelGroup.h"
#import "bench.h"

@interface bSelectV()<bLabelGroupDelegate>{
    UIView *popV;
    
    UITextView *desT;
    bLabelGroup *group;
    
    UIButton *leftBt;
    UIButton *rightBt;
}

@end

@implementation bSelectV

- (void)dismiss {
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)start {
    self.backgroundColor = RGBA(0, 0, 0, .5);
    self.frame = CGRectMake(0, 0, WIDTH(), HEIGHT());
    self.alpha = 0;
    [UIView animateWithDuration:.4f animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)initUI {
    
    [self start];
    
    float h = RH(200);
    popV = UIView.new;
    popV.frame = CGRectMake(0, HEIGHT() - h, WIDTH(), h);
    [self addSubview:popV];
    popV.backgroundColor = UIColor.blackColor;
    
    UIImageView *up = UIImageView.new;
    up.frame = CGRectMake(0, 0, WIDTH(), RH(50));
    up.image = [UIImage imageNamed:@"Po/ui/fadeToUp"];
    up.bottom = popV.top;
    [self addSubview:up];
    
    UIImageView *bottom = UIImageView.new;
    bottom.frame = CGRectMake(0, 0, WIDTH(), RH(50));
    bottom.image = [UIImage imageNamed:@"Po/ui/fadeToBottom"];
    bottom.top = popV.bottom;
    [self addSubview:bottom];
    
    UIButton *close = UIButton.new;
    close.frame = CGRectMake(0, 0, WIDTH(), popV.top);
    [self addSubview:close];
    [close addTappedButtonOnceWithBlock:^(UIButton * _Nonnull button) {
        if (!self->_canCancel) {
            return;
        }
        [self dismiss];
    }];
    
    desT = UITextView.new;
    desT.frame = CGRectMake(RH(10), 0, WIDTH() - RH(20), RH(80));
    desT.backgroundColor = [UIColor clearColor];
    desT.textColor = UIColor.whiteColor;
    desT.editable = NO;
    desT.selectable = NO;
    desT.font = RF(16);
    [popV addSubview:desT];
    
    group = bLabelGroup.new;
    group.width = WIDTH();
    group.height = RH(50);
    group.top = desT.bottom;
    group.delegate = self;
    [group updateType:bLabelAlignmentTypeCenter width:WIDTH() stepWidth:RH(10) sideX:RH(10) sideY:RH(5) itemHeight:RH(35) margin:RH(20)];
    [popV addSubview:group];
//    group.backgroundColor = UIColor.yellowColor;
//    [popV addTappedOnceWithBlock:^(UIView * _Nonnull view) {
//            
//    }];
    
}

- (void)labelGroup:(bLabelGroup *)group initWithButton:(UIButton *)button {
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:RGBA(255, 255, 255, .1)];
    button.titleLabel.font = RF(16);
    button.layer.cornerRadius = 4;
    if ([button.titleLabel.text isEqualToString:@"♂"]) {

        [button setTitleColor:UIColor.b_lightBlue forState:UIControlStateNormal];
    } else if ([button.titleLabel.text isEqualToString:@"♀"]) {
    
        [button setTitleColor:UIColor.b_lightRed forState:UIControlStateNormal];
    }
}

- (void)labelGroup:(bLabelGroup *)group button:(UIButton *)button tappedAtIndex:(NSUInteger)index {
    NSString *name = button.titleLabel.text;
    [self dismiss];
    _selectBlock(index);
}

- (void)labelGroupInitFinish:(bLabelGroup *)group {
    
}

- (void)playAsk:(NSString *)askStr selectArr:(NSArray *)selectArr block:(void (^)(NSUInteger select))block {
    _selectBlock = block;
    desT.text = askStr;
    
    [group updateLabels:selectArr selected:nil];
}

- (void)what {
    NSLog(@"sd");
//    CC_Button *button = ccs.Button;
//    button.left = 10;
}

@end
