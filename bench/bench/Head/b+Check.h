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

+ (BOOL)isSafe;
+ (void)setIsSafeReviewVersion:(NSString *)reviewVersion inReview:(BOOL)inReview;

+ (BOOL)isProxyStatus;
+ (BOOL)isJailBreak;
+ (BOOL)isChinese;
+ (BOOL)isSimplifiedChinese;

+ (int)randValue:(int)value;
+ (BOOL)isRand100LessThan:(int)value;

+ (NSString *)version;
+ (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2;
+ (NSString *)randomString:(NSInteger)number;

+ (NSString *)containForbiddenWords:(NSString *)text;
+ (BOOL)containForbiddenWordsCheck:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
