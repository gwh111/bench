//
//  CC_Video.h
//  bench_ios
//
//  Created by gwh on 2020/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface bVideo : NSObject

// 模拟器无法播放真机可以
@property (nonatomic, readonly) UIView *displayView;//播放器显示视图

@property (nonatomic, strong) NSString *coverImageUrl;
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, assign) BOOL playWhenReady;

+ (bVideo *)videoWithURL:(NSURL *)url;

// 销毁时需要释放
// 播放观察者释放
- (void)removeObserver;

// 添加到视图
- (void)addToView:(id)view;

// 更新视频地址
- (void)updateURL:(NSURL *)url;

// 播放
- (void)play;

// 静音
- (void)soundOff;
// 恢复声音
- (void)soundOn;

// 静音播放
- (void)playMutely;

// 暂停
- (void)pause;

@end

NS_ASSUME_NONNULL_END
