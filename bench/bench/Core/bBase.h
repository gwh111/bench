//
//  PandoraBase.h
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bBase : NSObject

@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSMutableDictionary *sharedData;

+ (instancetype)shared;

- (NSString *)version;
- (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2;
- (NSString *)randomString:(NSInteger)number;
- (NSString *)textChinese:(NSString *)ch andEnglish:(NSString *)eng;
- (NSArray *)textChineseList:(NSArray *)chList andEnglishList:(NSArray *)engList;

+ (NSString *)appName;
+ (id)jsonWithString:(NSString *)jsonString;
+ (NSString *)stringWithJson:(id)object;

+ (void)delay:(double)delayInSeconds block:(void (^)(void))block;
//+ (id)getDefault:(NSString *)key;
//+ (void)saveDefault:(NSString *)key value:(id)value;
//+ (NSDate *)getAppInstallDate;

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name
                                type:(NSString *)type;
+ (NSArray *)bundleFilePathsWithPath:(NSString *)name
                                type:(NSString *)type;

+ (NSString *)bundleStringWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;
+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name;
+ (BOOL)saveDataToSandbox:(id)data name:(NSString *)name;
+ (void)removeSandboxFile:(NSString *)name;

+ (id)documentsStringWithPath:(NSString *)name;
+ (NSDictionary *)documentsPlistWithPath:(NSString *)name;


@end

NS_ASSUME_NONNULL_END
