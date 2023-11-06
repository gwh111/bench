//
//  UIColor+b.m
//  bench
//
//  Created by gwh on 2022/2/9.
//

#import "UIColor+b.h"

@implementation UIColor (b)

+ (UIColor *)b_lightYellow {
    return [UIColor colorWithRed:255/255.0f green:251/255.0f blue:152/255.0f alpha:1];
}

+ (UIColor *)b_lightRed {
    return [UIColor colorWithRed:247/255.0f green:126/255.0f blue:129/255.0f alpha:1];
}

+ (UIColor *)b_darkRed {
    return [UIColor colorWithRed:60/255.0f green:24/255.0f blue:21/255.0f alpha:1];
}

+ (UIColor *)b_darkRed2 {
    return [UIColor colorWithRed:175/255.0f green:50/255.0f blue:50/255.0f alpha:1];
}

+ (UIColor *)b_lightBlue {
    return [UIColor colorWithRed:62/255.0f green:188/255.0f blue:202/255.0f alpha:1];
}

+ (UIColor *)b_iceBlue {
    return [UIColor colorWithRed:194/255.0f green:246/255.0f blue:231/255.0f alpha:1];
}

+ (UIColor *)b_lightGreen {
    return [UIColor colorWithRed:107/255.0f green:221/255.0f blue:123/255.0f alpha:1];
}

+ (UIColor *)b_darkGreen {
    return [UIColor colorWithRed:24/255.0f green:100/255.0f blue:80/255.0f alpha:1];
}

+ (UIColor *)b_lightPurple {
    return [UIColor colorWithRed:177/255.0f green:100/255.0f blue:227/255.0f alpha:1];
}

+ (UIColor *)b_lightPink {
    return [UIColor colorWithRed:228/255.0f green:154/255.0f blue:188/255.0f alpha:1];
}

+ (UIColor *)b_close {
    return [UIColor colorWithRed:253/255.0f green:71/255.0f blue:84/255.0f alpha:1];
}

+ (UIColor *)b_minimize {
    return [UIColor colorWithRed:253/255.0f green:178/255.0f blue:67/255.0f alpha:1];
}

+ (UIColor *)b_maximize {
    return [UIColor colorWithRed:41/255.0f green:198/255.0f blue:71/255.0f alpha:1];
}

+ (UIColor *)b_tinyLightGrayColor {
    return RGB(242, 242, 242);
}

+ (UIColor *)b_hex:(NSString *)hex alpha:(float)alpha {
    hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hex = [hex stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hex substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hex substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hex substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)b_rgb:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

@end
