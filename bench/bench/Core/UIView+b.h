//
//  UIView+PandoraBox.h
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import "b.h"
#import "bVideo.h"
//#import "bVideoQueue.h"

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
- (void)showToAlpha:(CGFloat)alpha;
- (void)unshow;
- (void)dismiss;
- (void)unshowShow;

- (void)addTappedOnceDelay:(float)time withBlock:(void (^)(UIView *))block;
- (void)addTappedOnceWithBlock:(void (^)(UIView *view))block;

- (void)addMenuTappedWithBlock:(bAssociatedTapMenuBlock)block;
- (void)menuBlock:(NSString *)key;
- (void)addBGPath:(NSString *)imagepath mode:(UIViewContentMode)mode;

- (nullable __kindof id)viewWithName:(NSString *)name;
- (nullable __kindof id)viewWithBenchName:(NSString *)name;
- (nullable __kindof id)viewWithBenchName:(NSString *)name subName:(NSString *)subname;

- (void)benchInitOnParent:(UIView *)parent;
- (void)benchInitOnParent:(UIView *)parent width:(CGFloat)width height:(CGFloat)height;

- (void)initUI:(UIView *)parent;
- (void)initUI:(UIView *)parent width:(CGFloat)width height:(CGFloat)height;

- (void)setupTableData;

- (UIImage *)screenshot;
- (UIImage *)screenshotWithSize:(CGSize)size;
//- (void)b_addBenchShadow;

- (void)addShakeTimes:(int)times block:(void(^)(void))block;
- (void)addShakeTimes:(int)times speed:(float)speed wait:(float)wait block:(void(^)(void))block;

- (UIVisualEffectView *)addBlurEffectView;
- (void)addInkVCBack:(NSString *)title backName:(NSString *)back;

@property (nonatomic, retain) UIScrollView *safeView;
- (UIScrollView *)getPopView;
- (UIView *)getPopViewWithOK;
- (UIScrollView *)getPopViewWidth:(CGFloat)width;

- (void)addOpaqueBlackFull;
- (void)addFadeBlackLayerFromTop;
- (void)addFadeBlackLayerFromBottom;
- (void)addFadeBlack05LayerFromBottom;
- (void)addFadeBlackLayerFromLeft;

- (bVideo *)getVideoAddBackVideoPath:(NSString *)path;
- (bVideo *)getVideoAddBackVideoPaths:(NSArray<NSString *> *)paths;

- (UIView *)addBackVideoPath:(NSString *)path;
- (void)removeBackVideo:(NSString *)path;
- (void)removeBackVideoImmiditaly:(NSString *)path;

- (void)stopAlphaBreath;
- (void)startAlphaBreath:(BOOL)fade speed:(float)speed;

- (void)addStartBottomChinaWarning;

@end

NS_ASSUME_NONNULL_END
