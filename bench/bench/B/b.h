//
//  p.h
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "bPlug.h"

#import "bBase.h"
#import "bUI.h"

#import "UIView+b.h"
#import "UIImage+b.h"
#import "UIImageView+b.h"
#import "UIButton+b.h"
#import "NSAttributedString+b.h"
#import "NSDictionary+b.h"
#import "UIViewController+b.h"
#import "NSDate+b.h"
#import "UIColor+b.h"
#import "NSObject+b.h"
#import "bDataBaseStore.h"
#import "bHttpTask.h"
#import "bTimer.h"
#import "NSString+b.h"
#import "bMusicBox.h"
#import "bMD5.h"
#import "bStrokeLabel.h"
#import "bAnimationPlay.h"
#import "bSort.h"
#import "bVideo.h"
//#import "bHTML.h"

#ifdef DEBUG
#   define benchLog(fmt, ...) NSLog((@"benchLog:%s" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#   define benchLog(...)
#endif

#ifdef DEBUG
#   define benchLogDetail(fmt, ...) NSLog((@"benchLogDetail:%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define benchLogDetail(...)
#endif

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;
#define WO(weakObject) __weak typeof(weakObject) weakObject##Weak = weakObject;
#define SO(strongObject) __strong typeof(strongObject) strongObject##Weak = strongObject;



//#import "bench-Swift.h"

@interface b : NSProxy

+ (void)test;

//BASE
+ (bBase *)base;

+ (bDataBaseStore *)database;

+ (id)getDefault:(NSString *)key;
+ (void)saveDefault:(NSString *)key value:(id)value;

+ (NSDate *)appInstallDate;
+ (NSArray *)bundleFileNamesWithPath:(NSString *)name
                                type:(NSString *)type;
+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name;
+ (BOOL)saveDataToSandbox:(id)data name:(NSString *)name;
+ (void)removeSandboxFile:(NSString *)name;

//+ (NSString *)containForbiddenWords:(NSString *)text;

+ (bHttpTask *)httpTask;
+ (bTimer *)timer;
+ (bMusicBox *)music;
+ (bThread *)thread;
+ (bSort *)sort;

//UI
+ (bUI *)ui;
+ (void)setupRootWindow:(UIWindow *)window andRootViewController:(UIViewController *)vc;
+ (NSDictionary *)jsonWithString:(id)object;
+ (NSString *)stringWithJson:(id)object;
+ (void)delay:(double)delayInSeconds block:(void (^)(void))block;
+ (void)gotoMain:(void (^)(void))block;
+ (void)gotoThread:(void (^)(void))block;
+ (void)showNotice:(NSString *)noticeStr;
+ (void)showNotice:(NSString *)noticeStr atView:(UIView *)view;
+ (void)showLoading:(NSString *)noticeStr;
+ (void)showCannotTapLoading:(NSString *)noticeStr;
+ (void)stopLoading;

+ (id)documentsStringWithPath:(NSString *)name;
+ (NSDictionary *)documentsPlistWithPath:(NSString *)name;
+ (NSString *)bundleStringWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
