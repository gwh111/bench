//
//  AppMD5Object.h
//  AppleToolProj
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bMD5 : NSObject

/** 字符串转为md5*/
+ (NSString *)signString:(NSString *)origString;

@end
