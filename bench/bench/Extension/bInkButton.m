//
//  bInkButton.m
//  bench
//
//  Created by gwh on 2025/6/27.
//

#import "bInkButton.h"
#import "bench.h"

@implementation bInkButton

+ (UIButton *)create {
    bInkButton *pk = bInkButton.new;
    pk.size = CGSizeMake(RH(60), RH(35));
    pk.layer.cornerRadius = RH(5);
    pk.titleLabel.font = RF(16);
    pk.b_normalColor = UIColor.whiteColor;
    UIImage *image = [UIImage b_imageNamed:@"inkbtn"];
    [pk setBackgroundImage:image forState:UIControlStateNormal];
    pk.clipsToBounds = YES;
    pk.layer.borderColor = UIColor.whiteColor.CGColor;
    pk.layer.borderWidth = 1;
    [pk setup];
    return pk;
}

- (void)setup {
    
}

@end
