//
//  bSort.h
//  bench
//
//  Created by gwh on 2022/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bSort : NSObject


+ (instancetype)shared;

// 中文的排序
// 排序一层中文 如 sortMutArr=@[@"张三",@"李四"]; depthArr=nil;
// 排序嵌套字典的数组 如 sortMutArr=@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}]; depthArr=@[@"name"];
- (NSMutableArray *)sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(nullable NSArray *)depthArr;

// 冒泡排序
// desc=1 降序
// key=nil 直接对mutArr取值排序
- (NSMutableArray *)sortMutArr:(NSMutableArray *)mutArr byKey:(nullable NSString *)key desc:(int)desc;

@end

NS_ASSUME_NONNULL_END
