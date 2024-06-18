//
//  UIImage+b.m
//  bench
//
//  Created by apple on 2023/7/5.
//

#import "UIImage+b.h"

@implementation UIImage (b)

+ (UIImage *)getImage:(UIImage *)image withRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rect);
    UIImage *image1 = [UIImage imageWithCGImage:imageRef];
    return image1;
}

@end
