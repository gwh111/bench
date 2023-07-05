//
//  UIImageView+b.h
//  bench
//
//  Created by apple on 2023/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

struct BenchPicecRect {
    int row;
    int totalRow;
    int colum;
    int totalColum;
};
typedef struct CF_BOXABLE BenchPicecRect BenchPicecRect;

CG_INLINE BenchPicecRect
BenchPicecRectMake(int row, int totalRow, int colum, int totalColum)
{
  BenchPicecRect rect;
  rect.row = row; rect.totalRow = totalRow;
  rect.colum = colum; rect.totalColum = totalColum;
  return rect;
}

@interface UIImageView (b)

- (void)setImage:(UIImage *)image withRect:(CGRect)rect;
- (void)setImage:(UIImage *)image withBenchPicecRect:(BenchPicecRect)benchPicecRect;

@end

NS_ASSUME_NONNULL_END
