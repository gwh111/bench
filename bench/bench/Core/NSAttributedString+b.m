//
//  NSAttributedString+b.m
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import "NSAttributedString+b.h"

@implementation NSAttributedString (b)

@end

@implementation NSMutableAttributedString (b)

- (void)b_appendAttStr:(NSString *)appendStr color:(UIColor *)color {
    [self b_appendAttStr:appendStr color:color font:nil];
}

- (void)b_appendAttStr:(NSString *)appendStr color:(UIColor *)color font:(UIFont *)font {
    if (!appendStr || appendStr.length == 0) {
        return;
    }
    NSMutableAttributedString *appendAttStr = [[NSMutableAttributedString alloc]initWithString:appendStr];
    [appendAttStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,appendAttStr.length)];
    if (font) {
        [appendAttStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,appendAttStr.length)];
    }
    NSAttributedString *att = [[NSAttributedString alloc]initWithAttributedString:appendAttStr];
    [self appendAttributedString:att];
}

@end
