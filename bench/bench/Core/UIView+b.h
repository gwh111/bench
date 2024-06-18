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

@property (nonatomic, copy) NSString *benchUniqueKey;
@property (nonatomic, copy) NSString *benchName;

@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSMutableDictionary *menuTapBlocksMap;

@property CGSize size;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;


typedef void (^bAssociatedTapBlock)(UIView *view);
typedef void (^bAssociatedTapMenuBlock)(NSString *key);

- (void)show;
- (void)dismiss;

- (void)addTappedOnceDelay:(float)time withBlock:(void (^)(UIView *))block;
- (void)addTappedOnceWithBlock:(void (^)(UIView *view))block;

- (void)addMenuTappedWithBlock:(bAssociatedTapMenuBlock)block;
- (void)menuBlock:(NSString *)key;


- (nullable __kindof id)viewWithName:(NSString *)name;
- (nullable __kindof id)viewWithBenchName:(NSString *)name;
- (nullable __kindof id)viewWithBenchName:(NSString *)name subName:(NSString *)subname;

- (void)benchInitOnParent:(UIView *)parent;
- (void)benchInitOnParent:(UIView *)parent width:(CGFloat)width height:(CGFloat)height;

- (void)initUI:(UIView *)parent;
- (void)initUI:(UIView *)parent width:(CGFloat)width height:(CGFloat)height;

- (void)setupData;

- (UIImage *)screenshot;
- (UIImage *)screenshotWithSize:(CGSize)size;
//- (void)b_addBenchShadow;

- (void)addShakeTimes:(int)times block:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
