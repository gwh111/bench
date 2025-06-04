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
    
//    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    UIView *popV = UIView.new;
    popV.width = WIDTH();
    popV.height = RH(200);
    popV.centerX = WIDTH()/2;
    popV.centerY = HEIGHT()/2;
    [self addSubview:popV];
//    popV.backgroundColor = RGBA(0, 0, 0, 1);
    
    NSString *text = _str;
    if (_att) {
        text = _att.string;
    }
    popV.height = RH(50)+RH(50)*text.length/20;
    float max = HEIGHT()-SAFE_BOTTOM()-SAFE_TOP()-RH(100);
    if (popV.height > max) {
        popV.height = max;
    }
    popV.centerY = HEIGHT()/2;
    
//    {
//        UIView *alphaview = UIView.new;
//        alphaview.width = WIDTH();
//        alphaview.height = popV.width;
//        alphaview.centerX = WIDTH()/2;
//        alphaview.bottom = popV.top;
//        [self addSubview:alphaview];
//        [alphaview addFadeBlackLayerFromBottom];
//    }
//    {
//        UIView *alphaview = UIView.new;
//        alphaview.width = WIDTH();
//        alphaview.height = popV.width;
//        alphaview.centerX = WIDTH()/2;
//        alphaview.top = popV.bottom;
//        [self addSubview:alphaview];
//        [alphaview addFadeBlackLayerFromTop];
//    }
    
//    popV.layer.cornerRadius = RH(10);
//    popV.layer.borderColor = UIColor.whiteColor.CGColor;
//    popV.layer.borderWidth = 1;
    
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
