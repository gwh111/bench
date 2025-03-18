//
//  bInfoView.h
//  bench
//
//  Created by gwh on 2025/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bInfoView : UIView

@property (nonatomic, retain) NSMutableAttributedString *att;
@property (nonatomic, retain) NSString *str;

+ (void)showInfo:(NSMutableAttributedString *)att;
+ (void)showInfoStr:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
