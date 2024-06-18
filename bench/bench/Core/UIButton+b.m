//
//  UIButton+p.m
//  PandoraBox
//
//  Created by gwh on 2022/1/7.
//

#import "UIButton+b.h"
#import "CALayer+b.h"

@implementation UIButton (b)

@dynamic b_normalColor, b_normalTitle;

+ (UIButton *)b_finishRoundButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    [ui setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.darkGrayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.cornerRadius = RH(4);
    ui.backgroundColor = RGB(232, 232, 232);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.lightGrayColor.CGColor;
    return ui;
}

+ (UIButton *)b_UIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    ui.titleLabel.font = RF(16);
    return ui;
}

+ (UIButton *)b_borderUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    [ui setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.darkGrayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.grayColor.CGColor;
    return ui;
}

+ (UIButton *)b_UXButton {
    UIButton *ui = UIButton.b_blackBorderUIButton;
    ui.layer.cornerRadius = 0;
    ui.b_normalColor = UIColor.blackColor;
    ui.layer.borderColor = ui.b_normalColor.CGColor;
    ui.layer.borderWidth = 1;
    ui.titleLabel.font = RF(16);
    ui.backgroundColor = RGBA(255, 255, 255, 1);
    return ui;
}

+ (UIButton *)b_blackBackButton {
    UIButton *ui = UIButton.new;
    ui.b_normalColor = UIColor.whiteColor;
    ui.backgroundColor = RGB(22, 22, 22);
    ui.titleLabel.font = RF(14);
    return ui;
}

+ (UIButton *)b_topButton {
    UIButton *ui = UIButton.new;
    ui.b_normalColor = UIColor.whiteColor;
    ui.titleLabel.font = BRF(14);
    return ui;
}

+ (UIButton *)b_titleButton {
    UIButton *ui = UIButton.new;
    ui.b_normalColor = UIColor.blackColor;
    ui.titleLabel.font = RF(14);
    return ui;
}

+ (UIButton *)b_blackBorderUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(50), RH(50));
    ui.layer.cornerRadius = RH(10);
    [ui setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(14);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.blackColor.CGColor;
    ui.titleLabel.font = RF(14);
    ui.b_normalColor = UIColor.blackColor;
    ui.backgroundColor = UIColor.whiteColor;
    return ui;
}

+ (UIButton *)b_whiteBorderUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(50), RH(50));
    ui.layer.cornerRadius = RH(4);
    [ui setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(14);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.whiteColor.CGColor;
    ui.titleLabel.font = RF(14);
    ui.b_normalColor = UIColor.blackColor;
    return ui;
}

+ (UIButton *)b_borderRadiusUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    [ui setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.darkGrayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(14);
    ui.layer.cornerRadius = RH(4);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.grayColor.CGColor;
    return ui;
}

+ (UIButton *)b_gameButton {
    float width = WIDTH()/3-RH(60)/3;
    UIButton *pk = UIButton.b_UIButton;
    pk.size = CGSizeMake(width, RH(40));
    pk.layer.cornerRadius = pk.height/2;
    pk.layer.borderColor = UIColor.grayColor.CGColor;
    pk.layer.borderWidth = 1;
    pk.titleLabel.font = RF(18);
    pk.b_normalColor = UIColor.whiteColor;
    pk.backgroundColor = RGBA(0, 0, 0, 0.8);
    [pk setBackgroundImage:[UIImage imageNamed:@"ui/btn.jpg"] forState:UIControlStateNormal];
    pk.clipsToBounds = YES;
//    pk.layer.b_addBenchShadowRightBottom;
    return pk;
}

+ (UIButton *)b_gameLinButton {
    float width = WIDTH()/3-RH(60)/3;
    UIButton *pk = UIButton.b_UIButton;
    pk.size = CGSizeMake(width, RH(40));
    pk.titleLabel.font = RF(18);
    pk.b_normalColor = UIColor.whiteColor;
    pk.clipsToBounds = YES;
    UIView *lin = UIView.new;
    lin.width = RH(40);
    lin.height = RH(40);
    lin.left = RH(20);
    lin.layer.borderColor = UIColor.grayColor.CGColor;
    lin.layer.borderWidth = 1;
//    lin.backgroundColor = RGBA(0, 0, 0, 0.8);
    lin.transform = CGAffineTransformMakeRotation(M_PI/4);
    [pk addSubview:lin];
    return pk;
}

