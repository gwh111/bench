//
//  PurchaseView.m
//  NewWord
//
//  Created by gwh on 2017/11/12.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import "bPurchase.h"
//#import "PKFinishView.h"
#import "bench.h"

@interface bPurchase ()<PurchaseRequest>{
    BOOL portarit;
    int fail;
    
    NSString *bidStr;
    NSString *kInAppPurchaseProUpgradeProductId;
    
    UITextView *infoL;
    NSUInteger purchaseIndex;
    
    UIView *loadingV;
    UIImageView *loading;
    
    UITextView *subInfoT;
    
    int rand;
    
    UIButton *exampleBt;
    
    NSMutableArray *superArr;
    NSMutableArray *desArr;
}

@end

@interface bPurchase() {
    UIView *popV;
}

typedef void (^finishBlock)(NSString *result);

@property (nonatomic, strong) finishBlock fBlock;
@property (nonatomic, retain) NSString *spNumber;
@property (nonatomic, retain) NSString *spName;

@property (nonatomic, retain) NSArray *chooseNames;

@end

@implementation bPurchase

static bPurchase *userManager = nil;
static dispatch_once_t onceToken;

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[bPurchase alloc]init];
    });
    return userManager;
}

- (void)recoverChange {
    
    _successBlock = nil;
    _changePopView.hidden = YES;
}

- (void)present {
    self.alpha = 1;
}

- (void)dismiss {
    
    [b stopLoading];
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = RGBA(0, 0, 0, .5);
        self.frame = CGRectMake(0, 0, WIDTH(), HEIGHT());
        self.alpha = 0;
        [UIView animateWithDuration:.5f animations:^{
            self.alpha=1;
        } completion:^(BOOL finished) {
            
        }];
        
        float h = RH(250);
        popV = UIView.new;
        popV.frame = CGRectMake(0, HEIGHT() - h, WIDTH(), h);
        [self addSubview:popV];
        popV.backgroundColor = UIColor.blackColor;
        
        UIButton *close = UIButton.new;
        close.frame = CGRectMake(0, 0, WIDTH(), popV.top);
        [self addSubview:close];
        [close addTappedOnceWithBlock:^(UIView * v) {
            [self dismiss];
        }];
        
    }
    return self;
}

- (void)presentWithId:(NSString *)bidStr names:(NSArray *)names dess:(NSArray *)dess block:(void(^)(NSString *result))finishBlock {
    purchaseIndex = 1;
    
    _fBlock = finishBlock;
    
//    bidStr = @"com.gwh.note.pro";
    self->bidStr = bidStr;
    
    self->kInAppPurchaseProUpgradeProductId = [NSString stringWithFormat:@"%@1",bidStr];
    
    self->superArr = [[NSMutableArray alloc]initWithArray:names];

    self->desArr = [[NSMutableArray alloc]initWithArray:dess];
    
    for (int i = 0; i < superArr.count; i++) {
        
        NSString *name = superArr[i];
        
        UIButton *button = UIButton.new;
        button.frame = CGRectMake(WIDTH()/2 - RH(50), RH(10), RH(80), RH(40));
        [button setTitle:superArr[i] forState:UIControlStateNormal];
        button.b_normalColor = UIColor.whiteColor;
        button.backgroundColor = RGBA(44, 44, 44, 1);
        button.layer.cornerRadius = 6;
        button.name = name;
        button.titleLabel.font = BRF(16);
        [popV addSubview:button];
        button.left = RH(10)+RH(90)*i;
        
        [button addTappedOnceWithBlock:^(UIView *v) {
            
            self->infoL.text = self->desArr[i];
            int index = i;
            self->kInAppPurchaseProUpgradeProductId = [NSString stringWithFormat:@"%@%d",self->bidStr,index+1];
            
        }];
    }
    
    infoL = UITextView.new;
    infoL.frame = CGRectMake(RH(10), RH(60), WIDTH() - RH(20), RH(130));
    infoL.textAlignment = NSTextAlignmentLeft;
    infoL.textColor = [UIColor whiteColor];
    infoL.text = desArr[0];
    infoL.font = RF(16);
    [popV addSubview:infoL];
    infoL.editable = NO;
    infoL.selectable = NO;
    infoL.backgroundColor = [UIColor clearColor];
    
    {
        UILabel *label = UILabel.new;
        [popV addSubview:label];
        label.size = CGSizeMake(WIDTH()/2-RH(60), RH(40));
        label.left = RH(10);
        label.top = RH(180);
        label.font = RF(12);
        label.textColor = UIColor.grayColor;
        label.backgroundColor = UIColor.clearColor;
        label.text = @"充值遇到问题可到首页提交问题反馈。";
        label.numberOfLines = 2;
    }
    
    
    UIButton *button = UIButton.new;
    button.frame = CGRectMake(WIDTH()/2 - RH(50), RH(180), RH(100), RH(40));
    [button setTitle:TEXT_CH_EN(@"购买", @"Purchase") forState:UIControlStateNormal];
    button.titleLabel.textColor = UIColor.b_lightYellow;
    button.backgroundColor = RGBA(44, 44, 44, 1);
    button.layer.cornerRadius = 6;
    button.tag = 10;
    button.titleLabel.font = BRF(16);
    [popV addSubview:button];
    [button addTappedOnceWithBlock:^(UIView * v) {
        [self buyAsk];
    }];
}

