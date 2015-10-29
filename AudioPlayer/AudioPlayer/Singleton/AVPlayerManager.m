//
//  AVPlayerManager.m
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "AVPlayerManager.h"
#import "URL.h"
#import "MusicInfo.h"
#import "MusicTimeFormat.h"


@interface AVPlayerManager ()

@property (nonatomic, strong) NSMutableArray *playListArr;
//播放器属性
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation AVPlayerManager

EVASingletonM(AVPlayer)

-(instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didMusicFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

#pragma mark - 通知  下一首  计时器
-(void) didMusicFinished {
    [self musicPause];
    [self musicNext];
    [self musicPlay];
}

-(AVPlayer *)player {
    if (_player == nil) {
        _player = [[AVPlayer alloc]init];
    }
    return _player;
}

-(NSMutableArray *)playListArr {
    if (_playListArr == nil) {
        _playListArr = [NSMutableArray array];
    }
    return _playListArr;
}

-(NSUInteger)playListCount {
    return self.playListArr.count;
}

-(MusicInfo *) getMusicInfoWithIndex: (NSUInteger)index {
    return self.playListArr[index];
}

-(void)getPlayListCompletionHandler:(void (^)())handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /**
         *  先清空数组, 防止多次调用内容累加
         */
        [self.playListArr removeAllObjects];
        
        NSArray *tmpArray = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kPlayListURL]];
        
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MusicInfo *musicInfo = [MusicInfo new];
            //每次都创建一个新的 Model 赋值
            [musicInfo setValuesForKeysWithDictionary:obj];
            
            [self.playListArr addObject:musicInfo];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            handler();
        });
    });
    
}
#pragma mark - cell  ----Managerdelegate
-(void) prepareMusicWithIndex: (NSUInteger) index {
    if (index != self.currentIndex) {
        
        self.currentIndex = index;
        //
        MusicInfo *musicInfo = [self getMusicInfoWithIndex:index];
        
        if ([self.delegate respondsToSelector:@selector(didMusicCutWithMusicInfo:)]) {
            [self.delegate didMusicCutWithMusicInfo:musicInfo];
        }
        //
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:musicInfo.mp3Url]];
        //替换当前的 Item
        [self.player replaceCurrentItemWithPlayerItem:playerItem];
       
        
    }
}
#pragma mark - 播放
-(void) musicPlay {
    //创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.player play];
}
#pragma mark - 暂停
-(void) musicPause {
    [self.player pause];
    
    [self.timer invalidate];
    self.timer = nil;
}
-(void) musicStop {
    
}
#pragma mark - 上一首
-(void)musicUp {
    [self prepareMusicWithIndex:self.currentIndex - 1 < 0 ? self.playListArr.count - 1 : self.currentIndex - 1];
}
#pragma mark - 下一首
-(void)musicNext {
    [self prepareMusicWithIndex:self.currentIndex + 1 < self.playListArr.count ? self.currentIndex + 1 : 0];
}
-(void)musicSeekToTime: (float)time {
    [self.player seekToTime:CMTimeMake(time, 1)];
}

-(void)musicVolume: (float)volValue {
    self.player.volume = volValue;
}
#pragma mark - delagate 的调用
-(void) timerAction {
    if ([self.delegate respondsToSelector:@selector(didPlayChangeStatus:)]) {
        
//        self.player.currentTime.value / self.player.currentTime.   当前播放时间
        CGFloat currentTime =  CMTimeGetSeconds(self.player.currentTime);
        
        //播放时, 外部调用改变状态的方法  ---传值: 时间字符串
        [self.delegate didPlayChangeStatus:[MusicTimeFormat getStringFormatBySeconds:currentTime]];
    }
}





@end
