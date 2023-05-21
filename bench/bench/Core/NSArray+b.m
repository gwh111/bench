//
//  NSArray+b.m
//  bench
//
//  Created by gwh on 2023/5/3.
//

#import "NSArray+b.h"

@implementation NSArray (b)

- (NSString *)descriptionWithLocale:(id)locale
{
    // 遍历数组中的全部内容，将内容拼接成一个新的字符串返回
    NSMutableString *strM = [NSMutableString string];
 
    [strM appendString:@"(\n"];
 
    // 遍历数组,self就是当前的数组
    for (id obj in self) {
        // 在拼接字符串时。会调用obj的description方法
        [strM appendFormat:@"\t%@,\n", obj];
    }
 
    [strM appendString:@")"];
 
    return strM;
}
 
- (NSArray *)sortedLocal{
    NSArray* sortedArray = [self sortedArrayUsingComparator:^(id a, id b)
                            {
                                NSString* s1 = (NSString*)a;
                                NSString* s2 = (NSString*)b;
                                return [s1 localizedCompare: s2];
 
                            }];
    return sortedArray;
}
 

@end
