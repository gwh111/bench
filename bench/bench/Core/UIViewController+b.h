//
//  UIViewController+b.h
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 NSString *const kCATransitionCube = @"cube";
 NSString *const kCATransitionSuckEffect = @"suckEffect";
 NSString *const kCATransitionOglFlip = @"oglFlip";
 NSString *const kCATransitionRippleEffect = @"rippleEffect";
 NSString *const kCATransitionPageCurl = @"pageCurl";
 NSString *const kCATransitionPageUnCurl = @"pageUnCurl";
 NSString *const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
 NSString *const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";
 */

typedef enum : NSUInteger {
    BenchVCAnimationCube,
    BenchVCAnimationFade,
    BenchVCAnimationSuckEffect,
    BenchVCAnimationRippleEffect,
} BenchVCAnimation;

@interface UIViewController (b)

@property (nonatomic, retain) UIScrollView *displayView;

- (void)setupRootWindow:(UIWindow *)window andRootViewController:(UIViewController *)vc;

- (void)pushViewController:(id)vc animated:(BOOL)animated;
- (void)pushViewController:(id)vc;
- (void)popViewController;
- (void)popViewControllerAnimated:(BOOL)animated;

- (void)pushViewController:(id)vc animation:(BenchVCAnimation)ani;
- (void)popViewControllerWithAnimation:(BenchVCAnimation)ani;

- (void)presentViewController:(id)vc;
- (void)dismissViewController;

- (void)presentViewController:(id)vc animation:(BenchVCAnimation)ani;
- (void)dismissViewControllerWithAnimation:(BenchVCAnimation)ani;

- (void)adjustDisplayView:(UIScrollView *)displayView;
- (void)adjustDisplayView;

@end

NS_ASSUME_NONNULL_END
