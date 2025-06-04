//
//  CC_Video.h
//  bench_ios
//
//  Created by gwh on 2020/4/12.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface bVideo : NSObject

// 模拟器无法播放真机可以
@property (nonatomic, readonly) UIView *displayView;//播放器显示视图

@property (nonatomic, strong) NSString *coverImageUrl;
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, assign) BOOL playWhenReady;
@property (nonatomic, strong) AVPlayerViewController *playerVC;
@property (nonatomic, strong) AVQueuePlayer *queuePlayer;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) NSArray<NSString *> *videoPaths;

@property (nonatomic, strong) void(^finishBlock)(int);

- (void)addFinishBlock:(void(^)(int win))block;

// 必须以属性方式持有，否则会被提前释放
+ (bVideo *)videoWithURL:(NSURL *)url;
+ (bVideo *)videoWithPath:(NSString *)path;
+ (bVideo *)videoWithPaths:(NSArray<NSString *> *)paths;

+ (NSString *)convertImages:(NSArray *)images toVideoName:(NSString *)videoName;

// 销毁时需要释放
// 播放观察者释放
- (void)removeObserver;

// 添加到视图
- (void)addToView:(id)view;

// 更新视频地址
- (void)updateURL:(NSURL *)url;
- (void)updatePath:(NSString *)path;

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
