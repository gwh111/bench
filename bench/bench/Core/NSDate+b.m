//
//  NSDate+b.m
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import "NSDate+b.h"

@implementation NSDate (b)

- (NSCalendarUnit)b_dateComponents {
    return NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekOfYear|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal;
}

- (NSInteger)b_second {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self b_dateComponents] fromDate:self];
    return components.second;
}

- (NSInteger)b_minute {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self b_dateComponents] fromDate:self];
    return components.minute;
}

- (NSInteger)b_hour {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self b_dateComponents] fromDate:self];
    return components.hour;
}

- (NSInteger)b_day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self b_dateComponents] fromDate:self];
    return components.day;
}

- (NSInteger)b_month {
    NSDateComponents * components = [[NSCalendar currentCalendar] components:[self b_dateComponents] fromDate:self];
    return components.month;
}

- (NSInteger)b_year {
    NSDateComponents * components = [[NSCalendar currentCalendar] components:[self b_dateComponents] fromDate:self];
    return components.year;
}

- (NSString *)b_weekday {
    NSArray *weeks = @[[NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:self];
    return [weeks objectAtIndex:components.weekday];
}

- (NSString *)b_convertToStringWithformatter:(NSString *)formatterStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (formatterStr) {
        [dateFormatter setDateFormat:formatterStr];
    }else{
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    NSString *currentDateString = [dateFormatter stringFromDate:self];
    if (!currentDateString) {
        [dateFormatter setDateFormat:@"e, dd MM yyyy HH:mm:ss z"];
        currentDateString = [dateFormatter stringFromDate:self];
    }
    return currentDateString;
}

- (NSString *)b_convertToStringOpt {
    NSString *text;
    NSDate *now = NSDate.b_localDate;
    if (now.b_year == self.b_year) {
        if (now.b_month == self.b_month) {
            if (now.b_day == self.b_day) {
                text = [NSString stringWithFormat:@"今天 %ld:%ld", self.b_hour, (long)self.b_minute];
            } else {
                text = [NSString stringWithFormat:@"%ld天前 %ld:%ld", now.b_day-self.b_day, self.b_hour, (long)self.b_minute];
            }
        } else {
            text = [NSString stringWithFormat:@"%ld.%ld", self.b_month, (long)self.b_day];
        }
    } else {
        text = [NSString stringWithFormat:@"%ld %ld.%ld", self.b_year, self.b_month, (long)self.b_day];
    }
    return text;
}

- (NSString *)b_convertToString {
    return [self b_convertToStringWithformatter:nil];
}

+ (NSDate *)b_localDate {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    return localDate;
}

@end
