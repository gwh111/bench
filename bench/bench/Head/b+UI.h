//
//  b+UI.h
//  bench
//
//  Created by gwh on 2023/6/24.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (UI)

+ (UIImage *)getAppPaperImage;
+ (void)setAppPaperImage:(UIImage *)image;
+ (void)rotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation viewController:(UIViewController *)viewController errorHandler:(void (^)(NSError *))errorHandler;

@end

NS_ASSUME_NONNULL_END
