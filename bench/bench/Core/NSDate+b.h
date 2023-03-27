//
//  NSDate+b.h
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (b)

@property(nonatomic, assign, readonly) NSInteger b_second;
@property(nonatomic, assign, readonly) NSInteger b_minute;
@property(nonatomic, assign, readonly) NSInteger b_hour;
@property(nonatomic, assign, readonly) NSInteger b_day;
@property(nonatomic, assign, readonly) NSInteger b_month;
@property(nonatomic, assign, readonly) NSInteger b_year;

// 根据日期获得星期几
- (NSString *)b_weekday;

- (NSString *)b_convertToString;

- (NSString *)b_convertToStringWithformatter:(NSString *)formatterStr;

+ (NSDate *)b_localDate;

@end

NS_ASSUME_NONNULL_END
