//
//  PlayManager.m
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayManager.h"
#import "URL.h"
#import "MusicInfo.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicTimeFormat.h"

@interface PlayManager ()

@property (nonatomic, strong) NSMutableArray *playListArr;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger currentIndex;
@end

static id _instance = nil;
@implementation PlayManager

+(instancetype) sharedPlayManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMusicFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

-(NSMutableArray *)playListArr {
    if (_playListArr == nil) {
        _playListArr = [NSMutableArray array];
    }
    return _playListArr;
}

-(AVPlayer *)player {
    if (_player == nil) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

-(NSInteger)playListCount {
    return self.playListArr.count;
}

-(MusicInfo *)getMusicInfoWithIndex:(NSInteger)index {
    return self.playListArr[index];
}

-(void) playListCompletionHandler: (void (^)()) handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.playListArr removeAllObjects];
        
        NSArray *tmpArr = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kPlayListURL]];
        
        [tmpArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MusicInfo *info = [[MusicInfo alloc]init];
            
            [info setValuesForKeysWithDictionary:obj];
            [self.playListArr addObject:info];
            
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            handler();
        });
    });
    
}

-(void)prepareMusicWithIndex:(NSUInteger)index {
    /**
     *  切换歌曲时的准备
     */
    if (index != self.currentIndex) {
        self.currentIndex = index;
        
        MusicInfo *info = [self getMusicInfoWithIndex:index];
        if ([self.delegate respondsToSelector:@selector(didMusicCutWithMusicInfo:)]) {
            [self.delegate didMusicCutWithMusicInfo:info];
        }
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:info.mp3Url]];
        
        [self.player replaceCurrentItemWithPlayerItem:item];
    }
    
    
}

-(void)musicPlay {
    //定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    [self.player play];
}

-(void) didMusicFinished {
    [self musicPause];
    [self musicNext];
    [self musicPlay];
    
}

-(void)musicPause {
    [self.player pause];
    
    [self.timer invalidate];
    self.timer = nil;
}

-(void)musicUp {
    [self prepareMusicWithIndex:self.currentIndex -1 < 0 ? self.playListArr.count -1 : self.currentIndex -1];
}

-(void)musicNext {
    [self prepareMusicWithIndex:self.currentIndex +1 < self.playListArr.count ? self.currentIndex +1 : 0];
}

/**
 *  0.1秒
 */
-(void) timerAction {
    if ([self.delegate respondsToSelector:@selector(didPlayChangeStatus:)]) {
        
        CGFloat currentTime = CMTimeGetSeconds(self.player.currentTime);
        
        [self.delegate didPlayChangeStatus:[MusicTimeFormat getStringFormatBySeconds:currentTime]];
    }
}

/**
 *  播放时间拖拽
 *
 *  @param time <#time description#>
 */
-(void) musicSeekToTime: (float) time {
    [self.player seekToTime:CMTimeMake(time, 1)];
}
/**
 *  声量改变
 *
 *  @param volValue 0.0 ~ 1.0
 */
-(void) musicVolume: (float) volValue {
    self.player.volume = volValue;
}



@end
