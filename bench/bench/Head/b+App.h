//
//  b+App.h
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (App)

+ (NSString *)bundleID;
+ (NSString *)sandboxDocPath;
+ (NSDictionary *)getDocument:(NSString *)name;
+ (void)saveDocument:(NSDictionary *)data name:(NSString *)name;
+ (NSString *)bundlePathWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
