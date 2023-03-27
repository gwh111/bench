//
//  UIColor+b.h
//  bench
//
//  Created by gwh on 2022/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define HEXA(COLOR,A) [UIColor b_hex:COLOR alpha:a]
#define HEX(COLOR) HEXA(COLOR,1.0)
#define RGBA(r,g,b,a) [UIColor b_rgb:r green:g blue:b alpha:a]
#define RGB(r,g,b) [UIColor b_rgb:r green:g blue:b alpha:1]

@interface UIColor (b)

+ (UIColor *)b_hex:(NSString *)hex alpha:(float)alpha;
+ (UIColor *)b_rgb:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;
+ (UIColor *)b_tinyLightGrayColor;

+ (UIColor *)b_lightYellow;
+ (UIColor *)b_lightRed;
+ (UIColor *)b_darkRed;
+ (UIColor *)b_darkRed2;

+ (UIColor *)b_lightBlue;
+ (UIColor *)b_iceBlue;
+ (UIColor *)b_lightGreen;
+ (UIColor *)b_darkGreen;
+ (UIColor *)b_lightPurple;
+ (UIColor *)b_lightPink;

@end

NS_ASSUME_NONNULL_END
