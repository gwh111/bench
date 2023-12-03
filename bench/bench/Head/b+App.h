//
//  b+App.h
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (App)

+ (NSString *)appName;
+ (NSString *)bundleID;
+ (NSString *)sandboxDocPath;
+ (NSDictionary *)getDocument:(NSString *)name;
+ (void)saveDocument:(NSDictionary *)data name:(NSString *)name;
+ (NSString *)bundlePathWithName:(NSString *)name;

+ (id)benchDefaultObjectForKey:(NSString *)key;
+ (void)benchDefaultSetObject:(id)value forKey:(NSString *)key;

+ (id)benchDefaultObjectForKey:(NSString *)key fileName:(NSString *)fileName;
+ (void)benchDefaultSetObject:(id)value forKey:(NSString *)key fileName:(NSString *)fileName;

+ (void)launch;
+ (int)launchDayFromFirstDay;

+ (BOOL)requestIsInColdTime:(NSString *)key;
+ (void)requestColdTimeSet:(NSString *)key content:(NSDictionary *)content;
+ (NSDictionary *)requestCacheData:(NSString *)key;

+ (void)setKeychainObjectId:(NSString *)str;
+ (NSString *)getKeychainObjectId;

@end

NS_ASSUME_NONNULL_END