- (void)buyAsk {
    if (_chooseNames.count > 0) {
        [b.ui showAltOn:b.ui.currentUIViewController title:@"选择" msg:@"选择一个品种。" bts:_chooseNames block:^(int index, NSString * _Nonnull indexTitle) {
            if ([indexTitle isEqualToString:@"取消"]) {
                return;
            }
            self.chooseIndex = index;
            [self buy];
        }];
    } else {
        [self buy];
    }
}

- (void)buy {
    [b showCannotTapLoading:@"请求中，请等待1-10秒"];
    if ([self canMakePurchases]) {
        [self loadStore];
    } else {
        [b showNotice:@"!canMakePurchases"];
    }
}

#pragma mark- neigou
- (void)loadStore {
    // restarts any purchases if they were interrupted last time the app was open
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // get the product description (defined in early sections)
    [self requestProUpgradeProductData];
}

- (BOOL)canMakePurchases {
    return [SKPaymentQueue canMakePayments];
}

- (void)purchaseProUpgrade {
    {
        fail=0;
        SKMutablePayment *_payment = [SKMutablePayment paymentWithProduct:proUpgradeProduct];
        rand=arc4random()%10000+10000;
        _payment.applicationUsername = kInAppPurchaseProUpgradeProductId;
        [[SKPaymentQueue defaultQueue] addPayment:_payment];
    }
//    SKPayment *payment = [SKPayment paymentWithProductIdentifier:kInAppPurchaseProUpgradeProductId];
//    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    NSLog(@"Observer dealloc");
}

