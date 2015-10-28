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

/**
 *  获取播放列表
 * ----完成时回调的 block
 */
-(void) getPlayListCompletionHandler: (void(^)())handler;
/**
 *  获取播放列表中的歌曲
 *
 *  @param index 获取哪一个
 *
 *  @return 返回对应的歌曲信息
 */
-(MusicInfo *) getMusicInfoWithIndex: (NSUInteger)index;


@end
