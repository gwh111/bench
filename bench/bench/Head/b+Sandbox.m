//
//  b+Sandbox.m
//  bench
//
//  Created by gwh on 2023/4/16.
//

#import "b+Sandbox.h"

@implementation b (Sandbox)

+ (NSString *)sandboxDocumentPath {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return doc;
}

+ (void)sandboxMakeDocument:(NSString *)name {
    NSString *filePath = [self.sandboxDocumentPath stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)sandboxIsExistFileAtPath:(NSString *)path {
    NSString *filePath = [self.sandboxDocumentPath stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    return existed;
}

+ (NSArray *)sandboxFilesAtPath:(NSString *)path {
    NSString *filePath = [self.sandboxDocumentPath stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 取得一个目录下得所有文件名
    NSArray *files = [fileManager subpathsAtPath:filePath];
    return files;
}

+ (void)sandboxRemoveDocument:(NSString *)name {
    NSString *filePath = [self.sandboxDocumentPath stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

@end
