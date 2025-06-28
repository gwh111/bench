//
//  NSAttributedString+b.m
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import "NSAttributedString+b.h"
#import "b.h"

@implementation NSAttributedString (b)

@end

@implementation NSMutableAttributedString (b)

- (void)b_appendAttStr:(NSString *)appendStr color:(UIColor *)color {
    [self b_appendAttStr:appendStr color:color font:nil];
}
// paragraphStyle
- (void)b_appendAttStr:(NSString *)appendStr color:(UIColor *)color font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    if (!appendStr || appendStr.length == 0) {
        return;
    }
    NSMutableAttributedString *appendAttStr = [[NSMutableAttributedString alloc]initWithString:appendStr];
    [appendAttStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,appendAttStr.length)];
    if (font) {
        [appendAttStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,appendAttStr.length)];
    }
    NSMutableParagraphStyle *style = NSMutableParagraphStyle.new;
    style.lineSpacing = lineSpacing;
    [appendAttStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,appendAttStr.length)];
    NSAttributedString *att = [[NSAttributedString alloc]initWithAttributedString:appendAttStr];
    [self appendAttributedString:att];
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

- (void)b_getReplaceAttText:(NSString *)replaceStr toAtt:(NSMutableAttributedString *)toAtt {
    NSString *copyStr = self.string;
//    NSMutableAttributedString *copyAtt = [[NSMutableAttributedString alloc]initWithAttributedString:self];
    NSString *replace = @"";
    for (int i = 0; i < toAtt.string.length; i++) {
        replace = [replace stringByAppendingString:@"a"];
    }
    while ([copyStr rangeOfString:replaceStr].location != NSNotFound) {
        NSRange range = [copyStr rangeOfString:replaceStr];
        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:replace];
        [self replaceCharactersInRange:range withAttributedString:toAtt];
    }
//    return copyAtt;
}

@end
