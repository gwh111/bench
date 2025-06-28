//
//  bSort.m
//  bench
//
//  Created by gwh on 2022/8/30.
//

#import "bSort.h"

@implementation bSort

static bSort *userManager = nil;
static dispatch_once_t onceToken;

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[bSort alloc]init];
    });
    return userManager;
}

//private
- (NSString *)getDepthStr:(id)value depthArr:(NSArray *)depthArr index:(int)index {
    if (index >= depthArr.count) {
        return value;
    }
    NSString *key = depthArr[index];
    if (value[key] == nil) {
        NSLog(@"%@ %@ is empty",value[@"name"],key);
    }
    value = value[key];
    index++;
    return [self getDepthStr:value depthArr:depthArr index:index];
}

- (NSMutableArray *)sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr {
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
    NSMutableArray *englishMutArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < sortMutArr.count; i++) {
        NSMutableString *ms;
        if (depthArr.count == 0) {
            ms = [[NSMutableString alloc]initWithString:sortMutArr[i]];
        } else {
            ms = [[NSMutableString alloc]initWithString:[self getDepthStr:sortMutArr[i] depthArr:depthArr index:0]];
        }
        CFStringTransform((CFMutableStringRef)ms, NULL, kCFStringTransformToLatin, NO);
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics, NO))
        {
            NSString *bigStr = [ms uppercaseString];
            [englishMutArr addObject:bigStr];
            [mutDic setObject:sortMutArr[i] forKey:bigStr];
        }
    }
    NSArray *resultkArrSort = [englishMutArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *newArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < resultkArrSort.count; i++) {
        [newArr addObject:mutDic[resultkArrSort[i]]];
    }
    return newArr;
}


- (NSMutableArray *)sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc{
    if (desc) {
        //降序
        for (int i = 0; i < mutArr.count; i++) {
            for (int j = 0; j < mutArr.count - 1 - i; j++) {
                if (key) {
                    if ([mutArr[j][key] intValue] < [mutArr[j + 1][key] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }else{
                    if ([mutArr[j] intValue] < [mutArr[j + 1] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
    } else {
        //升序
        for (int i = 0; i < mutArr.count; i++) {
            for (int j = 0; j < mutArr.count - 1 - i;j++) {
                if (key) {
                    if ([mutArr[j+1][key]intValue] < [mutArr[j][key] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }else{
                    if ([mutArr[j+1]intValue] < [mutArr[j] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
    }
    
    return mutArr;
}

@end
