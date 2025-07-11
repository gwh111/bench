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
    AskView *v = AskView.new;
    [v initUI];
    [v addAsk:content block:block];
    [b.ui.currentUIViewController.view addSubview:v];
    
//    [b.ui showAltOn:b.ui.currentUIViewController title:content msg:@"" bts:@[@"取消",@"确定"] block:^(int index, NSString * _Nonnull indexTitle) {
//        block(index);
//    }];
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
    
    [self addBlurEffectView];
    
    UIButton *close = UIButton.new;
    close.size = CGSizeMake(WIDTH(), HEIGHT());
    [self addSubview:close];
    [close addTappedOnceWithBlock:^(UIView *v) {
        if (self.cannotClose) {
            return;
        }
        [self dismiss];
    }];
    
    UIImageView *back = UIImageView.new;
    back.size = CGSizeMake(WIDTH(), WIDTH());
    back.image = [UIImage imageNamed:@"ui_point/point_square"];
    back.centerX = WIDTH()/2;
    back.top = RH(10);
    back.centerY = HEIGHT()/2;
    [self addSubview:back];
    [back addShakeTimes:2 block:^{
            
    }];
    
    float w = back.width-RH(100);
    float h1 = back.height-RH(80);
    h1 = RH(100);
    UIView *contentView = UIView.new;
    contentView.size = CGSizeMake(w, h1);
    [self addSubview:contentView];
//    contentView.backgroundColor = UIColor.blackColor;
//    contentView.layer.cornerRadius = RH(5);
//    contentView.layer.borderColor = UIColor.whiteColor.CGColor;
//    contentView.layer.borderWidth = RH(2);
    
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
//        contentView.center = CGPointMake(WIDTH()/2, HEIGHT()/2);
//    }
    contentView.centerX = WIDTH()/2;
    contentView.centerY = HEIGHT()/2;
//    contentView.backgroundColor = UIColor.yellowColor;
    
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
        UIButton *pk = UIButton.b_gameInkButton;
        [self addSubview:pk];
        pk.width = contentView.width/2;
//        pk.size = CGSizeMake(contentView.width/2, RH(40));
        pk.top = contentView.bottom+RH(10);
        pk.left = contentView.left;
//        pk.backgroundColor = UIColor.blackColor;
        pk.b_normalTitle = @"取消";
        [pk addTappedOnceWithBlock:^(UIView *v) {
            self.finishBlock(NO);
            [self dismiss];
        }];
        if (_cancelContent) {
            pk.b_normalTitle = _cancelContent;
        }
        pk.right = 0;
        [UIView animateWithDuration:0.25 animations:^{
            pk.left = contentView.left;
        }];
    }
    {
        UIButton *pk = UIButton.b_gameInkButton;
        [self addSubview:pk];
        pk.width = contentView.width/2;
//        pk.size = CGSizeMake(contentView.width/2, RH(40));
        pk.right = contentView.right;
        pk.top = contentView.bottom+RH(10);
//        pk.backgroundColor = UIColor.blackColor;
        pk.b_normalTitle = @"确定";
//        pk.titleLabel.font = RF(16);
        [pk addTappedOnceWithBlock:^(UIView *v) {
            self.finishBlock(YES);
            [self dismiss];
        }];
        if (_okContent) {
            pk.b_normalTitle = _okContent;
        }
        pk.left = WIDTH();
        [UIView animateWithDuration:0.25 animations:^{
            pk.right = contentView.right;
        }];
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
