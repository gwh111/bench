//
//  CC_StrokeLabel.m
//  JHStories
//
//  Created by gwh on 2020/5/4.
//  Copyright © 2020 gwh. All rights reserved.
//

#import "bStrokeLabel.h"
#import "b.h"

@implementation bStrokeLabel

+ (bStrokeLabel *)label {
    bStrokeLabel *label = [bStrokeLabel new];
    label.frame = CGRectMake(160, 70, 150, 100);
    label.text = @"Hello";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:50];
    //描边
    label.strokeColor = [UIColor orangeColor];
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 2;
    label.layer.shadowColor = [UIColor redColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

+ (bStrokeLabel *)label2 {
    bStrokeLabel *label = [bStrokeLabel new];
    label.frame = CGRectMake(160, 70, 150, 100);
    label.text = @"Hello";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor b_iceBlue];
    label.font = [UIFont systemFontOfSize:50];
    //描边
    label.strokeColor = [UIColor whiteColor];
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 2;
    label.layer.shadowColor = [UIColor blackColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

+ (bStrokeLabel *)label_black_white {
    bStrokeLabel *label = [bStrokeLabel new];
    label.frame = CGRectMake(0, 0, 150, 100);
    label.text = @"";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = RF(16);
    //描边
    label.strokeColor = [UIColor whiteColor];
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 2;
    label.layer.shadowColor = [UIColor whiteColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

+ (bStrokeLabel *)label_white_black {
    bStrokeLabel *label = [bStrokeLabel new];
    label.frame = CGRectMake(0, 0, 150, 100);
    label.text = @"";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = RF(16);
    //描边
    label.strokeColor = [UIColor blackColor];
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 2;
    label.layer.shadowColor = [UIColor blackColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

+ (bStrokeLabel *)label_red_black {
    bStrokeLabel *label = [bStrokeLabel new];
    label.frame = CGRectMake(160, 70, 150, 100);
    label.text = @"Hello";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor b_darkRed];
    label.font = RF(16);
    //描边
    label.strokeColor = [UIColor blackColor];
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 2;
    label.layer.shadowColor = [UIColor blackColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

+ (bStrokeLabel *)label_red_white {
    bStrokeLabel *label = [bStrokeLabel new];
    label.frame = CGRectMake(160, 70, 150, 100);
    label.text = @"Hello";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor b_darkRed2];
    label.font = RF(16);
    //描边
    label.strokeColor = [UIColor whiteColor];
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 1;
    label.layer.shadowColor = [UIColor whiteColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

+ (bStrokeLabel *)label_textColor:(UIColor *)textColor strokeColer:(UIColor *)strokeColer {
    bStrokeLabel *label = [bStrokeLabel new];
    label.frame = CGRectMake(0, 0, 150, 100);
    label.text = @"Hello";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = RF(16);
    //描边
    label.strokeColor = strokeColer;
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 2;
    label.layer.shadowColor = strokeColer.CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

- (void)drawTextInRect:(CGRect)rect {
    if (self.strokeWidth > 0) {
        CGSize shadowOffset = self.shadowOffset;
        UIColor *textColor = self.textColor;
    
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.strokeWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        //画外边
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = self.strokeColor;
        [super drawTextInRect:rect];
        //画内文字
        CGContextSetTextDrawingMode(c, kCGTextFill);
        self.textColor = textColor;
        self.shadowOffset = CGSizeMake(0, 0);
        [super drawTextInRect:rect];
        self.shadowOffset = shadowOffset;
    } else {
        [super drawTextInRect:rect];
    }
}

@end
