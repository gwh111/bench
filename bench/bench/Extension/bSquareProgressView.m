//
//  benchSquareProgressView.m
//  bench
//
//  Created by gwh on 2024/3/21.
//

#import "bSquareProgressView.h"
#import "bench.h"

@interface bSquareProgressView()

@property (nonatomic, assign) float r;
@property (nonatomic, assign) float percent;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@end

@implementation bSquareProgressView

+ (bSquareProgressView *)createWithR:(float)r {
    bSquareProgressView *view = [[bSquareProgressView alloc] init];
    view.r = r;
    view.frame = CGRectMake(0, 0, r * 2, r * 2);
    [view setupUI];
    return view;
}

- (void)setupUI {
    // 创建背景正方形
    self.backgroundLayer = [CAShapeLayer layer];
    self.backgroundLayer.frame = self.bounds;
    self.backgroundLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.3].CGColor;
    
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.backgroundLayer.path = backgroundPath.CGPath;
    [self.layer addSublayer:self.backgroundLayer];
    
    // 创建进度层
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor = [UIColor colorWithWhite:100 alpha:0.7].CGColor;
    [self.layer addSublayer:self.progressLayer];
    
    // 创建中心文本
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.textLabel];
    
    // 设置文本位置
    self.textLabel.frame = CGRectMake(0, 0, self.r * 1.5, 20);
    self.textLabel.center = CGPointMake(self.r, self.r);
}

- (void)setPercent:(float)percent {
    _percent = MAX(0, MIN(100, percent));
    
    UIBezierPath *progressPath = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(self.r, self.r);
    float angle = M_PI * 2 * _percent / 100.0;
    
    // 从中心点开始
    [progressPath moveToPoint:center];
    
    // 根据角度计算填充区域
    if (_percent <= 25) {
        // 0-90度
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, self.r)];
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, self.r - self.r * tan(angle))];
        [progressPath addLineToPoint:center];
    } else if (_percent <= 50) {
        // 90-180度
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, self.r)];
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, 0)];
        [progressPath addLineToPoint:CGPointMake(self.r + self.r * tan(angle - M_PI_2), 0)];
        [progressPath addLineToPoint:center];
    } else if (_percent <= 75) {
        // 180-270度
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, self.r)];
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, 0)];
        [progressPath addLineToPoint:CGPointMake(0, 0)];
        [progressPath addLineToPoint:CGPointMake(0, self.r - self.r * tan(angle - M_PI))];
        [progressPath addLineToPoint:center];
    } else {
        // 270-360度
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, self.r)];
        [progressPath addLineToPoint:CGPointMake(self.r + self.r, 0)];
        [progressPath addLineToPoint:CGPointMake(0, 0)];
        [progressPath addLineToPoint:CGPointMake(0, self.r + self.r)];
        [progressPath addLineToPoint:CGPointMake(self.r - self.r * tan(angle - M_PI * 1.5), self.r + self.r)];
        [progressPath addLineToPoint:center];
    }
    
    [progressPath closePath];
    self.progressLayer.path = progressPath.CGPath;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = text;
}

@end

/*
 使用示例:
 
 // 创建一个边长为100的正方形进度条
 benchSquareProgressView *progressView = [benchSquareProgressView createWithR:50];
 progressView.center = self.view.center;
 [self.view addSubview:progressView];
 
 // 设置进度为75%
 [progressView setPercent:75];
 
 // 设置中心文本
 [progressView setText:@"75%"];
 
 // 动画更新进度
 [UIView animateWithDuration:1.0 animations:^{
     [progressView setPercent:100];
     [progressView setText:@"100%"];
 }];
 */ 
