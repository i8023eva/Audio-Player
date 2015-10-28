//
//  AVPlayerManager.h
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicInfo;

@interface AVPlayerManager : NSObject
//播放列表歌曲数目
@property (nonatomic, assign, readonly) NSUInteger playListCount;

EVASingletonH(AVPlayer)

-(void) getPlayListCompletionHandler: (void(^)())handler;

-(MusicInfo *) getMusicInfoWithIndex: (NSUInteger)index;


@end
