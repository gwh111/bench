//
//  NSString+b.m
//  bench
//
//  Created by gwh on 2022/1/13.
//

#import "NSString+b.h"

@implementation NSString (b)

+ (void)setKeychainKey:(NSString *)key value:(NSString *)value {
    [self save:key data:value];
}

+ (NSString *)getKeychainKey:(NSString *)key
{
     NSString *strUUID = (NSString*)[self load:key];
    
    //首次执行该方法时，uuid为空
    if([strUUID isEqualToString:@""]|| !strUUID)
    {
//        //生成一个uuid的方法
//        strUUID = [NSUUID UUID].UUIDString;
//
//        //将该uuid保存到keychain
//        [KeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}

+ (void)setKeychainObjectId:(NSString *)str {
    [self save:@"com.gwh.objectId" data:str];
}

+ (NSString *)getKeychainObjectId
{
     NSString *strUUID = (NSString*)[self load:@"com.gwh.objectId"];
    
    //首次执行该方法时，uuid为空
    if([strUUID isEqualToString:@""]|| !strUUID)
    {
//        //生成一个uuid的方法
//        strUUID = [NSUUID UUID].UUIDString;
//
//        //将该uuid保存到keychain
//        [KeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}

+ (id)load:(NSString *)service {
    id ret =nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we areexpecting only a single attribute to be returned (the password) wecan set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if(SecItemCopyMatching((CFDictionaryRef)keychainQuery,(CFTypeRef*)&keyData) ==noErr){
        @try{
            ret =[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)keyData];
        }@catch(NSException *e) {
            NSLog(@"Unarchiveof %@ failed: %@",service, e);
        }@finally{
        }
    }
    if(keyData)
        CFRelease(keyData);
    return ret;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString*)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
           (id)kSecClassGenericPassword,(id)kSecClass,
           service,(id)kSecAttrService,
           service,(id)kSecAttrAccount,
           (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
           nil];
}


+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary*keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to searchdictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]forKey:(id)kSecValueData];
    //Add item to keychain with the searchdictionary
    SecItemAdd((CFDictionaryRef)keychainQuery,NULL);
}

+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary*keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

- (NSDate *)b_convertToDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"e, dd MM yyyy HH:mm:ss z"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    NSDate *resDate = [dateFormatter dateFromString:self];
    if (!resDate) {
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        resDate = [dateFormatter dateFromString:self];
    }
    if (!resDate) {
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        resDate = [dateFormatter dateFromString:self];
    }
    return resDate;
}

@end
