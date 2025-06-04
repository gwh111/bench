//
//  UIView+PandoraBox.m
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import "UIView+b.h"

#import <objc/runtime.h>
#import "bench.h"
#import "UITapGestureRecognizer+b.h"
#import "CALayer+b.h"
//#import "CC_CoreCrash.h"

@implementation UIView (b)

- (void)show {
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showToAlpha:(CGFloat)alpha {
    //    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = alpha;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)unshowShow {
    self.alpha = 1;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)unshow {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)benchInitOnParent:(UIView *)parent {
    UIView *view = self;
    view.frame = parent.frame;
    view.left = 0;
    view.top = 0;
    [view initUI:parent];
    [parent addSubview:view];
    //    return view;
}

- (void)benchInitOnParent:(UIView *)parent width:(CGFloat)width height:(CGFloat)height {
    UIView *view = self;
    view.frame = parent.frame;
    view.left = 0;
    view.top = 0;
    view.width = width;
    view.height = height;
    [view initUI:parent width:width height:height];
    [parent addSubview:view];
    
    
    
    //        CATransition *animation = [CATransition animation];
    //        animation.type = @"cube";
    //        animation.subtype = kCATransitionFromRight;
    //        animation.duration = 1.0;
    //        // 在window上执行CATransition, 即可在ViewController转场时执行动画
    //        [view.layer addAnimation:animation forKey:@"kTransitionAnimation"];
    //    return view;
}

- (void)addBGPath:(NSString *)imagepath mode:(UIViewContentMode)mode {
    UIImageView *deskbg = UIImageView.new;
    deskbg.width = self.width;
    deskbg.height = self.height;
    [deskbg setImageWithPath:imagepath];
    [self addSubview:deskbg];
    deskbg.contentMode = mode;
    deskbg.alpha = 0.8;
}

- (void)initUI:(UIView *)parent {
    
}

- (void)initUI:(UIView *)parent width:(CGFloat)width height:(CGFloat)height {
    
}

- (void)setupTableData {
    
}

- (void)b_addBenchShadow {
    [self.layer b_addBenchShadow];
    
    self.layer.masksToBounds = YES;
    UIView *view = UIView.new;
    view.backgroundColor = UIColor.whiteColor;
    view.frame = self.frame;
    [self.superview addSubview:view];
    
    [self.superview bringSubviewToFront:self];
    
    CALayer *layer = view.layer;
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    layer.cornerRadius = RH(10);
    layer.shadowColor = UIColor.b_lightRed.CGColor;
    layer.shadowOpacity = 0.6;
    layer.shadowOffset = CGSizeMake(RH(5), -RH(6));
    
}



- (bAssociatedTapMenuBlock)bAssociatedTapMenuBlock {
    return objc_getAssociatedObject(self, @selector(bAssociatedTapMenuBlock));
}

- (void)setbAssociatedTapMenuBlock:(bAssociatedTapMenuBlock)bAssociatedTapMenuBlock {
    objc_setAssociatedObject(self, @selector(bAssociatedTapMenuBlock), bAssociatedTapMenuBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addMenuTappedWithBlock:(bAssociatedTapMenuBlock)block {
    [self setbAssociatedTapMenuBlock:block];
}

- (void)menuBlock:(NSString *)key {
    bAssociatedTapMenuBlock block = self.bAssociatedTapMenuBlock;
    block(key);
}



- (NSString *)benchUniqueKey {
    return objc_getAssociatedObject(self, @selector(benchUniqueKey));
}

- (void)addTappedOnceDelay:(float)time withBlock:(void (^)(UIView *))block {
    [self b_tappedInterval:time withBlock:block];
}

- (void)addTappedOnceWithBlock:(void (^)(UIView *))block {
    [self b_tappedInterval:0.1 withBlock:block];
}

- (void)tappedInterval:(NSTimeInterval)interval withBlock:(void (^)(id))block {
    [self b_tappedInterval:interval withBlock:block];
}

- (nullable __kindof UIView *)b_tappedInterval:(NSTimeInterval)timeInterval withBlock:(void (^)(id))block {
    [self setAssociatedTapBlock:block];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf:)];
    tap.timeInterval = timeInterval;
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
    
    return self;
}

- (void)tapSelf:(UITapGestureRecognizer *)tap {
    self.userInteractionEnabled = NO;
    
    [b delay:tap.timeInterval block:^{
        self.userInteractionEnabled = YES;
    }];
    
    __weak __typeof(&*self)weakSelf = self;
    bAssociatedTapBlock tapBlock = [self associatedTapBlock];
    if (tapBlock) {
        tapBlock(weakSelf);
    }
}

// MARK: - Associated -
- (void)setAssociatedTapBlock:(bAssociatedTapBlock)associatedTapBlock {
    objc_setAssociatedObject(self, @selector(associatedTapBlock), associatedTapBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedTapBlock {
    return objc_getAssociatedObject(self, @selector(associatedTapBlock));
}

// ?
- (void)setAssociatedTapTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)associatedTapTimeInterval {
    return [objc_getAssociatedObject(self, @selector(associatedTapTimeInterval))doubleValue];
}

- (void)setB_centerTop:(float)top {
    if (self.width <= 0) {
        NSLog(@"benchLog:btn width is 0");
    }
    self.top = top;
    self.left = WIDTH()/2-self.width/2;
}

- (void)setBenchUniqueKey:(NSString *)key {
    objc_setAssociatedObject(self, @selector(benchUniqueKey), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)benchName {
    return objc_getAssociatedObject(self, @selector(benchName));
}

- (void)setBenchName:(NSString *)benchName {
    objc_setAssociatedObject(self, @selector(benchName), benchName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (nullable __kindof id)viewWithName:(NSString *)name {
    for (UIView *view in self.subviews) {
        if (view.name) {
            if ([view.name isEqualToString:name]) {
                return view;
            }
        }
    }
    return nil;
}

- (nullable __kindof id)viewWithBenchName:(NSString *)name {
    for (UIView *view in self.subviews) {
        if (view.benchName) {
            if ([view.benchName isEqualToString:name]) {
                return view;
            }
        }
    }
    return nil;
}

- (nullable __kindof id)viewWithBenchName:(NSString *)name subName:(NSString *)subname {
    for (UIView *view in self.subviews) {
        if (view.benchName) {
            if ([view.benchName isEqualToString:name]) {
                for (UIView *view2 in view.subviews) {
                    if ([view2.benchName isEqualToString:subname]) {
                        return view2;
                    }
                }
            }
        }
    }
    return nil;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth {
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right {
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setRight:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x+self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta;
    self.frame = newframe;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint newCenter = self.center;
    newCenter.x = centerX;
    self.center = newCenter;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint newCenter = self.center;
    newCenter.y = centerY;
    self.center = newCenter;
}

- (UIImage *)screenshot {
    UIImage *image = nil;
    CGSize size = CGSizeMake(320,480);
    size = self.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}

- (UIImage *)screenshotWithSize:(CGSize)size {
    UIImage *image = nil;
    //    CGSize size = CGSizeMake(320,480);
    //    size = self.frame.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}

- (void)stopAlphaBreath {
    [b setSharedKey:@"stopAlphaBreath" object:@(1)];
}

- (void)startAlphaBreath:(BOOL)fade speed:(float)speed {
    int stopAlphaBreath = [[b getSharedKey:@"stopAlphaBreath"]intValue];
    if (stopAlphaBreath) {
        return;
    }
    float fadeAlpha = 1;
    if (fade == NO) {
        fadeAlpha = 0.2;
    }
    [UIView animateWithDuration:speed animations:^{
        self.alpha = fadeAlpha;
        } completion:^(BOOL finished) {
            [self startAlphaBreath:!fade speed:speed];
        }];
}

- (void)addShakeTimes:(int)times block:(void(^)(void))block {
    times = times-1;
    if (times <= 0) {
        block();
        return;
    }
    float left = self.left;
    [UIView animateWithDuration:0.05 animations:^{
        self.left = left-RH(2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.left = left+RH(2);
        } completion:^(BOOL finished) {
            self.left = left;
            [self addShakeTimes:times block:block];
        }];
    }];
}

- (void)addShakeTimes:(int)times speed:(float)speed wait:(float)wait block:(void(^)(void))block {
    times = times-1;
    if (times <= 0) {
        block();
        return;
    }
    float left = self.left;
    [UIView animateWithDuration:speed animations:^{
        self.left = left-RH(2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:speed*2 animations:^{
            self.left = left+RH(2);
        } completion:^(BOOL finished) {
            self.left = left;
            [b delay:wait block:^{
                [self addShakeTimes:times speed:speed wait:wait block:block];
            }];
        }];
    }];
}

- (void)shake:(int)time {
    
}

- (void)addOpaqueBlackFull {
    UIView *black = UIView.new;
    black.width = WIDTH();
    black.height = HEIGHT();
    [self addSubview:black];
    black.backgroundColor = RGBA(0, 0, 0, 0.5);
}

- (void)addFadeBlackLayerFromTop {
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = CGRectMake(0, 0, self.width, self.height+2);
    layer.colors = @[(id)UIColor.blackColor.CGColor, (id)UIColor.clearColor.CGColor];
    layer.locations = @[@(0),@(0.7)];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    [self.layer addSublayer:layer];
}

- (void)addFadeBlackLayerFromBottom {
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = CGRectMake(0, 0, self.width, self.height+2);
    layer.colors = @[(id)UIColor.blackColor.CGColor, (id)UIColor.clearColor.CGColor];
    layer.locations = @[@(0),@(0.7)];
    layer.startPoint = CGPointMake(0.5, 1);
    layer.endPoint = CGPointMake(0.5, 0);
    [self.layer addSublayer:layer];
}

- (void)addFadeBlack05LayerFromBottom {
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = CGRectMake(0, 0, self.width, self.height);
    layer.colors = @[(id)RGBA(0, 0, 0, 0.5).CGColor, (id)UIColor.clearColor.CGColor];
    layer.locations = @[@(0),@(1)];
    layer.startPoint = CGPointMake(0.5, 1);
    layer.endPoint = CGPointMake(0.5, 0);
    [self.layer addSublayer:layer];
}

- (void)addFadeBlackLayerFromLeft {
    CAGradientLayer *layer = CAGradientLayer.new;
    layer.frame = CGRectMake(0, 0, self.width, self.height+2);
    layer.colors = @[(id)UIColor.blackColor.CGColor, (id)UIColor.clearColor.CGColor];
    layer.locations = @[@(0),@(0.7)];
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(1, 0.5);
    [self.layer addSublayer:layer];
}

- (UIVisualEffectView *)addBlurEffectView {
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurv = [[UIVisualEffectView alloc]initWithEffect:blur];
    blurv.frame = self.frame;
    [self addSubview:blurv];
    return blurv;
}

- (void)addInkVCBack:(NSString *)title backName:(NSString *)back {
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurv = [[UIVisualEffectView alloc]initWithEffect:blur];
    blurv.frame = self.frame;
    [self addSubview:blurv];
    
    UIImageView *desk = UIImageView.new;
    desk.width = WIDTH();
    desk.height = HEIGHT();
    [self addSubview:desk];
    desk.contentMode = UIViewContentModeScaleAspectFill;
    desk.image = [UIImage imageNamed:back];
    desk.alpha = 0.3;
    
    [self safeView];
    
    UIButton *btn = UIButton.b_gameInkButton;
    btn.width = RH(150);
    btn.height = RH(50);
    btn.left = SAFE_BOTTOM()+RH(10);
    btn.top = SAFE_TOP()+RH(10);
    [self addSubview:btn];
    
    UILabel *label = UILabel.b_whiteTextUILabel;
    label.width = RH(200);
    label.height = RH(50);
    label.left = SAFE_BOTTOM()+RH(10);
    label.top = SAFE_TOP()+RH(10);
    label.font = RF(30);
    [self addSubview:label];
    label.text = title;
    
    UIButton *close = UIButton.b_gameInkCloseButton;
    close.width = RH(60);
    close.titleLabel.font = RF(30);
    close.right = WIDTH()-SAFE_BOTTOM()-RH(10);
    close.top = SAFE_TOP()+RH(10);
    [self addSubview:close];
    [close addTappedOnceWithBlock:^(UIView *v) {
        [self dismiss];
    }];
}

- (UIScrollView *)getPopViewWidth:(CGFloat)width {
    UIScrollView *contentView = [self viewWithBenchName:@"contentView"];
    if (contentView) {
        return contentView;
    }
    self.size = CGSizeMake(WIDTH(), HEIGHT());
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    [self addBlurEffectView];
    
    UIButton *close = UIButton.new;
    close.size = CGSizeMake(WIDTH(), HEIGHT());
    [self addSubview:close];
    [close addTappedOnceWithBlock:^(UIView *v) {
        [self dismiss];
    }];
    
    UIImageView *back = UIImageView.new;
    back.size = CGSizeMake(width, HEIGHT());
    back.image = [UIImage imageNamed:@"ui_point/point_square"];
    back.centerX = WIDTH()/2;
    back.centerY = HEIGHT()/2;
    [self addSubview:back];
    [b delay:0.2 block:^{
        [back addShakeTimes:5 block:^{
                
        }];
    }];
    back.benchName = @"back";
    
    float w = back.width-RH(150);
    float h1 = back.height-RH(100);
    contentView = UIScrollView.new;
    contentView.size = CGSizeMake(w, h1);
    [self addSubview:contentView];
    contentView.benchName = @"contentView";
    contentView.center = back.center;
    
    return contentView;
}

- (UIScrollView *)getPopView {
    UIScrollView *contentView = [self getPopViewWidth:HEIGHT()+RH(170)];
    
    return contentView;
}

- (UIView *)getPopViewWithOK {
    self.size = CGSizeMake(WIDTH(), HEIGHT());
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    [self addBlurEffectView];
    
    UIButton *close = UIButton.new;
    close.size = CGSizeMake(WIDTH(), HEIGHT());
    [self addSubview:close];
    [close addTappedOnceWithBlock:^(UIView *v) {
        [self dismiss];
    }];
    
    UIImageView *back = UIImageView.new;
    back.size = CGSizeMake(HEIGHT()+RH(120), HEIGHT()-RH(80));
    back.image = [UIImage imageNamed:@"ui_point/point_square"];
    back.centerX = WIDTH()/2;
    back.top = RH(10);
    [self addSubview:back];
    [back addShakeTimes:5 block:^{
            
    }];
    
    float w = back.width-RH(100);
    float h1 = back.height-RH(100);
    UIView *contentView = UIView.new;
    contentView.size = CGSizeMake(w, h1);
    [self addSubview:contentView];
    contentView.center = back.center;
    
    {
        UIButton *pk = UIButton.b_gameInkButton;
        [self addSubview:pk];
        pk.top = contentView.bottom+RH(20);
        pk.left = contentView.left;
        pk.b_normalTitle = @"取消";
        [pk addTappedOnceWithBlock:^(UIView *v) {
            
            [self dismiss];
        }];
        pk.benchName = @"cancel";
        pk.right = 0;
        [UIView animateWithDuration:0.25 animations:^{
            pk.left = contentView.left;
        }];
    }
    {
        UIButton *pk = UIButton.b_gameInkButton;
        [self addSubview:pk];
        pk.right = contentView.right;
        pk.top = contentView.bottom+RH(20);
        pk.b_normalTitle = @"确定";
        pk.titleLabel.font = BRF(16);
        [pk addTappedOnceWithBlock:^(UIView *v) {
            
        }];
        pk.benchName = @"ok";
        pk.left = WIDTH();
        [UIView animateWithDuration:0.25 animations:^{
            pk.right = contentView.right;
        }];
    }
    return contentView;
}

- (UIScrollView *)safeView {
    UIScrollView *displayView = objc_getAssociatedObject(self, @selector(displayView));
    if (displayView.height <= 0) {
        [self setupSafeView];
        displayView = objc_getAssociatedObject(self, @selector(displayView));
    }
    return displayView;
}

- (void)setSafeView:(UIScrollView *)displayView {
    objc_setAssociatedObject(self, @selector(displayView), displayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setupSafeView {
    UIScrollView *displayView = UIScrollView.new;
    displayView.size = CGSizeMake(WIDTH()-SAFE_BOTTOM()*2-RH(20), HEIGHT()-SAFE_TOP()*2-RH(20));
    displayView.centerX = WIDTH()/2;
    displayView.centerY = HEIGHT()/2;
    [self addSubview:displayView];
    self.safeView = displayView;
}

//- (bVideoQueue *)getVideoQueueAddBackVideoPaths:(NSArray *)paths {
//    NSArray *urls = @[
//        [NSURL URLWithString:@"平民男孩.mp4"],
//        [NSURL URLWithString:@"平民女孩.mp4"]
//    ];
//    bVideoQueue *videoQueue = [[bVideoQueue alloc] initWithURLs:urls];
//    
//    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:videoQueue.player];
//    layer.frame = self.bounds;
//    [self.layer addSublayer:layer];
//    
//    [videoQueue play];
//    [b setSharedKey:@"path" object:videoQueue];
//    
//    return videoQueue;
//}

- (bVideo *)getVideoAddBackVideoPaths:(NSArray<NSString *> *)paths {
    bVideo *video = [bVideo videoWithPaths:paths];
    video.displayView.size = self.size;
    [video playMutely];
    [self addSubview:video.displayView];
    [b setSharedKey:paths[0] object:video];
    video.displayView.userInteractionEnabled = NO;
    video.playerVC.showsPlaybackControls = YES;
    video.displayView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        video.displayView.alpha = 1;
    }];
    return video;
}

- (bVideo *)getVideoAddBackVideoPath:(NSString *)path {
    bVideo *video = [bVideo videoWithPath:path];
    video.displayView.size = self.size;
    [video playMutely];
    [self addSubview:video.displayView];
    [b setSharedKey:path object:video];
    video.displayView.userInteractionEnabled = NO;
    video.playerVC.showsPlaybackControls = YES;
    video.displayView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        video.displayView.alpha = 1;
    }];
    return video;
}

- (UIView *)addBackVideoPath:(NSString *)path {
    bVideo *video = [bVideo videoWithPath:path];
    video.displayView.size = self.size;
    [video playMutely];
    [self addSubview:video.displayView];
    [b setSharedKey:path object:video];
    video.displayView.userInteractionEnabled = NO;
    video.playerVC.showsPlaybackControls = YES;
//    [b delay:1 block:^{
//        [video playMutely];
//    }];
    //[video.displayView show];
    video.displayView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        video.displayView.alpha = 1;
    }];
    return video.displayView;
}

- (void)removeBackVideo:(NSString *)path {
    bVideo *video = [b getSharedKey:path];
    [UIView animateWithDuration:0.5 animations:^{
        video.displayView.alpha = 0;
    } completion:^(BOOL finished) {
        [video pause];
        [video removeObserver];
        [video.displayView removeFromSuperview];
        [b removeSharedKey:path];
    }];
}

- (void)removeBackVideoImmiditaly:(NSString *)path {
    bVideo *video = [b getSharedKey:path];
    [video pause];
    [video removeObserver];
    [video.displayView removeFromSuperview];
    [b removeSharedKey:path];
}

- (void)addStartBottomChinaWarning {
    UILabel *label = UILabel.new;
    [self addSubview:label];
    label.size = CGSizeMake(WIDTH()-RH(40), RH(60));
    label.left = RH(20);
    label.bottom = HEIGHT()-SAFE_BOTTOM();
    label.numberOfLines = 2;
    label.font = RF(12);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor.lightGrayColor;
    label.text = @"抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。\n适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。";
    label.adjustsFontSizeToFitWidth = YES;
}

@end
