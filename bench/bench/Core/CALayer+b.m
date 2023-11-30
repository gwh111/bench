//
//  CALayer+b.m
//  bench
//
//  Created by apple on 2023/11/22.
//

#import "CALayer+b.h"
#import "b.h"

@implementation CALayer (b)

- (void)b_addBenchShadow {
    self.cornerRadius = RH(10);
    self.shadowColor = UIColor.grayColor.CGColor;
    self.shadowOpacity = 0.6;
    self.shadowOffset = CGSizeMake(-RH(5), RH(6));
    self.shadowRadius = RH(6);
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

@end
