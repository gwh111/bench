//
//  UIViewController+b.m
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import "UIViewController+b.h"
#import "b.h"
#import "bUI.h"

@implementation UIViewController (b)

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
