//
//  bHttpTask.m
//  bench
//
//  Created by gwh on 2022/6/10.
//

#import "bHttpTask.h"
#import "bHttpModel.h"
#import "b.h"

@interface bHttpTask() {
    
}

@property (nonatomic, assign) NSUInteger timeIndex;

@end

@implementation bHttpTask

- (void)getTime:(void(^)(NSString *date))block {
    
    NSArray *timeURLs = @[@"https://www.apple.com",@"https://www.baidu.com/",@"https://www.leancloud.cn/",@"https://www.youtube.com/"];
    NSString *timeUrl = timeURLs[_timeIndex];
    bHttpTask *task = bHttpTask.new;
    [task requestURL:timeUrl block:^(bHttpModel *result) {
        NSString *date = result.responseDate;
        NSLog(@"%@",result.resultStr);
        if (!date) {
            if (!result.resultStr) {
                [b showNotice:@"请连接网络再试~"];
                return;
            }
//            NSString *timeUrl = @"https://www.baidu.com/";
            [b delay:3 block:^{
                NSUInteger timeIndex = self.timeIndex;
                timeIndex++;
                if (timeIndex >= timeURLs.count) {
                    self.timeIndex = 0;
                }
                [self getTime:block];
            }];
            
            [b showNotice:@"请连接网络再试~"];
            return;
        }
        block( date);
    }];
}

- (void)requestURL:(NSString *)url block:(void(^)(bHttpModel *result))block {
    
    NSOperationQueue *httpQueue = [[NSOperationQueue alloc]init];
    httpQueue.maxConcurrentOperationCount = 5;
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:httpQueue];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    request.URL = [NSURL URLWithString:url];
//    NSData *data = [NSJSONSerialization dataWithJSONObject:nil options:NSJSONWritingPrettyPrinted error:nil];
//    request.HTTPBody = data;
    
    NSURLSessionDownloadTask *mytask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSString *dateStr = httpResponse.allHeaderFields[@"Date"];
        NSLog(@"date=%@",dateStr);
        NSString *resultStr = [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:&error];
        bHttpModel *model = bHttpModel.new;
        model.responseDate = dateStr;
        model.resultStr = resultStr;
        if (!resultStr) {
            NSLog(@"UTF8编码解析失败");
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            resultStr = [NSString stringWithContentsOfURL:location encoding:enc error:&error];
            if (resultStr) {
                NSLog(@"返回头是GBK编码");
            }
        }
        NSData *data = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableLeaves
                                              error:nil];
            model.responseDic = resultDic;
            
            [b gotoMain:^{
                block(model);
            }];
        } else {
            [b gotoMain:^{
                block(model);
            }];
        }
        
        
    }];
    [mytask resume];
}

@end
