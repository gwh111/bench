//
//  benchRoundProgressView.m
//  bench
//
//  Created by gwh on 2024/3/21.
//

#import "bRoundProgressView.h"
#import "bench.h"

@interface bRoundProgressView()

@property (nonatomic, assign) float r;
@property (nonatomic, assign) int percent;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation bRoundProgressView

+ (bRoundProgressView *)createWithR:(float)r {
    bRoundProgressView *view = [[bRoundProgressView alloc] init];
    view.r = r;
    view.frame = CGRectMake(0, 0, r * 2, r * 2);
    [view setupUI];
    return view;
}

- (void)setupUI {
    // 创建背景圆环
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.fillColor = [UIColor clearColor].CGColor;
    backgroundLayer.strokeColor = [UIColor colorWithWhite:0 alpha:0.3].CGColor;
    backgroundLayer.lineWidth = 4;
    backgroundLayer.lineCap = kCALineCapRound;
    
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.r, self.r)
                                                                 radius:self.r - 2
                                                             startAngle:-M_PI_2
                                                               endAngle:M_PI * 2 - M_PI_2
                                                              clockwise:YES];
    backgroundLayer.path = backgroundPath.CGPath;
    [self.layer addSublayer:backgroundLayer];
    
    // 创建进度圆环
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor = RGBA(0, 0, 0, 0.8).CGColor;
    self.progressLayer.strokeColor = [UIColor colorWithWhite:0 alpha:0.7].CGColor;
    self.progressLayer.lineWidth = 4;
    self.progressLayer.lineCap = kCALineCapRound;
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

- (void)setPercent:(int)percent {
    _percent = MAX(0, MIN(100, percent));
    
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.r, self.r)
                                                               radius:self.r - 2
                                                           startAngle:-M_PI_2
                                                             endAngle:-M_PI_2 + (M_PI * 2 * _percent / 100.0)
                                                            clockwise:YES];
    self.progressLayer.path = progressPath.CGPath;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = text;
}

@end

/*
 使用示例:
 
 // 创建一个半径为50的圆形进度条
 benchRoundProgressView *progressView = [benchRoundProgressView createWithR:50];
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
