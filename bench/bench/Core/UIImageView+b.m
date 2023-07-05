//
//  UIImageView+b.m
//  bench
//
//  Created by apple on 2023/7/5.
//

#import "UIImageView+b.h"

@implementation UIImageView (b)

- (void)setImage:(UIImage *)image withRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rect);
    UIImage *image1 = [UIImage imageWithCGImage:imageRef];
    [self setImage:image1];
}

@end
