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
//#import "CC_CoreCrash.h"

typedef void (^bAssociatedTapBlock)(UIView *view);

@implementation UIView (b)

- (id)benchInitOnParent:(UIView *)parent {
    UIView *view = [self initWithFrame:parent.frame];
    view.left = 0;
    view.top = 0;
    [view initUI:parent];
    [parent addSubview:view];
    return view;
}

- (id)benchInitOnParent:(UIView *)parent width:(CGFloat)width height:(CGFloat)height {
    UIView *view = [self initWithFrame:parent.frame];
    view.left = 0;
    view.top = 0;
    view.width = width;
    view.height = height;
    [view initUI:parent width:width height:height];
    [parent addSubview:view];
    return view;
}

- (void)initUI:(UIView *)parent {
    
}

- (void)initUI:(UIView *)parent width:(CGFloat)width height:(CGFloat)height {
    
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

- (NSString *)benchUniqueKey {
    return objc_getAssociatedObject(self, @selector(benchUniqueKey));
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
//            CCLOG(@"%@",view.name);
            if ([view.name isEqualToString:name]) {
                return view;
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

@end
