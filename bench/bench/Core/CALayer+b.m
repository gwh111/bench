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
    self.shadowRadius = RH(10);
    self.shadowOpacity = 0.8;
    self.shadowOffset = CGSizeMake(-5, 5);
}

@end
