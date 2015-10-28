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

-(void) prepareMusicWithIndex: (NSUInteger) index {
    MusicInfo *musicInfo = [self getMusicInfoWithIndex:index];
    //
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:musicInfo.mp3Url]];
    //
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    
}

-(void) musicPlay {
    [self.player play];
}

@end
