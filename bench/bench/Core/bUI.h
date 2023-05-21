//
//  PandoraBoxUI.h
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RH(f) [bUI.shared relativeHeight:f]
#define PW(f) f * WIDTH() //宽度的几倍
#define PH(f) f * HEIGHT() //高度的几倍
#define RF(f) [bUI.shared relativeFont:f]
#define BRF(f) [bUI.shared relativeFont:@"Helvetica-Bold" fontSize:f]

#define X() [bUI.shared x]
#define Y() [bUI.shared y]
#define WIDTH() [bUI.shared width]
#define HEIGHT() [bUI.shared height]

@interface bUI : UIViewController

// Init base UI frame, default is 375/568 (iphone6)
// 初始化 必须放入ui图尺寸 整个app以后的效果图全部以这个为尺寸
@property (nonatomic, assign) float uiDemoWidth;
@property (nonatomic, assign) float uiDemoHeight;

// Default is 'RH(44)'
@property (nonatomic, assign) float uiNavBarHeight;
@property (nonatomic, assign) float uiTabBarHeight;

@property (nonatomic,retain) NSMutableArray *navArray;
@property (nonatomic,retain) UINavigationController *navController;

@property (nonatomic,retain) NSString *defaultFontName;//设置RF的默认字体

@property (nonatomic,retain) UIView *loadingView;
@property (nonatomic,retain) UILabel *loadingLabel;

@property (nonatomic, assign) float heightRate;

+ (instancetype)shared;

- (float)relativeHeight:(float)height;

- (UIFont *)relativeFont:(float)fontSize;
- (UIFont *)relativeFont:(NSString * _Nullable)fontName fontSize:(float)fontSize;

- (BOOL)isPhoneX;
- (void)makeHeightRate:(float)rate;
- (float)width;
- (float)height;
- (float)safeHeight;
- (float)safeBottom;
- (CGSize)screenSize;

- (UIWindow *)getLastWindow;
- (UIViewController *)currentUIViewController;

// 系统弹窗
- (void)showNormalAltWithMsg:(NSString *)msg block:(void (^)(int index, NSString *name))block;
// @param bts 按钮的title数组
- (void)showAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle))block;

// 系统弹窗
// @param bts 按钮的title数组
// @placeholder textField的placeholder
- (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle, NSString *text))block;

- (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholder:(NSString *_Nullable)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle, NSString *text))block textFieldBlock:(void(^_Nullable)(UITextField *_Nonnull textField))textFieldBlock;

- (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle, NSArray *texts))block;

- (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block2:(void (^)(int index, NSString *name, NSArray *texts, NSArray *textFields))block;

- (void)showNotice:(NSString *)noticeStr;
- (void)showNotice:(NSString *)noticeStr atView:(UIView *)view;

- (void)showLoading:(NSString *)noticeStr;
- (void)showCannotRemoveLoading:(NSString *)noticeStr;
- (void)stopLoading;

@end

NS_ASSUME_NONNULL_END
