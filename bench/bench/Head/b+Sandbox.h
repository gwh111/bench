//
//  b+Sandbox.h
//  bench
//
//  Created by gwh on 2023/4/16.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (Sandbox)

+ (NSString *)sandboxDocumentPath;
+ (void)sandboxMakeDocument:(NSString *)name;
+ (BOOL)sandboxIsExistFileAtPath:(NSString *)path;
+ (NSArray *)sandboxFilesAtPath:(NSString *)path;
+ (void)sandboxRemoveDocument:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
