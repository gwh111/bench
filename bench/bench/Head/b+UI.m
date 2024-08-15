//
//  b+UI.m
//  bench
//
//  Created by gwh on 2023/6/24.
//

#import "b+UI.h"
#import "b+Sandbox.h"

@implementation b (UI)

+ (UIImage *)getAppPaperImage {
    NSString *name = @"appPaper";
    NSString *path = [NSString stringWithFormat:@"%@/%@",b.sandboxDocumentPath,name];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

+ (void)setAppPaperImage:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    NSString *name = @"appPaper";
    NSString *path = [NSString stringWithFormat:@"%@/%@",b.sandboxDocumentPath,name];
    [data writeToFile:path atomically:YES];
}

/// 旋转屏幕
/// - Parameters:
///   - interfaceOrientation: 目标屏幕方向
///   - viewController: 所在的视图控制器
///   - errorHandler: 错误回调
+ (void)rotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation viewController:(UIViewController *)viewController errorHandler:(void (^)(NSError *))errorHandler {
#if __IPHONE_16_0 //兼容 Xcode13
    if (@available(iOS 16.0, *)) {
        UIWindowScene *windowScene = viewController.view.window.windowScene;
        if (!windowScene) {
            return;
        }
        [viewController setNeedsUpdateOfSupportedInterfaceOrientations];
        UIWindowSceneGeometryPreferencesIOS *geometryPreferences = [[UIWindowSceneGeometryPreferencesIOS alloc] init];
        switch (interfaceOrientation) {
            case UIInterfaceOrientationPortrait:
                geometryPreferences.interfaceOrientations = UIInterfaceOrientationMaskPortrait;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                geometryPreferences.interfaceOrientations = UIInterfaceOrientationMaskPortraitUpsideDown;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                geometryPreferences.interfaceOrientations = UIInterfaceOrientationMaskLandscapeLeft;
                break;
            case UIInterfaceOrientationLandscapeRight:
                geometryPreferences.interfaceOrientations = UIInterfaceOrientationMaskLandscapeRight;
                break;
            default:
                break;
        }
        [windowScene requestGeometryUpdateWithPreferences:geometryPreferences errorHandler:^(NSError * _Nonnull error) {
            //业务代码
            NSLog(@"menglc errorHandler error %@", error);
            if (errorHandler) {
                errorHandler(error);
            }
        }];
        return;
    }
#endif
    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;//横屏UIInterfaceOrientationPortrait
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
// 原文链接：https://blog.csdn.net/mlcldh/article/details/127320581

@end