#pragma -
#pragma Purchase helpers
//
// saves a record of the transaction by storing the receipt to disk
//
- (void)recordTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"requestProUpgradeProductData1");
    if ([transaction.payment.productIdentifier isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"proUpgradeTransactionReceipt" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//
// enable pro features
//
- (void)provideContent:(NSString *)productId {
    NSLog(@"requestProUpgradeProductData2");
    if ([productId isEqualToString:kInAppPurchaseProUpgradeProductId]) {
        // enable the pro features
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUpgradePurchased" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (int)getChooseValue {
    int v = _chooseIndex;
    if (_successBlock) {
        v = v+100;
    }
    return v;
}
//
// removes the transaction from the queue and posts a notification with the transaction result
//
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful {
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSString *appN = transaction.payment.applicationUsername;
    if ([appN intValue] == rand || appN.length == 0) {
        
    }
    
    [b showCannotTapLoading:@"礼包获取中，请稍后~"];
//    [a playTalks:@[@"礼包获取中，请稍后~"] block:^{
//
//    }];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction, @"transaction" , nil];
    if (wasSuccessful) {
        // send out a notification that we’ve finished the transaction
        NSLog(@"succ");

        if (!_safeList) {
            _safeList = NSMutableArray.new;
        }
        
        [self uploadInAppP:[NSString stringWithFormat:@"finishTransaction%d %@",_chooseIndex,transaction.transactionIdentifier] type:appN choose:self.getChooseValue];

        [self successVerify:userInfo];
        
        
    } else {
        // send out a notification for the failed transaction
        NSLog(@"fail");
        [b showNotice:[NSString stringWithFormat:@"fail  %@",transaction.error]];
        [b stopLoading];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
}

- (void)successVerify:(NSDictionary *)userInfo {
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    if (!receiptData) {
        return;
    }
    //In the test environment, use https://sandbox.itunes.apple.com/verifyReceipt
    //In the real environment, use https://buy.itunes.apple.com/verifyReceipt
    NSDictionary *requestContents = @{@"receipt-data": [receiptData base64EncodedStringWithOptions:0]};
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:nil];
    NSURL *storeURL = [NSURL URLWithString:@"https://buy.itunes.apple.com/verifyReceipt"];
#if DEBUG
    storeURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
#endif
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error || !data) {
            [self successVerify:userInfo];
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        if (!dict[@"status"]) {
            [self successVerify:userInfo];
            return;
        }
        //                CCLOG(@"%@",dict);
        if ([dict[@"status"]intValue] == 0) {
            
            [self purchaseFinish:data userInfo:userInfo];
        } else {
            NSURL *storeURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
            
            NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
            [storeRequest setHTTPMethod:@"POST"];
            [storeRequest setHTTPBody:requestData];
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                if (error == nil) {
                    
                    [self purchaseFinish:data userInfo:userInfo];
                } else {
                    [b stopLoading];
                }
            }];
            [dataTask resume];
        }
    }];
    [dataTask resume];
}

- (void)purchaseFinish:(NSData *)data userInfo:(NSDictionary *)userInfo {
    [b gotoMain:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //                CCLOG(@"%@",dict);
        
        if (dict[@"status"]) {
            [self uploadInAppP:[b stringWithJson:dict] type:self->kInAppPurchaseProUpgradeProductId choose:self.getChooseValue];
            
            NSArray *inapp = dict[@"receipt"][@"in_app"];
            if (inapp.count <= 0) {
                
            } else if ([dict[@"status"]intValue] == 0) {
                NSLog(@"succ");
//                NSDictionary *data = inapp.firstObject;
//                NSString *product_id = data[@"product_id"];
                NSString *receipt_creation_date_ms = [NSString stringWithFormat:@"%@",dict[@"receipt"][@"receipt_creation_date_ms"]];
                if (receipt_creation_date_ms.length < 1) {
//                    [a setCannotUseLevel:@"1"];
                    exit(0);
                    return;
                }
//                for (int i = 0; i < _safeList.count; i++) {
//                    NSString *find = _safeList[i];
//                    if ([find isEqualToString:receipt_creation_date_ms]) {
////                        [a setCannotUseLevel:@"1"];
////                        exit(0);
//                        [self dismiss];
//                        return;
//                    }
//                }
//                [_safeList addObject:receipt_creation_date_ms];
//                NSLog(@"_safeList%d",(int)_safeList.count);
                [b stopLoading];
                
                if (self->_fBlock) {
                    self->_fBlock(self->kInAppPurchaseProUpgradeProductId);
                }
//                int type = 0;
//                if ([self->kInAppPurchaseProUpgradeProductId hasSuffix:@"1"]) {
//                    type = 1;
////                    [self getRewardWithType:type isCode:NO];
//                    [App cutCoin:-100];
////                    [b showNotice:@"获取100币~"];
//                }
//                else if ([self->kInAppPurchaseProUpgradeProductId hasSuffix:@"2"]) {
//                    type = 2;
//                    [self getRewardWithType:type isCode:NO];
//
//                } else if ([self->kInAppPurchaseProUpgradeProductId hasSuffix:@"4"]) {
//                    type = 4;
//                    [self getRewardWithType:type isCode:NO];
//                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
                [self dismiss];
            }
            return;
        }
        NSString *content;
        if (dict) {
            content = [NSString stringWithFormat:@"%@",dict];
        } else {
            content = @"验证失败";
        }
        [b.ui showAltOn:b.ui.currentUIViewController title:@"提示" msg:content bts:@[@"ok"] block:^(int index, NSString * _Nonnull indexTitle) {
                        
        }];
        [self uploadInAppP:content type:self->kInAppPurchaseProUpgradeProductId choose:self.getChooseValue];
        [b stopLoading];
    }];
}
//
// called when the transaction was successful
//
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}
//
// called when a transaction has been restored and and successfully completed
//
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    [self recordTransaction:transaction.originalTransaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}
//
// called when a transaction has failed
//
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"transaction.error=%@",transaction.error);
    
    if (transaction.error.code != SKErrorPaymentCancelled) {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    } else {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];

        [b showNotice:@"cancel"];
        
        [b stopLoading];
    }
}
#pragma mark -
#pragma mark SKPaymentTransactionObserver methods
//
// called when the transaction status is updated
//
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default: {
                [b showNotice:[NSString stringWithFormat:@"updatedTransactions%ld",(long)transaction.transactionState]];
            }
                break;
        }
    }
}

