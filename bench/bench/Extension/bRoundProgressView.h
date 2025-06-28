//
//  benchRoundProgressView.h
//  bench
//
//  Created by gwh on 2024/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bRoundProgressView : UIView

/**
 * 创建圆形进度条
 * @param r 圆的半径
 * @return 圆形进度条实例
 */
+ (bRoundProgressView *)createWithR:(float)r;

/**
 * 设置进度
 * @param percent 进度值(0-100)
 */
- (void)setPercent:(int)percent;

/**
 * 设置中心文本
 * @param text 要显示的文本
 */
- (void)setText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END 
