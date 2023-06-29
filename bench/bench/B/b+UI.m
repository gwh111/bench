//
//  b+UI.m
//  bench
//
//  Created by gwh on 2023/6/24.
//

#import "b+UI.h"
#import "b+Sandbox.h"

@implementation b (UI)

+ (UIImage *)getAppPaperImage {
    NSString *name = @"appPaper";
    NSString *path = [NSString stringWithFormat:@"%@/%@",b.documentPath,name];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

+ (void)setAppPaperImage:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    NSString *name = @"appPaper";
    NSString *path = [NSString stringWithFormat:@"%@/%@",b.documentPath,name];
    [data writeToFile:path atomically:YES];
}

@end
