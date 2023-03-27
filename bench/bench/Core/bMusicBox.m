//
//  CC_MusicBox.m
//  bench_ios
//
//  Created by gwh on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "bMusicBox.h"

@implementation bMusicBox

static bMusicBox *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[bMusicBox alloc] init];
    });
    return instance;
}

- (void)remove{
    instance=nil;
    onceToken=0;
}

- (void)playEffect:(NSString *)name type:(NSString *)type {
    if (_forbiddenEffect) {
        return;
    }
    isMusic=0;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!strSoundFile) {
//        NSLog(@"strSoundFile=nil");
        return;
    }
    NSURL *musicURL = [NSURL fileURLWithPath:strSoundFile];
    
    AVAudioPlayer *audio = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    if (_audioIndex == 0) {
        _audioPlayer = audio;
    }
    if (_audioIndex == 1) {
        _audioPlayer1 = audio;
    }
    if (_audioIndex == 2) {
        _audioPlayer2 = audio;
    }
    if (_audioIndex == 3) {
        _audioPlayer3 = audio;
    }
    if (_audioIndex == 4) {
        _audioPlayer4 = audio;
    }
    if (_audioIndex == 5) {
        _audioPlayer5 = audio;
    }
//    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [audio setDelegate:self];
//    if (_defaultVolume>0) {
//        audio.volume = _defaultVolume;
//    }
    [audio prepareToPlay];
    [audio play];
    
    _audioIndex++;
    if (_audioIndex > 5) {
        _audioIndex = 0;
    }
}

- (void)stopEffect {
    [_audioPlayer stop];
    [_audioPlayer1 stop];
    [_audioPlayer2 stop];
    [_audioPlayer3 stop];
    [_audioPlayer4 stop];
    [_audioPlayer5 stop];
}

- (void)stopMusic {
    [_audioPlayerMusic stop];
}

- (void)playMusic:(NSString *)name type:(NSString *)type {
    _musicIndex = 1;
    if (_forbiddenMusic) {
        return;
    }
//    if (_audioPlayerMusic) {
//        fadeTimeCount=0;
//        [self soundFadeOut:name type:type];
//        return;
//    }
    isMusic=1;
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!musicPath) {
        NSLog(@"musicPath=nil");
        return;
    }
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    _audioPlayerMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [_audioPlayerMusic setDelegate:self];
    if (_musicVolume>0) {
        _audioPlayerMusic.volume = _musicVolume;
    }
    if (_fade) {
        fadeTimeCount=0;
        _audioPlayerMusic.volume = 0.05;
        [self soundFadeIn];
    }
    [_audioPlayerMusic prepareToPlay];
    [_audioPlayerMusic play];
}

- (void)playMusic2:(NSString *)name type:(NSString *)type {
    _musicIndex = 2;
    if (_forbiddenMusic) {
        return;
    }
//    if (_audioPlayerMusic) {
//        fadeTimeCount=0;
//        [self soundFadeOut:name type:type];
//        return;
//    }
    isMusic=1;
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!musicPath) {
        NSLog(@"musicPath=nil");
        return;
    }
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    _audioPlayerMusic2 = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [_audioPlayerMusic2 setDelegate:self];
    if (_musicVolume>0) {
        _audioPlayerMusic2.volume = _musicVolume;
    }
    if (_fade) {
        fadeTimeCount=0;
        _audioPlayerMusic2.volume = 0.05;
        [self soundFadeIn];
    }
    [_audioPlayerMusic2 prepareToPlay];
    [_audioPlayerMusic2 play];
}

- (void)soundFadeOut:(NSString *)name type:(NSString *)type{
    if (fadeTimeCount<10) {
        fadeTimeCount++;
        double delayInSeconds = 0.1;
        __block bMusicBox *blockSelf=self;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            blockSelf->_audioPlayer.volume = 1-blockSelf->fadeTimeCount*0.1;
            [self soundFadeOut:name type:type];
        });
    }else{
        [_audioPlayerMusic stop];
        _audioPlayerMusic=nil;
        [self playMusic:name type:type];
    }
}

- (void)soundFadeIn{
    if (fadeTimeCount<20) {
        fadeTimeCount++;
        double delayInSeconds = 0.25;
        __block bMusicBox *blockSelf=self;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            blockSelf->_audioPlayer.volume = blockSelf->fadeTimeCount*0.05;
            [self soundFadeIn];
        });
    }
}

//播放完后
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag{
    if (isMusic) {
        if (_musicReplayTimes>0) {
            _musicReplayTimes--;
            if (_musicIndex == 1) {
                [_audioPlayerMusic play];
            }
        }
    }else{
//        if (_effectReplayTimes>0) {
//            _effectReplayTimes--;
//            [_audioPlayer play];
//        }
    }
    
}

@end
