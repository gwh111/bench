//
//  bVideoQueue.m
//  bench
//
//  Created by gwh on 2025/5/9.
//
#import "bVideoQueue.h"

@interface bVideoQueue ()

@property (nonatomic, weak) id timeObserve;
@property (nonatomic, strong) AVQueuePlayer *queuePlayer;
@property (nonatomic, strong) NSArray<NSURL *> *videoURLs;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray<bVideoPlaybackCompletionBlock> *completionBlocks;

@end

@implementation bVideoQueue

#pragma mark - 初始化
- (instancetype)initWithURLs:(NSArray<NSURL *> *)urls {
    self = [super init];
    if (self) {
        _videoURLs = [urls copy];
        _currentIndex = 0;
        _completionBlocks = [NSMutableArray array];
        [self setupPlayer];
    }
    return self;
}

- (void)setupPlayer {
    AVPlayerItem *initialItem = [self createPlayerItemForIndex:_currentIndex];
    _queuePlayer = [AVQueuePlayer queuePlayerWithItems:@[initialItem]];
    [self addPlayerObservers];
}

#pragma mark - 公开方法
- (AVPlayer *)player {
    return _queuePlayer;
}

- (void)play {
    _queuePlayer.muted = YES;
    [_queuePlayer play];
}

- (void)pause {
    [_queuePlayer pause];
}

#pragma mark - 回调管理
- (void)addPlaybackCompletionBlock:(bVideoPlaybackCompletionBlock)block {
    if (block) {
        dispatch_barrier_async(dispatch_get_main_queue(), ^{
            [self.completionBlocks addObject:[block copy]];
        });
    }
}

#pragma mark - 播放控制
- (AVPlayerItem *)createPlayerItemForIndex:(NSInteger)index {
    NSURL *url = _videoURLs[index];
    AVAsset *asset = [AVAsset assetWithURL:url];
    return [AVPlayerItem playerItemWithAsset:asset];
}

- (void)preloadNextVideo {
    NSInteger nextIndex = (_currentIndex + 1) % _videoURLs.count;
    AVPlayerItem *nextItem = [self createPlayerItemForIndex:nextIndex];
    
    [nextItem.asset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.queuePlayer canInsertItem:nextItem afterItem:self.queuePlayer.currentItem]) {
                [self.queuePlayer insertItem:nextItem afterItem:self.queuePlayer.currentItem];
            }
        });
    }];
}

#pragma mark - 事件监听
- (void)addPlayerObservers {
    // 播放进度监听
    __weak typeof(self) weakSelf = self;
    _timeObserve = [_queuePlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:nil usingBlock:^(CMTime time) {
        AVPlayerItem *currentItem = weakSelf.queuePlayer.currentItem;
        if (!currentItem) return;
        
        Float64 remaining = CMTimeGetSeconds(currentItem.duration) - CMTimeGetSeconds(time);
        if (remaining < 3.0) {
            [weakSelf preloadNextVideo];
        }
    }];
    
    // 播放完成监听
    [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
        AVPlayerItem *finishedItem = note.object;
        if ([weakSelf.queuePlayer.items containsObject:finishedItem]) {
            [weakSelf.queuePlayer removeItem:finishedItem];
            weakSelf.currentIndex = (weakSelf.currentIndex + 1) % weakSelf.videoURLs.count;
            [weakSelf triggerCompletionBlocks];
        }
    }];
}

- (void)triggerCompletionBlocks {
    NSURL *currentURL = _videoURLs[_currentIndex];
    NSArray *blocks = [_completionBlocks copy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (bVideoPlaybackCompletionBlock block in blocks) {
            block(self.currentIndex, currentURL);
        }
    });
}

#pragma mark - 清理
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_queuePlayer removeAllItems];
    [_completionBlocks removeAllObjects];
}

@end