+ (UIButton *)b_roundSingelUIButton {
    UIButton *pk = UIButton.b_UIButton;
    pk.size = CGSizeMake(RH(30), RH(30));
    pk.layer.cornerRadius = RH(10);
    pk.layer.borderColor = UIColor.whiteColor.CGColor;
    pk.layer.borderWidth = 1;
    pk.titleLabel.font = RF(14);
    pk.b_normalColor = UIColor.whiteColor;
    pk.backgroundColor = RGBA(0, 0, 0, 0.8);
    return pk;
}

+ (UIButton *)b_panUIButton {
    UIButton *button = UIButton.b_UIButton;
    [button setTitleColor:UIColor.b_lightYellow forState:UIControlStateHighlighted];
    button.b_normalColor = UIColor.whiteColor;
    button.size = CGSizeMake(RH(60), RH(20));
    button.backgroundColor = UIColor.grayColor;
    button.titleLabel.font = RF(12);
    button.top = RH(200);
    button.layer.shadowOffset = CGSizeMake(1, 1);
    button.layer.shadowColor = UIColor.whiteColor.CGColor;
    button.layer.shadowRadius = 3;
    button.layer.shadowOpacity = 1.0;
    button.layer.cornerRadius = RH(10);
    return button;
}

+ (UIButton *)b_okUIButton {
    UIButton *button = UIButton.b_UIButton;
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [button setTitleColor:UIColor.b_lightYellow forState:UIControlStateHighlighted];
    button.b_normalColor = UIColor.whiteColor;
    button.size = CGSizeMake(RH(60), RH(30));
    button.backgroundColor = UIColor.grayColor;
    button.titleLabel.font = RF(16);
    button.top = RH(200);
//    button.layer.shadowOffset = CGSizeMake(1, 1);
//    button.layer.shadowColor = UIColor.blackColor.CGColor;
//    button.layer.shadowRadius = 6;
//    button.layer.shadowOpacity = 1.0;
    button.layer.cornerRadius = 6;
    return button;
}

- (NSString *)b_normalTitle {
    return self.titleLabel.text;
}

- (void)setB_normalTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (UIColor *)b_normalColor {
    return self.titleLabel.textColor;
}

- (void)setB_normalColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setB_font:(UIFont *)font {
    self.titleLabel.font = font;
}

- (void)addTappedButtonOnceWithBlock:(void (^)(UIButton *button))block {
    [self addTappedOnceWithBlock:^(UIView *v) {
        block((UIButton *)v);
    }];
}

- (void)addTappedButtonOnceDelay:(float)time withBlock:(void (^)(UIButton *button))block {
    [self addTappedOnceDelay:time withBlock:^(UIView *v) {
        block((UIButton *)v);
    }];
}

- (void)setImage:(UIImage *)image withRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rect);
    UIImage *image1 = [UIImage imageWithCGImage:imageRef];
    self.imageView.image = image1;
//    [self setImage:image1 forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image withBenchPieceRect:(BenchPicecRect)benchPicecRect {
    
    if (!image) {
        NSLog(@"image is nill");
        return;
    }
    float w = image.size.width;
    float h = image.size.height;
    
    int row = benchPicecRect.row;
    int totalRow = benchPicecRect.totalRow;
    if (row >= totalRow) {
        assert("row cannot total");
    }
    int colum = benchPicecRect.colum;
    int totalColum = benchPicecRect.totalColum;
    if (colum >= totalColum) {
        assert("colum cannot total");
    }
    
    float pieceRow = w /totalRow;
    float pieceColum = h /totalColum;
    
    CGPoint center = self.center;
    float height = self.frame.size.width * pieceColum/pieceRow;
    self.height = height;
    self.center = center;
    
    CGRect rect = CGRectMake(pieceRow * row, pieceColum * colum, pieceRow, pieceColum);
    [self setImage:image withRect:rect];
}

@end
