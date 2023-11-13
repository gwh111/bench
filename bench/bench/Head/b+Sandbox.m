//
//  b+Sandbox.m
//  bench
//
//  Created by gwh on 2023/4/16.
//

#import "b+Sandbox.h"

@implementation b (Sandbox)

+ (NSString *)documentPath {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return doc;
}

@end
