//
//  CC_Video.m
//  bench_ios
//
//  Created by gwh on 2020/4/12.
//

#import "bVideo.h"
#import <AVKit/AVKit.h>
#import "b.h"

@interface bVideo ()

@property (nonatomic, strong) AVPlayerViewController *playerVC;
@property (nonatomic, weak) id timeObserve;
@property (nonatomic, assign) BOOL muted;

@end

@implementation bVideo

- (void)start {
    
//self.playerVC.entersFullScreenWhenPlaybackBegins = YES;//开启这个播放的时候支持（全屏）横竖屏哦
//self.playerVC.exitsFullScreenWhenPlaybackEnds = YES;//开启这个所有 item 播放完毕可以退出全屏
    
}

+ (bVideo *)videoWithURL:(NSURL *)url {
    bVideo *video = bVideo.new;
    video.videoUrl = url;
    [video setup];
    return video;
}

- (void)setup {
    
    _playerVC = AVPlayerViewController.new;
    _playerVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4"]];
    _playerVC.view.frame = CGRectMake(0, 0, 300, 300);
    _playerVC.player.accessibilityElementsHidden = NO;
    _playerVC.showsPlaybackControls = YES;
    _playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (UIView *)displayView {
    return _playerVC.view;
}

- (void)updateURL:(NSURL *)url {
    _videoUrl = url;
    _playerVC.player = [AVPlayer playerWithURL:_videoUrl];
    _playerVC.player.muted = YES;
}

- (void)soundOn {
    _muted = NO;
    _playerVC.player.muted = NO;
}

- (void)soundOff {
    _muted = YES;
    _playerVC.player.muted = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                   change:(NSDictionary *)change context:(void *)context {

    if ([keyPath isEqualToString:@"readyForDisplay"]) {
        if (_playWhenReady) {
            [_playerVC.player play];
        }
    }

}

- (void)play {
    
    _playWhenReady = YES;
    
    if (_playerVC.readyForDisplay) {
        [_playerVC.player play];
    } else {
    }
    [self addObserver];
}

- (void)addObserver {
    
    [self removeObserver];
    
//    [_playerVC addObserver:self forKeyPath:@"readyForDisplay" options:0 context:NULL];
    WS(weakSelf)
    _timeObserve = [_playerVC.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:nil usingBlock:^(CMTime time) {
        CGFloat progress = CMTimeGetSeconds(weakSelf.playerVC.player.currentItem.currentTime) / CMTimeGetSeconds(weakSelf.playerVC.player.currentItem.duration);
        
        if (progress == 1.0f) {
            NSLog(@"%@",weakSelf.videoUrl);
            //播放百分比为1表示已经播放完毕
            [weakSelf.playerVC.player seekToTime:kCMTimeZero];
            if (weakSelf.playerVC.player.isMuted) {
                [weakSelf playMutely];
            } else {
                [weakSelf play];
            }
            [weakSelf addObserver];
        }

    }];
}

- (void)playMutely {
    [self soundOff];
    [self play];
}

- (void)pause {
    _playWhenReady = NO;
    [_playerVC.player pause];
//    if (_type == CC_VideoFinishTypeRepeat) {
//        _playerVC.showsPlaybackControls = false;
//    }
    [self removeObserver];
}

- (void)addToView:(id)view {
    [view addSubview:_playerVC.view];
}

- (void)removeObserver {
    
    if (_timeObserve) {
        @try {
            [_playerVC removeObserver:self forKeyPath:@"readyForDisplay"];
            [_playerVC.player removeTimeObserver:_timeObserve];
        } @catch(id anException) {
            //do nothing, obviously it wasn't attached because an exception was thrown
            NSLog(@"anException");
        }
        _timeObserve = nil;
    }
    
}

@end
