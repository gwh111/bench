//
//  b+Check.h
//  bench
//
//  Created by gwh on 2023/2/28.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (Check)

+ (BOOL)isDebug;

+ (int)compareV1:(NSString *)v1 cutV2:(NSString *)v2;

+ (BOOL)isSafe;
+ (void)setIsSafeTime:(NSString *)time;
+ (BOOL)isDateBefore:(NSString *)dataStr;

+ (void)setIsSafeReviewVersion:(NSString *)reviewVersion inReview:(BOOL)inReview;

+ (BOOL)isPad;
+ (BOOL)isProxyStatus;
+ (BOOL)isJailBreak;
+ (BOOL)isChinese;
+ (BOOL)isSimplifiedChinese;
+ (NSString *)currentLanguage;

+ (int)randValue:(int)value;
+ (BOOL)isRand100LessThan:(int)value;

+ (NSString *)version;
+ (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2;
+ (NSString *)randomString:(NSInteger)number;

+ (NSString *)containForbiddenWords:(NSString *)text;
+ (BOOL)containForbiddenWordsCheck:(NSString *)text;

+ (void)printFontNames;

@end

NS_ASSUME_NONNULL_END
