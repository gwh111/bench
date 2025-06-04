//
//  p.h
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "bUI.h"

#import "UIView+b.h"
#import "UILabel+b.h"
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
#import "bShared.h"
#import "bPurchase.h"
#import "bEvent.h"
//#import "bHTML.h"

#ifdef DEBUG
#   define benchLog(fmt, ...) NSLog((@"benchLog %s   " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
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

//#define Bench [b shared]
/**
Profile time cost.
@param block     code to benchmark
@param complete  code time cost (millisecond)
 //内联函数从源代码层看，有函数的结构，而在编译后，却不具备函数的性质。内联函数不是在调用时发生控制转移，而是在编译时将函数体嵌入在每一个调用处。
 //主要是为了提高函数调用的效率。
 */
static inline void timeCost(void (^block)(void), void (^complete)(double ms)) {
    extern double CACurrentMediaTime (void);
    double begin, end, ms;
    begin = CACurrentMediaTime();
    block();
    end = CACurrentMediaTime();
    ms = (end - begin) * 1000.0;
    complete(ms);
}
//#import "bench-Swift.h"

@interface b : NSProxy

+ (void)test;

+ (bDataBaseStore *)database;

//+ (id)getDefault:(NSString *)key;
//+ (void)saveDefault:(NSString *)key value:(id)value;

//+ (NSDate *)appInstallDate;
+ (NSArray *)bundleFileNamesWithPath:(NSString *)name
                                type:(NSString *)type;
+ (NSArray *)bundleFilePathsWithPath:(NSString *)name
                                type:(NSString *)type;

+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name;
+ (BOOL)savePlistToSandbox:(id)data name:(NSString *)name;
+ (BOOL)saveDataToSandbox:(id)data name:(NSString *)name;
+ (void)removeSandboxFile:(NSString *)name;

//+ (NSString *)containForbiddenWords:(NSString *)text;

+ (bShared *)shared;
+ (bHttpTask *)httpTask;
+ (bTimer *)timer;
+ (bMusicBox *)music;
+ (bThread *)thread;
+ (bSort *)sort;

+ (bEvent *)event;

//UI
+ (bUI *)ui;
+ (void)setupRootWindow:(UIWindow *)window andRootViewController:(UIViewController *)vc;
+ (NSDictionary *)jsonWithString:(id)object;
//+ (NSDictionary *)jsonDicWithString:(id)object;
+ (NSArray *)jsonArrWithString:(id)object;
+ (NSString *)stringWithJson:(id)object;
+ (void)delay:(double)delayInSeconds block:(void (^)(void))block;
+ (void)gotoMain:(void (^)(void))block;
+ (void)gotoThread:(void (^)(void))block;
+ (void)showNotice:(NSString *)noticeStr;
+ (void)showNotice:(NSString *)noticeStr atView:(UIView *)view;
+ (void)showLoading:(NSString *)noticeStr;
+ (void)showCannotTapLoading:(NSString *)noticeStr;
+ (void)stopLoading;

+ (id)sandboxDocumentsStringWithPath:(NSString *)name;
+ (id)sandboxDocumentsPlistWithPath:(NSString *)name;

+ (id)documentsStringWithPath:(NSString *)name;
+ (id)documentsPlistWithPath:(NSString *)name;

+ (NSString *)bundleStringWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;

+ (NSString *)deviceSystemVersion;
+ (NSString *)deviceType;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
