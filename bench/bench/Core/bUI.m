//
//  PandoraBoxUI.m
//  PandoraBox
//
//  Created by gwh on 2022/1/6.
//

#import "bUI.h"
#import "b.h"

@interface bUI () <UIApplicationDelegate>

@property (nonatomic,retain) NSMutableDictionary *groupButtons;
@property (nonatomic,assign) CGFloat _safeTop;
@property (nonatomic,assign) CGFloat _safeBottom;

@end

static bUI *userManager = nil;
static dispatch_once_t onceToken;

@implementation bUI

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

+ (void)load {
    bUI.shared.uiDemoWidth = 375;
    bUI.shared.uiDemoHeight = 568;
}

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[bUI alloc]init];
    });
    return userManager;
}

- (void)group_addButton:(UIButton *)button key:(NSString *)key {
    if (!_groupButtons) {
        _groupButtons = NSMutableDictionary.new;
    }
    NSMutableArray *list = _groupButtons[key];
    if (!list) {
        list = NSMutableArray.new;
    }
    [list addObject:button];
    [_groupButtons setObject:list forKey:key];
}

- (void)group_updateButton:(UIButton *)button key:(NSString *)key
               titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor
 highlightTitleColor:(UIColor *)highlightTitleColor hilightBackgroundColor:(UIColor *)hilightBackgroundColor {
    
    NSMutableArray *list = _groupButtons[key];
    for (int i = 0; i < list.count; i++) {
        UIButton *button = list[i];
        button.backgroundColor = backgroundColor;
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    button.backgroundColor = hilightBackgroundColor;
    [button setTitleColor:highlightTitleColor forState:UIControlStateNormal];
}

- (UIFont *)relativeFont:(float)fontSize {
    return [self relativeFont:_defaultFontName fontSize:fontSize];
}

- (UIFont *)relativeFont:(NSString * _Nullable)fontName fontSize:(float)fontSize {
    if (WIDTH() < 375) {
        fontSize = fontSize - 2;
    }else if (WIDTH() == 375) {
        fontSize = fontSize;
    }else{
        float rate = [self width]/_uiDemoWidth;
        if (self.width > self.height) {
            rate = [self height]/_uiDemoWidth;
        }
        if (fontSize <= 10) {
            fontSize = fontSize * rate;
            return [UIFont fontWithName:fontName size:fontSize];
        }
        fontSize = 10 + (fontSize - 10) * rate;
    }
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}

- (float)relativeHeight:(float)height {
    if (self.width > self.height) {
        return (int)(height * [self height]/_uiDemoWidth);
    }
    return (int)(height * [self width]/_uiDemoWidth);
}

- (float)statusBarHeight {
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    if (statusRect.size.height == 0) {
        return self.isPhoneX ? 44 : 20;
    }
    return statusRect.size.height;
}

- (CGRect)screenRect {
    return CGRectMake(0, 0, WIDTH(), HEIGHT());
}

- (float)x {
    return 0;
}

- (float)y {
    return [self statusBarHeight];
}

- (float)width {
    float h = [UIScreen mainScreen].bounds.size.height;
    float w = [UIScreen mainScreen].bounds.size.width;
    if (_fixWidthAndHeight) {
        return w;
    }
    if (h > w) {
        return w;
    }
    return h;
}

- (float)height {
    if (_heightRate > 0) {
        return self.width*_heightRate;
    }
    float h = [UIScreen mainScreen].bounds.size.height;
    if (_fixWidthAndHeight) {
        return h;
    }
    float w = [UIScreen mainScreen].bounds.size.width;
    if (h < w) {
        return w;
    }
    return h;
}

- (void)makeHeightRate:(float)rate {
    _heightRate = rate;
}

- (float)safeLeft {
    float v = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.left;
    return v;
}

- (float)safeRight {
    float v = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.right;
    return v;
}

- (float)safeTop {
    if (__safeTop > 0) {
        return __safeTop;
    }
    float v = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.top;
    float v3 = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom;
    if (v3 > v) {
        __safeTop = v3;
    }
    __safeTop = v;
    return __safeTop;
}

- (float)safeBottom {
    if (__safeBottom > 0) {
        return __safeBottom;
    }
    float v = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom;
    __safeBottom = v;
    return __safeBottom;
}

- (float)safeWidth {
    float v = self.width-self.safeLeft-self.safeRight;
    return v;
}

- (float)safeHeight {
    float v = self.height-self.safeTop-self.safeBottom;
    return v;
}

- (CGSize)screenSize {
    return CGSizeMake(WIDTH(), HEIGHT());
}

- (BOOL)isPhoneX {
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom > 0.0;
    } else {
        // Fallback on earlier versions
    }
    return isPhoneX;
}

- (UIWindow *)getLastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&window.hidden == NO){
            return window;
        }
    }
    return [UIApplication sharedApplication].windows.firstObject;
}

- (UIViewController *)currentUIViewController {
    return _navArray.lastObject;
}

- (BOOL)isDarkMode {
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
            return YES;
        } else if (mode == UIUserInterfaceStyleLight) {
            
        }
    }
    return NO;
}

- (void)showNormalAltWithMsg:(NSString *)msg block:(void (^)(int index, NSString *name))block {
    [self showAltOn:b.ui.currentUIViewController title:@"提示" msg:msg bts:@[@"确定"] block:block];
}

- (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < bts.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            block(i,bts[i]);
        }]];
    }
    [controller presentViewController:alertController animated:NO completion:nil];
}

