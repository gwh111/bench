//
//  AnimationPlay.h
//  NewWord
//
//  Created by gwh on 2018/3/12.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bAnimationPlay : NSObject

+ (void)playAtView:(UIView *)view aniPath:(NSString *)path fromIndex:(int)index frame:(CGRect)frame reverse:(int)reverse;
+ (void)playAtView:(UIView *)view aniPath:(NSString *)path fromIndex:(int)index alpha:(float)alpha reverse:(int)reverse;
+ (void)playAtView2:(UIView *)view aniPath:(NSString *)path fromIndex:(int)index alpha:(float)alpha reverse:(int)reverse;

@end
