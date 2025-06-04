//
//  bVideoQueue.h
//  bench
//
//  Created by gwh on 2025/5/9.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**
 // 初始化播放队列
     NSArray *urls = @[
         [NSURL URLWithString:@"http://example.com/video1.mp4"],
         [NSURL URLWithString:@"http://example.com/video2.mp4"]
     ];
     self.videoQueue = [[bVideoQueue alloc] initWithURLs:urls];
     
     // 设置播放完成回调
     __weak typeof(self) weakSelf = self;
     self.videoQueue.playbackCompletion = ^(NSInteger currentIndex, NSURL *currentURL) {
         NSLog(@"播放完成: 第%ld个视频 %@", currentIndex+1, currentURL.absoluteString);
     };
     
     // 绑定播放器显示层
     AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.videoQueue.player];
     layer.frame = self.view.bounds;
     [self.view.layer addSublayer:layer];
     
     // 开始播放
     [self.videoQueue play];
 */
NS_ASSUME_NONNULL_BEGIN

typedef void(^bVideoPlaybackCompletionBlock)(NSInteger currentIndex, NSURL *currentURL);

@interface bVideoQueue : NSObject

// 播放器实例（供外部绑定显示层）
@property (nonatomic, readonly) AVPlayer *player;

/**
 初始化方法
 @param urls 视频URL数组
 */
- (instancetype)initWithURLs:(NSArray<NSURL *> *)urls;

/**
 添加播放完成监听块（可多次调用添加多个回调）
 @param block 播放完成时的回调
 */
- (void)addPlaybackCompletionBlock:(bVideoPlaybackCompletionBlock)block;

/**
 开始播放（首次调用或暂停后恢复）
 */
- (void)play;

/**
 暂停播放
 */
- (void)pause;

@end

NS_ASSUME_NONNULL_END
