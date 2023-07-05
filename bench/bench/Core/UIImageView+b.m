//
//  UIImageView+b.m
//  bench
//
//  Created by apple on 2023/7/5.
//

#import "UIImageView+b.h"

@implementation UIImageView (b)

- (void)setImage:(UIImage *)image withRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rect);
    UIImage *image1 = [UIImage imageWithCGImage:imageRef];
    [self setImage:image1];
}

- (void)setImage:(UIImage *)image withBenchPicecRect:(BenchPicecRect)benchPicecRect {
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
    
    CGRect rect = CGRectMake(pieceRow * row, pieceColum * colum, pieceRow, pieceColum);
    [self setImage:image withRect:rect];
}

@end
