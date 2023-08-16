//
//  AskView.m
//  RY
//
//  Created by gwh on 2022/6/30.
//

#import "AskView.h"
#import "b.h"

@implementation AskView

+ (void)playAsk:(id)content cancelContent:(NSString *)cancelContent okContent:(NSString *)okContent block:(void(^)(BOOL ok))block {
    AskView *v = AskView.new;
    v.content = content;
    v.cancelContent = cancelContent;
    v.okContent = okContent;
    [v initUI];
    [v addBlock:block];
    [b.ui.currentUIViewController.view addSubview:v];
}

+ (void)playAsk:(id)content okContent:(NSString *)okContent block:(void(^)(BOOL ok))block {
    AskView *v = AskView.new;
    v.content = content;
    v.okContent = okContent;
    [v initUI];
    [v addBlock:block];
    [b.ui.currentUIViewController.view addSubview:v];
}

+ (void)playAsk:(NSString *)content block:(void(^)(BOOL ok))block {
//    AskView *v = AskView.new;
//    [v initUI];
//    [v addAsk:content block:block];
//    [b.ui.currentUIViewController.view addSubview:v];
    
    [b.ui showAltOn:b.ui.currentUIViewController title:content msg:@"" bts:@[@"取消",@"确定"] block:^(int index, NSString * _Nonnull indexTitle) {
        block(index);
    }];
}

+ (void)playAsk_cannotClose:(NSString *)content block:(void(^)(BOOL ok))block {
    AskView *v = AskView.new;
    v.cannotClose = YES;
    [v initUI];
    [v addAsk:content block:block];
    [b.ui.currentUIViewController.view addSubview:v];
}

- (void)initUI {
    
    self.size = CGSizeMake(WIDTH(), HEIGHT());
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    UIButton *close = UIButton.new;
    close.size = CGSizeMake(WIDTH(), HEIGHT());
    [self addSubview:close];
    [close addTappedOnceWithBlock:^(UIView *v) {
        if (self.cannotClose) {
            return;
        }
        [self removeFromSuperview];
    }];
    
    float w = RH(270);
    UIView *contentView = UIView.new;
    contentView.size = CGSizeMake(w, w*0.618);
    [self addSubview:contentView];
    contentView.backgroundColor = UIColor.blackColor;
    contentView.layer.cornerRadius = RH(5);
    contentView.center = CGPointMake(WIDTH()/2, HEIGHT()/2);
    contentView.layer.borderColor = UIColor.whiteColor.CGColor;
    contentView.layer.borderWidth = RH(2);
    
    UILabel *label = UILabel.new;
    label.width = contentView.width-RH(20);
    label.numberOfLines = 0;
    label.font = RF(16);
//    int c = 0;
    float h = 0;
    if ([_content isKindOfClass:NSMutableAttributedString.class]) {
        NSMutableAttributedString *att = _content;
        
        label.attributedText = att;
        [label sizeToFit];
        h = label.height+RH(80);
//        c = att.length;
    } else {
        NSString *text = _content;
        label.text = text;
        [label sizeToFit];
        h = label.height+RH(80);
//        c = att.length;
    }
    if (h > contentView.height) {
        contentView.size = CGSizeMake(w, h);
    }
//    if (c > 60) {
//        contentView.size = CGSizeMake(w, w*0.618+(c-60)*2.8);
        contentView.center = CGPointMake(WIDTH()/2, HEIGHT()/2);
//    }
    
    UITextView *askView = UITextView.new;
    askView.editable = NO;
    [contentView addSubview:askView];
    askView.size = CGSizeMake(contentView.width-RH(15), contentView.height-RH(50));
    askView.left = RH(10);
    askView.top = RH(10);
    askView.backgroundColor = UIColor.clearColor;
    askView.textColor = UIColor.whiteColor;
    askView.font = RF(16);
    askView.editable = NO;
    _askView = askView;
    
    if (_content) {
//        contentView.size = CGSizeMake(w, w);
//        contentView.center = CGPointMake(WIDTH()/2, HEIGHT()/2);
//        askView.size = CGSizeMake(contentView.width-RH(15), contentView.height-RH(50));
        if ([_content isKindOfClass:NSMutableAttributedString.class]) {
            askView.attributedText = _content;
        } else {
            askView.text = _content;
        }
    }
    NSLog(@"%d",askView.text.length);
    
    {
        UIButton *pk = UIButton.b_UIButton;
        [contentView addSubview:pk];
        pk.size = CGSizeMake(contentView.width/2, RH(40));
        pk.bottom = contentView.height;
        pk.backgroundColor = UIColor.blackColor;
        pk.b_normalTitle = @"取消";
        [pk addTappedOnceWithBlock:^(UIView *v) {
            self.finishBlock(NO);
            [self removeFromSuperview];
        }];
        if (_cancelContent) {
            pk.b_normalTitle = _cancelContent;
        }
    }
    {
        UIButton *pk = UIButton.b_UIButton;
        [contentView addSubview:pk];
        pk.size = CGSizeMake(contentView.width/2, RH(40));
        pk.left = pk.size.width;
        pk.bottom = contentView.height;
        pk.backgroundColor = UIColor.blackColor;
        pk.b_normalTitle = @"确定";
        pk.titleLabel.font = RF(16);
        [pk addTappedOnceWithBlock:^(UIView *v) {
            self.finishBlock(YES);
            [self removeFromSuperview];
        }];
        if (_okContent) {
            pk.b_normalTitle = _okContent;
        }
    }
}

- (void)addBlock:(void(^)(BOOL ok))block {
    _finishBlock = block;
}

- (void)addAsk:(NSString *)content block:(void(^)(BOOL ok))block {
    _askView.text = content;
    _finishBlock = block;
}

@end
