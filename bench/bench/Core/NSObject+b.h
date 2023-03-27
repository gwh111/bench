//
//  NSObject+b.h
//  bench
//
//  Created by gwh on 2022/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (b)

- (id)b_copy;
- (id)b_setClassKVDic:(NSDictionary *)dic;
- (NSDictionary *)b_getClassKVDic;
- (NSDictionary *)b_getClassKVDicWithout_;
- (NSArray *)b_getClassNameList;
- (NSArray *)b_getClassNameListWithout_;
- (NSArray *)b_getClassTypeList;

@end

NS_ASSUME_NONNULL_END
