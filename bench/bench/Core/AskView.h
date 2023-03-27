//
//  AskView.h
//  RY
//
//  Created by gwh on 2022/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AskView : UIView

@property (nonatomic, retain) UITextView *askView;
@property (nonatomic, retain) id content;
@property (nonatomic, retain) NSString *cancelContent;
@property (nonatomic, retain) NSString *okContent;

@property (nonatomic, assign) int cannotClose;

@property (nonatomic, strong) void(^finishBlock)(BOOL);

+ (void)playAsk_cannotClose:(NSString *)content block:(void(^)(BOOL ok))block;

+ (void)playAsk:(NSString *)content block:(void(^)(BOOL ok))block;
+ (void)playAsk:(id)content okContent:(NSString *)okContent block:(void(^)(BOOL ok))block;
+ (void)playAsk:(id)content cancelContent:(NSString *)cancelContent okContent:(NSString *)okContent block:(void(^)(BOOL ok))block;

@end

NS_ASSUME_NONNULL_END
