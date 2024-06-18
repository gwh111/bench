//
//  AnimationPlay.m
//  NewWord
//
//  Created by gwh on 2018/3/12.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import "bAnimationPlay.h"
#import "b.h"

@implementation bAnimationPlay

+ (void)playAtView:(UIView *)view aniPath:(NSString *)path fromIndex:(int)index frame:(CGRect)frame reverse:(int)reverse{
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.frame=frame;
    [view addSubview:imageV];
    imageV.contentMode=UIViewContentModeScaleAspectFit;
    if (reverse) {
        imageV.transform = CGAffineTransformMakeScale(-1, 1);
    }
    
    [b.thread gotoThread:^{
        NSMutableArray *imgMutArr=[[NSMutableArray alloc]init];
        for (int i=index; i<30; i++) {
            NSString *imgN=[NSString stringWithFormat:@"%@%d.png",path,i];
            if (imgN) {
                UIImage *img=[UIImage imageNamed:imgN];
                if (img) {
                    [imgMutArr addObject:img];
                }
            }else{
                break;
            }
        }
        
        [b.thread gotoMain:^{
            
            if (imgMutArr.count<=0) {
                NSLog(@"imgMutArr等于0");
                return;
            }
            
            float dur=imgMutArr.count*.1;
            imageV.animationImages=imgMutArr;
            imageV.animationRepeatCount=0;
            imageV.animationDuration=dur;//执行一次完整动画所需的时长
            [imageV startAnimating];
            
            double delayInSeconds = dur-.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [imageV stopAnimating];
                [imageV removeFromSuperview];
            });
        }];
    }];
    
    
}

+ (void)playAtView:(UIView *)view aniPath:(NSString *)path fromIndex:(int)index alpha:(float)alpha reverse:(int)reverse{
    UIImageView *imageV=[[UIImageView alloc]init];
    imageV.frame=CGRectMake(0, 0, view.width, view.height);
    imageV.center = CGPointMake(view.width/2, view.height/2);
    [view addSubview:imageV];
    imageV.contentMode=UIViewContentModeScaleAspectFit;
    imageV.alpha=alpha;
    if (reverse) {
        imageV.transform = CGAffineTransformMakeScale(-1, 1);
    }
    
    NSMutableArray *imgMutArr=[[NSMutableArray alloc]init];
    for (int i=index; i<30; i++) {
        NSString *imgN=[NSString stringWithFormat:@"%@/%d.png",path,i];
        if (imgN) {
            UIImage *img=[UIImage imageNamed:imgN];
            if (img) {
                [imgMutArr addObject:img];
            }
        }else{
            break;
        }
    }
    
    if (imgMutArr.count<=0) {
        NSLog(@"imgMutArr等于0");
        return;
    }
    
    float dur=imgMutArr.count*.1;
    imageV.animationImages=imgMutArr;
    imageV.animationRepeatCount=1;
    imageV.animationDuration=dur;//执行一次完整动画所需的时长
    [imageV startAnimating];
    
    double delayInSeconds = dur;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [imageV stopAnimating];
        [imageV removeFromSuperview];
    });
}

@end
