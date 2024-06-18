//
//  CALayer+b.h
//  bench
//
//  Created by apple on 2023/11/22.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (b)

- (void)b_addBlackOpageRight;
- (void)b_addBlackOpageTop;
- (void)b_addBlackOpageBottom;
- (void)b_addBenchShadow;
- (void)b_addBenchShadowRightBottom;
- (void)b_addBenchShadowDeep;
- (void)b_addBenchShadowWhite;
- (void)b_addBenchShadowTopRight;

- (void)b_addBenchShadowGameYellow;
- (void)b_addBenchShadow:(UIColor *)color;
- (void)b_removeBenchShadow;

@end

NS_ASSUME_NONNULL_END
