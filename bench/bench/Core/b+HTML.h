//
//  bHTML.h
//  bench
//
//  Created by gwh on 2022/12/1.
//

#import <Foundation/Foundation.h>
#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (HTML)

+ (void)html;

+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

+ (NSString *)html:(NSString *)html findLabelStart:(NSString *)start end:(NSString *)end except:(nullable NSArray *)excepts removeStartEnd:(BOOL)remove;
+ (NSString *)replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace;

@end

NS_ASSUME_NONNULL_END
