//
//  PurchaseView.h
//  NewWord
//
//  Created by gwh on 2017/11/12.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"



@protocol PurchaseRequest<NSObject>
- (void)uploadInAppP:(NSString *)textStr type:(NSString *)type choose:(int)choose;
@end


@interface bPurchase : UIView<SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
    
    NSString *fromString;
}
@property (nonatomic, assign) int chooseIndex;
@property (nonatomic, retain) NSDate *safeDate;
@property (nonatomic, retain) NSMutableArray *safeList;

@property (nonatomic, assign) int isLowPriceDay;

@property (nonatomic, strong) void(^successBlock)(int,int);

@property (nonatomic, retain) UIView *changePopView;

+ (instancetype)shared;

- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchaseProUpgrade;
//- (void)getRewardWithType:(int)type isCode:(BOOL)isCode;

//- (void)changePurchaseNames:(NSArray *)names contents:(NSArray *)contents successBlock:(void(^)(int type, int choose))block;
//- (void)recoverChange;


- (void)present;
- (void)presentWithId:(NSString *)bidStr names:(NSArray *)names dess:(NSArray *)dess block:(void(^)(NSString *result))finishBlock;
- (void)presentWithIds:(NSArray *)bidlist names:(NSArray *)names dess:(NSArray *)dess block:(void(^)(NSString *result))finishBlock;

- (void)addChargeTotalReward:(NSArray *)names prices:(NSArray *)prices block:(void(^)(int index))finishBlock;

@end