- (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block2:(void (^)(int index, NSString *name, NSArray *texts, NSArray *textFields))block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    NSMutableArray *textFields = NSMutableArray.new;
    for (int i = 0; i < placeholders.count; i++) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
            textField.placeholder = placeholders[i];
            [textFields addObject:textField];
        }];
    }
    block(-1,@"",@[],@[]);
    for (int i = 0; i < bts.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            NSMutableArray *texts = [[NSMutableArray alloc]init];
            NSArray *textFields = alertController.textFields;
            for (int i = 0; i < textFields.count; i++) {
                [texts addObject:alertController.textFields[i].text?alertController.textFields[i].text:@""];
            }
            block(i,bts[i],texts,textFields);
        }]];
    }
    [controller presentViewController:alertController animated:NO completion:nil];
}

- (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSArray *texts))block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < placeholders.count; i++) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
            textField.placeholder = placeholders[i];
        }];
    }
    for (int i = 0; i < bts.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            NSMutableArray *texts = [[NSMutableArray alloc]init];
            NSArray *textFields = alertController.textFields;
            for (int i = 0; i < textFields.count; i++) {
                [texts addObject:alertController.textFields[i].text?alertController.textFields[i].text:@""];
            }
            block(i,bts[i],texts);
        }]];
    }
    [controller presentViewController:alertController animated:NO completion:nil];
}

- (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSString *text))block textFieldBlock:(void (^_Nullable)(UITextField *_Nonnull textField))textFieldBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.placeholder = placeholder;
        if (textFieldBlock) {
            textFieldBlock(textField);
        }
    }];
    for (int i = 0; i < bts.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            block(i,bts[i],alertController.textFields[0].text);
        }]];
    }
    [controller presentViewController:alertController animated:NO completion:nil];
}

- (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle, NSString *text))block {
    [self showTextFieldAltOn:controller title:title msg:msg placeholder:placeholder bts:bts block:block textFieldBlock:nil];
}

- (void)showNotice:(NSString *)noticeStr {
    [self showNotice:noticeStr atView:nil delay:0];
}

- (void)showNotice:(NSString *)noticeStr atView:(UIView *)view {
    [self showNotice:noticeStr atView:view delay:0];
}

- (void)showNotice:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay {
    
    if ([NSThread currentThread] == [NSThread mainThread]) {
        [self _showNotice:noticeStr atView:view delay:delay];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _showNotice:noticeStr atView:view delay:delay];
    });
    
}

- (void)_showNotice:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay {
    if (noticeStr.length <= 0) {
        return;
    }
    UIView *showV;
    if (view) {
        showV = view;
    } else {
        showV = self.currentUIViewController.view;
    }
    
    UILabel *label = UILabel.new;
    label.text = noticeStr;
    label.numberOfLines = 0;
    label.font = RF(14);
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = RGBA(0, 0, 0, .8);
    [showV addSubview:label];
    
    label.width = WIDTH() - RH(40);
    [label sizeToFit];
    label.bottom = showV.height/2;
    label.left = WIDTH()/2-label.width/2;
    
    //adjust
    label.width = label.width+RH(20);
    label.left = label.left-RH(10);
    label.height = label.height+RH(20);
    
    float animateDelay = delay;
    if (animateDelay == 0) {
        if (noticeStr.length < 10) {
            animateDelay = 3;
        }else if (noticeStr.length < 30){
            animateDelay = 3 + (noticeStr.length - 10) * 0.2;
        }else{
            animateDelay = 7;
        }
    }
    
    [b delay:animateDelay block:^{
        [UIView animateWithDuration:.5f animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            if (!showV) {
                return;
            }
            [label removeFromSuperview];
        }];
    }];
}

- (void)showCannotRemoveLoading:(NSString *)noticeStr {
    [self showLoading:noticeStr atView:nil cannotRemove:YES];
}

- (void)showLoading:(NSString *)noticeStr {
    [self showLoading:noticeStr atView:nil cannotRemove:NO];
}

- (void)showLoading:(NSString *)noticeStr atView:(UIView *)view cannotRemove:(BOOL)cannotRemove {
//    [self stopLoading];
    if (noticeStr.length <= 0) {
        noticeStr = @"加载中";
    }
    UIView *showV;
    if (view) {
        showV = view;
    } else {
        showV = self.currentUIViewController.view;
    }
    
    [_loadingView removeFromSuperview];
    [_loadingLabel removeFromSuperview];
    
    if (cannotRemove) {
        UIView *view = UIView.new;
        view.size = CGSizeMake(WIDTH(), HEIGHT());
        view.backgroundColor = RGBA(0, 0, 0, 0.5);
        [showV addSubview:view];
        _loadingView = view;
    }
    
    UILabel *label = UILabel.new;
    _loadingLabel = label;
    label.text = noticeStr;
    label.numberOfLines = 0;
    label.font = RF(14);
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = RGBA(0, 0, 0, .8);
    [showV addSubview:label];
    [self updateLoading];
    
    label.width = WIDTH() - RH(40);
    [label sizeToFit];
    label.bottom = showV.height/2;
    label.left = WIDTH()/2-label.width/2;
    
    //adjust
    label.width = label.width+RH(20);
    label.left = label.left-RH(10);
    label.height = label.height+RH(20);
}

- (void)updateLoading {
    if (!_loadingLabel) {
        return;
    }
    if (_loadingLabel.alpha == 0) {
        return;
    }
    NSString *text = _loadingLabel.text;
    if ([text hasSuffix:@"..."]) {
        text = [text substringToIndex:text.length-3];
    } else {
        text = [text stringByAppendingString:@"..."];
    }
    _loadingLabel.text = text;
    [b delay:1 block:^{
        [self updateLoading];
    }];
}

- (void)stopLoading {
    _loadingLabel.alpha = 0;
    [_loadingView removeFromSuperview];
    _loadingLabel = nil;
}

@end
