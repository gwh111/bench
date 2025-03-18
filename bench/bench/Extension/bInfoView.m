//
//  bInfoView.m
//  bench
//
//  Created by gwh on 2025/3/11.
//

#import "bInfoView.h"
#import "bench.h"

@implementation bInfoView

+ (void)showInfoStr:(NSString *)str {
    bInfoView *info = bInfoView.new;
    info.str = str;
    [b.ui.currentUIViewController.view addSubview:info];
    [info initUI];
}

+ (void)showInfo:(NSMutableAttributedString *)att {
    bInfoView *info = bInfoView.new;
    info.att = att;
    [b.ui.currentUIViewController.view addSubview:info];
    [info initUI];
}

- (void)initUI {
    
    self.width = WIDTH();
    self.height = HEIGHT();
    [self addBlurEffectView];
    
    [self addTappedOnceWithBlock:^(UIView * _Nonnull view) {
        [view dismiss];
    }];
    
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    UIView *popV = UIView.new;
    popV.width = WIDTH()-RH(40);
    popV.height = popV.width;
    popV.centerX = WIDTH()/2;
    popV.centerY = HEIGHT()/2;
    [self addSubview:popV];
    popV.backgroundColor = UIColor.blackColor;
    popV.layer.cornerRadius = RH(10);
    popV.layer.borderColor = UIColor.whiteColor.CGColor;
    popV.layer.borderWidth = 1;
    
    UITextView *textview = UITextView.new;
    textview.width = popV.width-RH(20);
    textview.height = popV.height-RH(10);
    textview.left = RH(10);
    textview.editable = NO;
    textview.backgroundColor = UIColor.clearColor;
    textview.textColor = UIColor.whiteColor;
    textview.font = RF(16);
    [popV addSubview:textview];
    if (_att) {
        textview.attributedText = _att;
    }
    if (_str) {
        textview.text = _str;
    }
}

@end
