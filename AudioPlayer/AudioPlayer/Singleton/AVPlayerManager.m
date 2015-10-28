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


@interface AVPlayerManager ()

@property (nonatomic, strong) NSMutableArray *playListArr;
//播放器属性
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation AVPlayerManager

EVASingletonM(AVPlayer)

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
#pragma mark - cell
-(MusicInfo *) prepareMusicWithIndex: (NSUInteger) index {
    //
    MusicInfo *musicInfo = [self getMusicInfoWithIndex:index];
    //
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:musicInfo.mp3Url]];
    //替换当前的 Item
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    
    return musicInfo;
}
#pragma mark - 播放
-(void) musicPlay {
    //创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [self.player play];
}
#pragma mark - delagate 的调用
-(void) timerAction {
    if ([self.delegate respondsToSelector:@selector(didPlayChangeStatus)]) {
        //播放时, 外部调用改变状态的方法
        [self.delegate didPlayChangeStatus];
    }
}

@end
