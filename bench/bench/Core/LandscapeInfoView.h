//
//  InfoView.h
//  RY
//
//  Created by gwh on 2022/7/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LandscapeInfoView : UIView

@property (nonatomic, retain) UITextView *askView;
@property (nonatomic, assign) BOOL isSmall;
@property (nonatomic, strong) void(^finishBlock)(BOOL);

+ (void)playSmallInfo:(id)content block:(void(^)(BOOL ok))block;
+ (void)playInfo:(id)content block:(void(^)(BOOL ok))block;

@end

NS_ASSUME_NONNULL_END
