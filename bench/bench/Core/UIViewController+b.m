//
//  UIViewController+b.m
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import "UIViewController+b.h"
#import "b.h"
#import "bUI.h"
#import <objc/runtime.h>

@implementation UIViewController (b)

// MARK: - Associated -
- (UIScrollView *)displayView {
    UIScrollView *displayView = objc_getAssociatedObject(self, @selector(displayView));
    if (displayView.height <= 0) {
        [self setupDisplayView];
        displayView = objc_getAssociatedObject(self, @selector(displayView));
    }
    return displayView;
}

- (void)setDisplayView:(UIScrollView *)displayView {
    objc_setAssociatedObject(self, @selector(displayView), displayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setupDisplayView {
    UIScrollView *displayView = UIScrollView.new;
    displayView.size = CGSizeMake(WIDTH(), b.ui.safeHeight);
    displayView.top = b.ui.safeTop;
    displayView.left = b.ui.safeLeft;
    [self.view addSubview:displayView];
    self.displayView = displayView;
}

- (void)adjustDisplayView:(UIScrollView *)displayView {
    NSArray *subs = displayView.subviews;
    float maxh = displayView.height;
    float maxw = displayView.width;
    for (int i = 0; i < subs.count; i++) {
        UIView *view = subs[i];
        if (view.bottom > maxh) {
            maxh = view.bottom;
        }
        if (view.right > maxw) {
            maxw = view.right;
        }
    }
    if (maxh > displayView.height) {
        displayView.contentSize = CGSizeMake(displayView.width, maxh);
    }
    if (maxw > displayView.width) {
        displayView.contentSize = CGSizeMake(maxw, maxh);
    }
}

- (void)adjustDisplayView {
    UIScrollView *displayView = self.displayView;
    NSArray *subs = displayView.subviews;
    float maxh = displayView.height;
    float maxw = displayView.width;
    for (int i = 0; i < subs.count; i++) {
        UIView *view = subs[i];
        if (view.bottom > maxh) {
            maxh = view.bottom;
        }
        if (view.right > maxw) {
            maxw = view.right;
        }
    }
    if (maxh > displayView.height) {
        displayView.contentSize = CGSizeMake(displayView.width, maxh);
    }
    if (maxw > displayView.width) {
        displayView.contentSize = CGSizeMake(maxw, displayView.height);
    }
}

- (void)setupRootWindow:(UIWindow *)window andRootViewController:(UIViewController *)vc {
    bUI.shared.navArray = NSMutableArray.new;
    [bUI.shared.navArray addObject:vc];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    navController.navigationBarHidden = YES;
    bUI.shared.navController = navController;
    window.rootViewController = navController;
}

- (BOOL)b_failedSetupRoot {
    if (!bUI.shared.navController) {
        benchLog(@"b_setupRootWindow uninit");
        return YES;
    }
    if (!bUI.shared.navArray) {
        benchLog(@"UINavArray = nil");
        bUI.shared.navArray = NSMutableArray.new;
        return YES;
    }
    if (bUI.shared.navArray.count <= 0) {
        benchLog(@"UINavArray.count = 0");
        return YES;
    }
    return NO;
}

- (void)pushViewController:(id)vc {
    if (self.b_failedSetupRoot) {
        return;
    }
    UINavigationController *navController = bUI.shared.navController;
    [navController pushViewController:vc animated:YES];
    [bUI.shared.navArray addObject:vc];
}

- (void)pushViewController:(id)vc animated:(BOOL)animated {
    if (self.b_failedSetupRoot) {
        return;
    }
    UINavigationController *navController = bUI.shared.navController;
    [navController pushViewController:vc animated:animated];
    [bUI.shared.navArray addObject:vc];
}

- (void)presentViewController:(id)vc {
    if (self.b_failedSetupRoot) {
        return;
    }
    UINavigationController *navController = bUI.shared.navController;
    [navController presentViewController:vc animated:YES completion:^{
        
        [bUI.shared.navArray addObject:vc];
    }];
}

- (void)dismissViewController {
    if (self.b_failedSetupRoot) {
        return;
    }
    UINavigationController *navController = bUI.shared.navController;
    [navController dismissViewControllerAnimated:YES completion:^{
        [bUI.shared.navArray removeLastObject];
    }];
}

- (void)popViewController {
    if (self.b_failedSetupRoot) {
        return;
    }
    NSMutableArray *navArray = bUI.shared.navArray;
    [navArray removeLastObject];
    UINavigationController *navController = bUI.shared.navController;
    [navController popViewControllerAnimated:YES];
}

@end
