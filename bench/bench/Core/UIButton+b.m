//
//  UIButton+p.m
//  PandoraBox
//
//  Created by gwh on 2022/1/7.
//

#import "UIButton+b.h"

@implementation UIButton (b)

+ (UIButton *)b_UIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    ui.titleLabel.font = RF(16);
    return ui;
}

+ (UIButton *)b_borderUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    [ui setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.darkGrayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.grayColor.CGColor;
    return ui;
}

+ (UIButton *)b_blackBorderUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(50), RH(50));
    ui.layer.cornerRadius = RH(4);
    [ui setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.borderWidth = 2;
    ui.layer.borderColor = UIColor.blackColor.CGColor;
    ui.titleLabel.font = BRF(16);
    ui.b_normalColor = UIColor.blackColor;
    return ui;
}

+ (UIButton *)b_borderRadiusUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    [ui setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.darkGrayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.cornerRadius = RH(4);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.grayColor.CGColor;
    return ui;
}

+ (UIButton *)b_roundSingelUIButton {
    UIButton *pk = UIButton.b_UIButton;
    pk.size = CGSizeMake(RH(30), RH(30));
    pk.layer.cornerRadius = RH(15);
    pk.layer.borderColor = UIColor.whiteColor.CGColor;
    pk.layer.borderWidth = 1;
    pk.titleLabel.font = BRF(12);
    pk.b_normalColor = UIColor.whiteColor;
    pk.backgroundColor = RGBA(0, 0, 0, 0.5);
    return pk;
}

- (void)setB_normalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setB_normalColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setB_font:(UIFont *)font {
    self.titleLabel.font = font;
}

- (void)addTappedButtonOnceWithBlock:(void (^)(UIButton *button))block {
    [self addTappedOnceWithBlock:^(UIView *v) {
        block((UIButton *)v);
    }];
}

- (void)addTappedButtonOnceDelay:(float)time withBlock:(void (^)(UIButton *button))block {
    [self addTappedOnceDelay:time withBlock:^(UIView *v) {
        block((UIButton *)v);
    }];
}

@end
