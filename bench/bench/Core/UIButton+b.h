//
//  UIButton+p.h
//  PandoraBox
//
//  Created by gwh on 2022/1/7.
//

#import <UIKit/UIKit.h>
#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (b)

@property (nonatomic, retain) NSString *b_normalTitle;
@property (nonatomic, retain) UIColor *b_normalColor;
//@property (nonatomic, retain) UIFont *b_font;

+ (UIButton *)b_UXButton;
+ (UIButton *)b_titleButton;

+ (UIButton *)b_finishRoundButton;
+ (UIButton *)b_UIButton;
+ (UIButton *)b_blackBorderUIButton;
+ (UIButton *)b_whiteBorderUIButton;
+ (UIButton *)b_borderUIButton;
+ (UIButton *)b_borderRadiusUIButton;
+ (UIButton *)b_roundSingelUIButton;
+ (UIButton *)b_panUIButton;
+ (UIButton *)b_okUIButton;

- (void)addTappedButtonOnceWithBlock:(void (^)(UIButton *button))block;
- (void)addTappedButtonOnceDelay:(float)time withBlock:(void (^)(UIButton *button))block;

- (void)setImage:(UIImage *)image withBenchPieceRect:(BenchPicecRect)benchPicecRect;
- (void)setImage:(UIImage *)image withRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
