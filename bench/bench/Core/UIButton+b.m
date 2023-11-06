//
//  UIButton+p.m
//  PandoraBox
//
//  Created by gwh on 2022/1/7.
//

#import "UIButton+b.h"

@implementation UIButton (b)

@dynamic b_normalColor, b_normalTitle;

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

+ (UIButton *)b_blackBorderUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(50), RH(50));
    ui.layer.cornerRadius = RH(4);
    [ui setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.borderWidth = 2;
    ui.layer.borderColor = UIColor.blackColor.CGColor;
    ui.titleLabel.font = BRF(16);
    ui.b_normalColor = UIColor.blackColor;
    return ui;
}

+ (UIButton *)b_whiteBorderUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(50), RH(50));
    ui.layer.cornerRadius = RH(4);
    [ui setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.grayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.borderWidth = 2;
    ui.layer.borderColor = UIColor.whiteColor.CGColor;
    ui.titleLabel.font = BRF(16);
    ui.b_normalColor = UIColor.blackColor;
    return ui;
}

+ (UIButton *)b_borderRadiusUIButton {
    UIButton *ui = UIButton.new;
    ui.size = CGSizeMake(RH(80), RH(40));
    [ui setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [ui setTitleColor:UIColor.darkGrayColor forState:UIControlStateDisabled];
    ui.titleLabel.font = RF(16);
    ui.layer.cornerRadius = RH(4);
    ui.layer.borderWidth = 1;
    ui.layer.borderColor = UIColor.grayColor.CGColor;
    return ui;
}

+ (UIButton *)b_roundSingelUIButton {
    UIButton *pk = UIButton.b_UIButton;
    pk.size = CGSizeMake(RH(30), RH(30));
    pk.layer.cornerRadius = RH(15);
    pk.layer.borderColor = UIColor.whiteColor.CGColor;
    pk.layer.borderWidth = 1;
    pk.titleLabel.font = BRF(12);
    pk.b_normalColor = UIColor.whiteColor;
    pk.backgroundColor = RGBA(0, 0, 0, 0.5);
    return pk;
}

+ (UIButton *)b_panUIButton {
    UIButton *button = UIButton.b_UIButton;
    [button setTitleColor:UIColor.b_lightYellow forState:UIControlStateHighlighted];
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

- (void)setB_normalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
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
    [self setImage:image1 forState:UIControlStateNormal];
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
