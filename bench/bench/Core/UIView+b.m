//
//  UIView+PandoraBox.m
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import "UIView+b.h"

#import <objc/runtime.h>
#import "b.h"
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

- (void)initUI:(UIView *)parent {
    
}

- (void)initUI:(UIView *)parent width:(CGFloat)width height:(CGFloat)height {
    
}

- (void)setupData {
    
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

@end
