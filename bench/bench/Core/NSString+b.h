//
//  NSString+b.h
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (b)

+ (void)setKeychainKey:(NSString *)key value:(NSString *)value;
+ (NSString *)getKeychainKey:(NSString *)key;

+ (void)setKeychainObjectId:(NSString *)str;
+ (NSString *)getKeychainObjectId;

- (NSDate *)b_convertToDate;
- (BOOL)containEmoji;

@end

NS_ASSUME_NONNULL_END
