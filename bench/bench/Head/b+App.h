//
//  b+App.h
//  bench
//
//  Created by apple on 2023/7/6.
//

#import "b.h"

NS_ASSUME_NONNULL_BEGIN

@interface b (App)

//+ (void)postNotification_rate;

+ (NSString *)getUserName;
+ (NSString *)getNickName;
+ (NSString *)getGender;
+ (void)setUserName:(NSString *)userName;
+ (void)setNickName:(NSString *)nickName;
+ (void)setGender:(NSString *)gender;

+ (BOOL)isRated;
+ (void)isRatedSet:(BOOL)rated;

+ (BOOL)isUnlockWithKey:(NSString *)key;
+ (void)isUnlockSet:(BOOL)unlock withKey:(NSString *)key;

+ (BOOL)isUnlockManyWithKey:(NSString *)key;
+ (void)isUnlockManySet:(BOOL)unlock withKey:(NSString *)key;

+ (void)setEverydayCount:(int)count withKey:(NSString *)key;
+ (void)addEverydayCount:(int)count withKey:(NSString *)key;
+ (int)getEverydayCountWithKey:(NSString *)key;

+ (void)setNPCInfoNPCName:(NSString *)npcName key:(NSString *)key value:(id)value;
+ (NSDictionary *)getNPCInfoWithNPCName:(NSString *)npcName;

+ (BOOL)isCodeValided;
+ (void)isCodeValidedSet:(BOOL)rated;

+ (int)getAndInitCoin:(int)value;
+ (int)getCoin;
+ (void)setCoin:(int)value;
+ (void)addCoin:(int)value;
+ (BOOL)checkCoinValue:(int)value;
+ (BOOL)checkGoldValue:(int)value;

+ (int)getAndInitGold:(int)value;
+ (int)getGold;
+ (void)setGold:(int)value;
+ (void)addGold:(int)value;

+ (NSString *)appName;
+ (NSString *)bundleID;
+ (NSString *)sandboxDocPath;
+ (NSDictionary *)getDictionary:(NSString *)name;
+ (void)saveDictionary:(NSDictionary *)data name:(NSString *)name;
+ (NSString *)bundlePathWithName:(NSString *)name;
+ (BOOL)BundleFileExistsInPath:(NSString *)fileName fileExtension:(NSString *)fileExtension;

+ (id)benchDefaultObjectForKey:(NSString *)key;
+ (void)benchDefaultRemoveObjectForKey:(NSString *)key;
+ (void)benchDefaultSetObject:(nullable id)value forKey:(NSString *)key;

+ (id)benchDefaultObjectForKey:(NSString *)key fileName:(NSString *)fileName;
+ (void)benchDefaultSetObject:(id)value forKey:(NSString *)key fileName:(NSString *)fileName;

+ (BOOL)isFirstLaunchKey:(NSString *)key;
+ (void)launchKey:(NSString *)key;
+ (BOOL)isFirstLaunch;
+ (void)launch;
+ (int)launchDayFromFirstDay;

+ (BOOL)requestIsColding:(NSString *)key;
+ (void)requestColdTimeSet:(NSString *)key content:(nullable NSDictionary *)content;
+ (NSDictionary *)requestCacheData:(NSString *)key;

+ (void)requestListColdTimeSet:(NSString *)key content:(nullable NSArray *)content;
+ (NSArray *)requestListCacheData:(NSString *)key;

+ (void)setKeychainObjectId:(NSString *)str;
+ (NSString *)getKeychainObjectId;

+ (void)rateAsk:(NSString *)msg copyDes:(NSString *)des appId:(NSString *)appId hasReward:(BOOL)hasReward;
+ (void)xhsAccount;
+ (void)xhsAccount:(NSString *)idtext;

+ (void)openAppStore:(NSString *)appId;

+ (int)getChargeTotalValue;
+ (int)getQucikChargeTotalValue;
+ (void)addQucikChargeTotalValue:(int)value;

+ (UIColor *)colorWithStar:(int)star;

+ (BOOL)hasSetKey:(NSString *)key;
+ (void)setKey:(NSString *)key;

+ (NSString *)getMemberExpire;
+ (BOOL)isMember;
+ (void)setMemberAddDays:(int)days;

@end

NS_ASSUME_NONNULL_END
