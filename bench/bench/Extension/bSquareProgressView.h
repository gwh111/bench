//
//  benchSquareProgressView.h
//  bench
//
//  Created by gwh on 2024/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bSquareProgressView : UIView

/**
 * 创建正方形进度条
 * @param r 正方形的半宽（也是圆的半径）
 * @return 正方形进度条实例
 */
+ (bSquareProgressView *)createWithR:(float)r;

/**
 * 设置进度
 * @param percent 进度值(0-100)
 */
- (void)setPercent:(float)percent;

/**
 * 设置中心文本
 * @param text 要显示的文本
 */
- (void)setText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END 
