//
//  CALayer+b.h
//  bench
//
//  Created by apple on 2023/11/22.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (b)

- (void)b_addBenchShadow;
- (void)b_addBenchShadowRightBottom;
- (void)b_addBenchShadowDeep;
- (void)b_addBenchShadowWhite;
- (void)b_addBenchShadowTopRight;

@end

NS_ASSUME_NONNULL_END
