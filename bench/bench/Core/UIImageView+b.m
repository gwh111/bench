//
//  UIImageView+b.m
//  bench
//
//  Created by apple on 2023/7/5.
//

#import "UIImageView+b.h"
#import "b.h"

@implementation UIImageView (b)

- (void)addTappedImageViewOnceWithBlock:(void (^)(UIImageView *imageView))block {
    [self addTappedOnceWithBlock:^(UIView *v) {
        block((UIImageView *)v);
    }];
}

- (void)setImage:(UIImage *)image withRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rect);
    UIImage *image1 = [UIImage imageWithCGImage:imageRef];
    [self setImage:image1];
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