//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------弹出错误信息----------");

    [b gotoMain:^{
        [b showNotice:error.localizedDescription];
//        [a playTalks:@[error.localizedDescription] block:^{
//                
//        }];
        [b stopLoading];
    }];
}

-(void) requestDidFinish:(SKRequest *)request {
    NSLog(@"----------反馈信息结束--------------");
    
}

- (void)requestProUpgradeProductData {
    NSLog(@"requestProUpgradeProductData");
    NSSet *productIdentifiers = [NSSet setWithObject:kInAppPurchaseProUpgradeProductId ];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    _safeDate = NSDate.b_localDate;
    [self uploadInAppP:@"want" type:kInAppPurchaseProUpgradeProductId choose:self.getChooseValue];
    // we will release the request object in the delegate callback
}

- (void)uploadInAppP:(NSString *)textStr type:(NSString *)type choose:(int)choose {
    
}

#pragma mark -
#pragma mark SKProductsRequestDelegate methods
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    proUpgradeProduct = [products count] == 1 ? [products firstObject]  : nil;
    if (proUpgradeProduct) {
//        CCLOG(@"Product title: %@" , proUpgradeProduct.localizedTitle);
//        CCLOG(@"Product description: %@" , proUpgradeProduct.localizedDescription);
//        CCLOG(@"Product price: %@" , proUpgradeProduct.price);
//        CCLOG(@"Product id: %@" , proUpgradeProduct.productIdentifier);
        //@"查询成功，购买中，请稍后！"
        
        [self purchaseProUpgrade];
    }else{
//        [ccs showNotice:@"fail"];
//        [ccs maskStop];
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers) {
        NSLog(@"Invalid product id: %@" , invalidProductId);
        
        [b gotoMain:^{
            [b showNotice:[NSString stringWithFormat:@"Invalid product id"]];
//            [a playTalks:@[[NSString stringWithFormat:@"Invalid product id"]] block:^{
//                    
//            }];
        }];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
    
}

//- (void)record:(int)type {
//    NSString *key = [NSString stringWithFormat:@"pro%d_%d",type,0];
//
//    if (![b getDefault:key]) {
//        [b saveDefault:key value:@"0"];
//    }
//    int i = [[b getDefault:key] intValue];
//    i = i + 1;
//    [b saveDefault:key value:@(i)];
//}

@end
