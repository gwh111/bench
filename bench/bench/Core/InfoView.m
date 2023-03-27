//
//  InfoView.m
//  RY
//
//  Created by gwh on 2022/7/22.
//

#import "InfoView.h"
#import "b.h"

@implementation InfoView

+ (void)playSmallInfo:(id)content block:(void(^)(BOOL ok))block {
    InfoView *v = InfoView.new;
    v.isSmall = YES;
    [v initUI];
    [v addInfo:content block:block];
    [b.ui.currentUIViewController.view addSubview:v];
}

+ (void)playInfo:(id)content block:(void(^)(BOOL ok))block {
    InfoView *v = InfoView.new;
    [v initUI];
    [v addInfo:content block:block];
    [b.ui.currentUIViewController.view addSubview:v];
}

- (void)initUI {
    
    self.size = CGSizeMake(WIDTH(), HEIGHT());
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    float w = WIDTH()*2/3;
    UIView *contentView = UIView.new;
    contentView.size = CGSizeMake(w, w/0.618);
    if (_isSmall) {
        contentView.size = CGSizeMake(w, w*0.618);
    }
    [self addSubview:contentView];
    contentView.backgroundColor = UIColor.blackColor;
    contentView.layer.cornerRadius = RH(5);
    contentView.center = CGPointMake(WIDTH()/2, HEIGHT()/2);
    contentView.layer.borderColor = UIColor.whiteColor.CGColor;
    contentView.layer.borderWidth = RH(2);
    
    UITextView *askView = UITextView.new;
    askView.editable = NO;
    [contentView addSubview:askView];
    askView.size = CGSizeMake(contentView.width-RH(20), contentView.height-RH(50));
    askView.left = RH(10);
    askView.top = RH(10);
    askView.backgroundColor = UIColor.clearColor;
    askView.textColor = UIColor.whiteColor;
    askView.font = BRF(16);
    askView.textContainer.lineBreakMode = NSLineBreakByCharWrapping;
    askView.selectable = NO;
    _askView = askView;
    
//    {
//        UIButton *pk = UIButton.b_UIButton;
//        [contentView addSubview:pk];
//        pk.size = CGSizeMake(contentView.width/2, RH(40));
//        pk.bottom = contentView.height;
//        pk.backgroundColor = UIColor.blackColor;
//        pk.b_normalTitle = @"取消";
//        [pk addTappedOnceWithBlock:^(UIView *v) {
//            self.finishBlock(NO);
//            [self removeFromSuperview];
//        }];
//    }
    {
        UIButton *pk = UIButton.b_UIButton;
        [contentView addSubview:pk];
        pk.size = CGSizeMake(contentView.width, RH(40));
//        pk.left = pk.size.width;
        pk.bottom = contentView.height;
        pk.backgroundColor = UIColor.blackColor;
        pk.b_normalTitle = @"确定";
        pk.titleLabel.font = BRF(16);
        [pk addTappedOnceWithBlock:^(UIView *v) {
            self.finishBlock(YES);
            [self removeFromSuperview];
        }];
    }
}

- (void)addInfo:(id)content block:(void(^)(BOOL ok))block {
    if ([content isKindOfClass:NSString.class]) {
        _askView.text = content;
    } else {
        _askView.attributedText = content;
    }
    _finishBlock = block;
}

@end
