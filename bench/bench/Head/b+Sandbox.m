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
//    NSArray *files = [fileManager subpathsAtPath:filePath];
    NSArray *files = [fileManager contentsOfDirectoryAtPath:filePath error:nil];
    return files;
}

+ (void)sandboxRemoveDocument:(NSString *)name {
    NSString *filePath = [self.sandboxDocumentPath stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

+ (void)sandboxRenameDocument:(NSString *)name newName:(NSString *)newName {
    NSString *filePath = [self.sandboxDocumentPath stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePathNew = [self.sandboxDocumentPath stringByAppendingPathComponent:newName];
//    [fileManager createDirectoryAtPath:filePathNew withIntermediateDirectories:YES attributes:nil error:nil];
    NSError *error;
    [fileManager moveItemAtPath:filePath toPath:filePathNew error:&error];
    if (error) {
        NSLog(@"moveItemAtPath error: %@",error);
    }
    [fileManager removeItemAtPath:filePath error:nil];
}

+ (void)sandboxWriteImage:(UIImage *)image jpgCompressRate:(float)rate toPath:(NSString *)path {
    NSString *filePath = [self.sandboxDocumentPath stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = UIImageJPEGRepresentation(image, rate);
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
}

+ (UIImage *)sandboxImageWithPath:(NSString *)path {
    if (!path) return nil;
    //读取本地沙盒中的数据
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",path]];
    //判断路径是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:filePath];
        return image;
    }
//    NSLog(@"no such file '%@'",name);
    return nil;
}

@end
