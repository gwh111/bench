//
//  NSAttributedString+b.h
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (b)

@end

@interface NSMutableAttributedString (b)

- (void)b_appendAttStr:(NSString *)appendStr color:(UIColor *)color;

- (void)b_appendAttStr:(NSString *)appendStr color:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
