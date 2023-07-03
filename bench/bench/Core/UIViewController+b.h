//
//  UIViewController+b.h
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (b)

@property (nonatomic, retain) UIScrollView *displayView;

- (void)setupRootWindow:(UIWindow *)window andRootViewController:(UIViewController *)vc;

- (void)pushViewController:(id)vc animated:(BOOL)animated;
- (void)pushViewController:(id)vc;
- (void)popViewController;

- (void)presentViewController:(id)vc;
- (void)dismissViewController;

- (void)adjustDisplayView:(UIScrollView *)displayView;
- (void)adjustDisplayView;

@end

NS_ASSUME_NONNULL_END
