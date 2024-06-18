//
//  CALayer+b.m
//  bench
//
//  Created by apple on 2023/11/22.
//

#import "CALayer+b.h"
#import "b.h"

@implementation CALayer (b)

- (void)b_addBlackOpageRight {
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    layer.colors = @[(id)UIColor.blackColor.CGColor, (id)UIColor.clearColor.CGColor];
    layer.locations = @[@(0),@(1)];
    layer.startPoint = CGPointMake(1, 0.5);
    layer.endPoint = CGPointMake(0, 0.5);
    [self addSublayer:layer];
}

- (void)b_addBlackOpageTop {
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-RH(10));
    layer.colors = @[(id)UIColor.blackColor.CGColor, (id)UIColor.clearColor.CGColor];
    layer.locations = @[@(0),@(1)];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    [self addSublayer:layer];
}

- (void)b_addBlackOpageBottom {
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-RH(10));
    layer.colors = @[(id)UIColor.blackColor.CGColor, (id)UIColor.clearColor.CGColor];
    layer.locations = @[@(0),@(1)];
    layer.startPoint = CGPointMake(0.5, 1);
    layer.endPoint = CGPointMake(0.5, 0);
    [self addSublayer:layer];
}

- (void)b_addBenchShadow {
    self.cornerRadius = RH(10);
    self.shadowColor = UIColor.grayColor.CGColor;
    self.shadowOpacity = 0.6;
    self.shadowOffset = CGSizeMake(-RH(5), RH(6));
    self.shadowRadius = RH(6);
}

- (void)b_addBenchShadowRightBottom {
    self.cornerRadius = RH(10);
    self.shadowColor = UIColor.grayColor.CGColor;
    self.shadowOpacity = 0.6;
    self.shadowOffset = CGSizeMake(RH(3), RH(6));
    self.shadowRadius = RH(6);
}

- (void)b_addBenchShadowDeep {
    self.cornerRadius = RH(10);
    self.shadowColor = UIColor.blackColor.CGColor;
    self.shadowOpacity = 0.6;
    self.shadowOffset = CGSizeMake(-RH(5), RH(8));
    self.shadowRadius = RH(8);
}

- (void)b_addBenchShadowWhite {
    self.cornerRadius = RH(10);
    self.shadowColor = UIColor.whiteColor.CGColor;
    self.shadowOpacity = 0.8;
    self.shadowOffset = CGSizeMake(RH(0), RH(0));
    self.shadowRadius = RH(8);
}

- (void)b_addBenchShadowTopRight {
    self.cornerRadius = RH(10);
    self.shadowColor = UIColor.whiteColor.CGColor;
    self.shadowOpacity = 0.6;
    self.shadowOffset = CGSizeMake(RH(5), -RH(6));
}

- (void)b_addBenchShadowGameYellow {
//    self.cornerRadius = RH(10);
//    self.shadowColor = UIColor.b_lightYellow.CGColor;
//    self.shadowOpacity = 1;
//    self.shadowOffset = CGSizeMake(RH(0), RH(0));
//    self.shadowRadius = RH(10);
    [self b_addBenchShadow:UIColor.b_lightYellow];
}

- (void)b_addBenchShadow:(UIColor *)color {
//    self.cornerRadius = RH(10);
    self.shadowColor = color.CGColor;
    self.shadowOpacity = 1;
    self.shadowOffset = CGSizeMake(RH(0), RH(0));
    self.shadowRadius = RH(10);
}

- (void)b_removeBenchShadow {
    self.shadowOpacity = 0;
    self.shadowRadius = 0;
}

@end
