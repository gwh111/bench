//
//  CC_Video.m
//  bench_ios
//
//  Created by gwh on 2020/4/12.
//

#import "bVideo.h"
#import <AVKit/AVKit.h>
#import "b.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

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
//    _playerVC.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4"]];
    _playerVC.player = [AVPlayer playerWithURL:_videoUrl];
//    _playerVC.player.preventsAutomaticBackgroundingDuringVideoPlayback = YES;
    
    _playerVC.view.frame = CGRectMake(0, 0, 300, 300);
    _playerVC.player.accessibilityElementsHidden = NO;
    _playerVC.showsPlaybackControls = YES;
    _playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _playerVC.allowsPictureInPicturePlayback = YES;
    _playerVC.showsPlaybackControls = YES;
    
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayback error:nil];
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

//对图片尺寸进行压缩--
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //    新创建的位图上下文 newSize为其大小
    UIGraphicsBeginImageContext(newSize);
    //    对图片进行尺寸的改变
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    //    从当前上下文中获取一个UIImage对象  即获取新的图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+ (NSString *)convertImages:(NSArray *)images toVideoName:(NSString *)videoName {
    if (images.count <= 0) {
        return nil;
    }
    UIImage *image = images.firstObject;
    //设置mov路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *moviePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",videoName]];
    
//    self.theVideoPath = moviePath;
    
    //定义视频的大小320 480 倍数
//    float w = image.size.width;
//    float h = w*320/480;
//    CGSize size = CGSizeMake(w, h);
    CGSize size = CGSizeMake(480, 320);
//    size = self.view.frame.size;
    
    NSError *error = nil;
    
    //    转成UTF-8编码
    unlink([moviePath UTF8String]);
    
    benchLog(@"path->%@",moviePath);
    
    //     iphone提供了AVFoundation库来方便的操作多媒体设备，AVAssetWriter这个类可以方便的将图像和音频写成一个完整的视频文件
    
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc]initWithURL:[NSURL fileURLWithPath:moviePath]fileType:AVFileTypeQuickTimeMovie error:&error];
    
    NSParameterAssert(videoWriter);
    
    if (error) {
        benchLog(@"error =%@",[error localizedDescription]);
        return nil;
    }
    
    //mov的格式设置 编码格式 宽度 高度
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264,AVVideoCodecKey,
                                     
                                     [NSNumber numberWithInt:size.width],AVVideoWidthKey,
                                     
                                     [NSNumber numberWithInt:size.height],AVVideoHeightKey,nil];
    
    AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    
    NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB],kCVPixelBufferPixelFormatTypeKey,nil];
    
    //    AVAssetWriterInputPixelBufferAdaptor提供CVPixelBufferPool实例,
    //    可以使用分配像素缓冲区写入输出文件。使用提供的像素为缓冲池分配通常
    //    是更有效的比添加像素缓冲区分配使用一个单独的池
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    
    NSParameterAssert(writerInput);
    
    NSParameterAssert([videoWriter canAddInput:writerInput]);
    
    if ([videoWriter canAddInput:writerInput]) {
        benchLog(@"canAddInput");
    } else {
        benchLog(@"canAddInput fail");
    }
    
    [videoWriter addInput:writerInput];
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
    //合成多张图片为一个视频文件
    dispatch_queue_t dispatchQueue = dispatch_queue_create("mediaInputQueue",NULL);
    int __block frame = 0;
    [writerInput requestMediaDataWhenReadyOnQueue:dispatchQueue usingBlock:^{
        
        while([writerInput isReadyForMoreMediaData]) {
            
            if (++frame >= [images count] * 10) {
                [writerInput markAsFinished];
                
                [videoWriter finishWritingWithCompletionHandler:^{
                    benchLog(@"视频合成完毕");
//                    UISaveVideoAtPathToSavedPhotosAlbum(moviePath, nil, nil, nil);
                }];
                break;
            }
            
            CVPixelBufferRef buffer = NULL;
            
            int idx = frame / 10;
            
            NSLog(@"idx==%d",idx);
            NSString *progress = [NSString stringWithFormat:@"%0.2lu",idx / [images count]];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
//                self.ww_progressLbe.text = [NSString stringWithFormat:@"合成进度:%@",progress];
                benchLog(@"%@",[NSString stringWithFormat:@"合成进度:%@",progress]);
            }];
            UIImage *image = [images objectAtIndex:idx];
            image = [self imageWithImage:image scaledToSize:size];
            buffer = (CVPixelBufferRef)[self pixelBufferFromCGImage:[image CGImage]size:size];
            if(buffer) {
                //设置每秒钟播放图片的个数
                if(![adaptor appendPixelBuffer:buffer withPresentationTime:CMTimeMake(frame,10)]) {
                    benchLog(@"FAIL");
                } else {
                    benchLog(@"DONE");
                }
                CFRelease(buffer);
            }
        }
    }];
    return moviePath;
}

+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image size:(CGSize)size {
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                           
                           [NSNumber numberWithBool:YES],kCVPixelBufferCGImageCompatibilityKey,
                           
                           [NSNumber numberWithBool:YES],kCVPixelBufferCGBitmapContextCompatibilityKey,nil];
    
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,size.width,size.height,kCVPixelFormatType_32ARGB,(__bridge CFDictionaryRef) options,&pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer,0);
    
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    NSParameterAssert(pxdata !=NULL);
    
    CGColorSpaceRef rgbColorSpace=CGColorSpaceCreateDeviceRGB();
    
    //    当你调用这个函数的时候，Quartz创建一个位图绘制环境，也就是位图上下文。当你向上下文中绘制信息时，Quartz把你要绘制的信息作为位图数据绘制到指定的内存块。一个新的位图上下文的像素格式由三个参数决定：每个组件的位数，颜色空间，alpha选项
    
    CGContextRef context = CGBitmapContextCreate(pxdata,size.width,size.height,8,4*size.width,rgbColorSpace,kCGImageAlphaPremultipliedFirst);
    
    NSParameterAssert(context);
    
    //使用CGContextDrawImage绘制图片  这里设置不正确的话 会导致视频颠倒
    
    //    当通过CGContextDrawImage绘制图片到一个context中时，如果传入的是UIImage的CGImageRef，因为UIKit和CG坐标系y轴相反，所以图片绘制将会上下颠倒
    
    CGContextDrawImage(context,CGRectMake(0,0,CGImageGetWidth(image),CGImageGetHeight(image)), image);
    
    // 释放色彩空间
    
    CGColorSpaceRelease(rgbColorSpace);
    
    // 释放context
    
    CGContextRelease(context);
    
    // 解锁pixel buffer
    
    CVPixelBufferUnlockBaseAddress(pxbuffer,0);
    
    return pxbuffer;
    
}

@end
