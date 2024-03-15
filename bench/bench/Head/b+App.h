//
//  b+App.h
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (App)

+ (BOOL)isRated;
+ (void)isRatedSet:(BOOL)rated;

+ (BOOL)isCodeValided;
+ (void)isCodeValidedSet:(BOOL)rated;

+ (int)getAndInitCoin:(int)value;
+ (int)getCoin;
+ (void)setCoin:(int)value;

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

+ (BOOL)requestIsColding:(NSString *)key;
+ (void)requestColdTimeSet:(NSString *)key content:(nullable NSDictionary *)content;
+ (NSDictionary *)requestCacheData:(NSString *)key;

+ (void)requestListColdTimeSet:(NSString *)key content:(nullable NSArray *)content;
+ (NSArray *)requestListCacheData:(NSString *)key;

+ (void)setKeychainObjectId:(NSString *)str;
+ (NSString *)getKeychainObjectId;

@end

NS_ASSUME_NONNULL_END
