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

/**
Profile time cost.
@param block     code to benchmark
@param complete  code time cost (millisecond)
 //内联函数从源代码层看，有函数的结构，而在编译后，却不具备函数的性质。内联函数不是在调用时发生控制转移，而是在编译时将函数体嵌入在每一个调用处。
 //主要是为了提高函数调用的效率。
 */
//static inline void timeCost(void (^block)(void), void (^complete)(double ms)) {
//    extern double CACurrentMediaTime (void);
//    double begin, end, ms;
//    begin = CACurrentMediaTime();
//    block();
//    end = CACurrentMediaTime();
//    ms = (end - begin) * 1000.0;
//    complete(ms);
//}

- (NSString *)version;
- (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2;
- (NSString *)randomString:(NSInteger)number;
- (NSString *)textChinese:(NSString *)ch andEnglish:(NSString *)eng;
- (NSArray *)textChineseList:(NSArray *)chList andEnglishList:(NSArray *)engList;

+ (NSString *)appID;
+ (NSString *)appName;
+ (id)jsonWithString:(NSString *)jsonString;
+ (NSString *)stringWithJson:(id)object;

+ (void)delay:(double)delayInSeconds block:(void (^)(void))block;
+ (id)getDefault:(NSString *)key;
+ (void)saveDefault:(NSString *)key value:(id)value;
+ (NSDate *)getAppInstallDate;

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name
                                type:(NSString *)type;
+ (NSString *)bundleStringWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;
+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name;
+ (BOOL)saveDataToSandbox:(id)data name:(NSString *)name;
+ (void)removeSandboxFile:(NSString *)name;

+ (id)documentsStringWithPath:(NSString *)name;
+ (NSDictionary *)documentsPlistWithPath:(NSString *)name;

- (void)addSharedKey:(NSString *)key object:(id)object;
- (id)getSharedKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
