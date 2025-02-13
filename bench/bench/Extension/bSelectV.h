//
//  SelectV.h
//  tower
//
//  Created by gwh on 2018/12/21.
//  Copyright © 2018 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bSelectV : UIView

@property(strong) void (^selectBlock)(NSUInteger select);
@property(nonatomic, assign) BOOL canCancel;

- (void)initUI;
- (void)playAsk:(NSString *)askStr selectArr:(NSArray *)selectArr block:(void (^)(NSUInteger select))block;

@end

NS_ASSUME_NONNULL_END
