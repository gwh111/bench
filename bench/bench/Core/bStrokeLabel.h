//
//  CC_StrokeLabel.h
//  JHStories
//
//  Created by gwh on 2020/5/4.
//  Copyright © 2020 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bStrokeLabel : UILabel

@property (strong,nonatomic) UIColor *strokeColor;
@property (assign,nonatomic) CGFloat strokeWidth;

+ (bStrokeLabel *)label;
+ (bStrokeLabel *)label2;
+ (bStrokeLabel *)label_white_black;

- (void)drawTextInRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
