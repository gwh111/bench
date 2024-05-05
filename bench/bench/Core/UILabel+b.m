//
//  UILabel+b.m
//  bench
//
//  Created by gwh on 2022/1/8.
//

#import "UILabel+b.h"

@implementation UILabel (b)

+ (UILabel *)b_UILabel {
    UILabel *ui = UILabel.new;
    ui.font = RF(16);
    return ui;
}

+ (UILabel *)b_infoUILabel {
    UILabel *ui = UILabel.new;
    ui.size = CGSizeMake(WIDTH()-RH(20), RH(35));
    ui.left = RH(10);
    ui.font = RF(14);
    ui.numberOfLines = 0;
    ui.textColor = UIColor.blackColor;
    return ui;
}

+ (UILabel *)b_blackTextUILabel {
    UILabel *ui = UILabel.new;
    ui.size = CGSizeMake(WIDTH()-RH(20), RH(35));
    ui.left = RH(10);
    ui.font = RF(14);
    ui.numberOfLines = 0;
    ui.textColor = UIColor.blackColor;
    return ui;
}

+ (UILabel *)b_whiteTextUILabel {
    UILabel *ui = UILabel.new;
    ui.size = CGSizeMake(WIDTH()-RH(20), RH(35));
    ui.left = RH(10);
    ui.font = RF(14);
    ui.numberOfLines = 0;
    ui.textColor = UIColor.whiteColor;
    return ui;
}

+ (UILabel *)b_roundUILabel {
    UILabel *label = UILabel.b_UILabel;
    label.size = CGSizeMake(RH(40), RH(40));
    label.layer.cornerRadius = RH(20);
    label.layer.masksToBounds = YES;
    label.font = RF(16);
    label.backgroundColor = RGBA(0, 0, 0, 0.5);
    label.textColor = UIColor.whiteColor;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
