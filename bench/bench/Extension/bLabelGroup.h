//
//  CC_AutoLabelGroup.h
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CC_View.h"
//#import "CC_Label.h"
//#import "CC_Button.h"
//#import "UIView+CCUI.h"
#import "bench.h"

@class bLabelGroup;

@protocol bLabelGroupDelegate <NSObject>

- (void)labelGroup:(bLabelGroup *)group initWithButton:(UIButton *)button;
- (void)labelGroup:(bLabelGroup *)group button:(UIButton *)button tappedAtIndex:(NSUInteger)index;
- (void)labelGroupInitFinish:(bLabelGroup *)group;

@end

/**
 *  对齐方式
 */
typedef enum : NSUInteger {
    bLabelAlignmentTypeLeft,
    bLabelAlignmentTypeCenter,
    bLabelAlignmentTypeRight,
} bLabelAlignmentType;

@interface bLabelGroup : UIView

@property (nonatomic,assign) id <bLabelGroupDelegate>delegate;
// if set, item width is fixed.
@property (nonatomic,assign) float itemWidth;

- (void)addItemInitBlock:(void(^)(UIButton *btn,bLabelGroup *group))block;
- (void)addGroupUpdateBlock:(void(^)(bLabelGroup *group))block;
- (void)addSelectBlock:(void(^)(UIButton *btn, NSUInteger index, bLabelGroup *group))block;

/**
 *  初始化类型
 *  type 对齐方式
 *  width 最大宽度
 *  stepWidth 两个单元之间间隔
 *  sideX 每行第一个单元x的额外距离
 *  sideY 两行之间间隔
 *  itemHeight 每行的高度
 *  margin 文字距离边框
 */
- (void)updateType:(bLabelAlignmentType)type width:(float)width stepWidth:(float)stepWidth sideX:(float)sideX sideY:(float)sideY itemHeight:(float)itemHeight margin:(float)margin;

/**
 *  图片 view的布局
 *  number 总个数
 *  控件是正方形的 高度和宽度相同
 */
- (void)updateNumber:(NSUInteger)number;

/**
 *  更新文本和选中状态
 *  tempArr 文本数组
 *  selected 选中状态数组
 */
- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected;

- (void)updateLabels:(NSArray *)tempArr selectedIndex:(NSUInteger)index;

/**
 *  清空选中
 */
- (void)clearSelect;

/**
 *  更新选中
 */
- (void)updateSelect:(BOOL)select atIndex:(NSUInteger)index;

@end
