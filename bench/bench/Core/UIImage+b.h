//
//  UIImage+b.h
//  bench
//
//  Created by apple on 2023/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (b)

//+ (UIImage *)getImage:(UIImage *)image withRect:(CGRect)rect;

+ (UIImage *)b_image:(UIImage *)image withRect:(CGRect)rect;
+ (UIImage *)b_imageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
