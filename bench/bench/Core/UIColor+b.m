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

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    if (stringToConvert.length == 0) {
        return [UIColor blackColor];
    }
    if ([stringToConvert hasPrefix:@"#"]) {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    if ([stringToConvert containsString:@"0x"]) {
        stringToConvert = [stringToConvert stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    }
    
    if ([stringToConvert containsString:@"0X"]) {
        stringToConvert = [stringToConvert stringByReplacingOccurrencesOfString:@"0X" withString:@""];
    }
    
    if (stringToConvert.length==3) {
        stringToConvert = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                           [stringToConvert characterAtIndex:0],
                           [stringToConvert characterAtIndex:0],
                           [stringToConvert characterAtIndex:1],
                           [stringToConvert characterAtIndex:1],
                           [stringToConvert characterAtIndex:2],
                           [stringToConvert characterAtIndex:2]];
    }
    if (stringToConvert.length==4) {
        stringToConvert = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c",
                           [stringToConvert characterAtIndex:0],
                           [stringToConvert characterAtIndex:0],
                           [stringToConvert characterAtIndex:1],
                           [stringToConvert characterAtIndex:1],
                           [stringToConvert characterAtIndex:2],
                           [stringToConvert characterAtIndex:2],
                           [stringToConvert characterAtIndex:3],
                           [stringToConvert characterAtIndex:3]];
    }
    
    
//    NSLog(@"stringToConvert %@",stringToConvert);
    if (stringToConvert.length==8) {
        NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
        
        unsigned hexNum;
        
        if(![scanner scanHexInt:&hexNum]) {
            return nil;
        }
        
        return [UIColor colorWithRGBAlphaHex:hexNum];
        
    }else if (stringToConvert.length==6) {
        NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
        
        unsigned hexNum;
        
        if(![scanner scanHexInt:&hexNum]) {
            return nil;
        }
        
        return [UIColor colorWithRGBHex:hexNum];
    }else{
        return nil;
    }
}

+ (UIColor *)colorWithRGBAlphaHex:(UInt32)hex {
//    NSLog(@"%X",hex);
    
    int r = (hex >> 24) & 0xFF;
    int g = (hex >> 16) & 0xFF;
    int b = (hex>> 8) & 0xFF;
    int alpha = hex & 0xFF;
    return [UIColor colorWithRed:r /255.0f
                         green:g /255.0f
                          blue:b /255.0f
                           alpha:alpha/255.0f];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
//    NSLog(@"%X",hex);
    
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r /255.0f
                         green:g /255.0f
                          blue:b /255.0f
                         alpha:1.0f];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex withAlpha:(CGFloat)alpha{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r /255.0f
                           green:g /255.0f
                            blue:b /255.0f
                           alpha:alpha];
}

- (NSString *)hexadecimalFromUIColor {
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB)
    {
        NSLog(@"非RGB：");
        if ([self isEqual:[UIColor clearColor]]) {
            return @"#000000FF";
        }
        else if ([self isEqual:[UIColor whiteColor]]){
            return @"#FFFFFF";
        }else{
            return @"000000";
        }
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    if (CGColorGetNumberOfComponents(self.CGColor) < 4)
    {
        NSLog(@"CGColorGetNumberOfComponents < 4");
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        CGFloat r = components[0];//红色
        CGFloat g = components[1];//绿色
        CGFloat b = components[2];//蓝色
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
        
    }
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    if (a==1) {
        return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255)] ;
    }
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255),
            lroundf(a * 255)];
}

@end
