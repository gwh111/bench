//
//  UIView+PandoraBox.h
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (b)

@property (nonatomic, assign) float b_centerTop;//屏幕居中

@property (nonatomic, copy) NSString *name;

@property CGSize size;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

- (void)addTappedOnceDelay:(float)time withBlock:(void (^)(UIView *))block;
- (void)addTappedOnceWithBlock:(void (^)(UIView *view))block;

- (nullable __kindof id)viewWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
