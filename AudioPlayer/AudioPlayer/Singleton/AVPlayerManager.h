//
//  AVPlayerManager.h
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//


@class MusicInfo;

@protocol AVPlayerManagerDelegate <NSObject>

-(void) didPlayChangeStatus: (NSString *) time;

@end

@interface AVPlayerManager : NSObject
//播放列表歌曲数目
@property (nonatomic, assign, readonly) NSUInteger playListCount;

@property (nonatomic, weak) id<AVPlayerManagerDelegate> delegate;

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
/**
 *  准备播放歌曲
 *
 *  @param index 列表中的第几首
 */
-(MusicInfo *) prepareMusicWithIndex: (NSUInteger) index;
/**
 *  播放音乐
 */
-(void) musicPlay;
/**
 *  暂停
 */
-(void) musicPause;
/**
 *  播放时间拖拽
 *
 *  @param time <#time description#>
 */
-(void) musicSeekToTime: (float) time;
/**
 *  声量改变
 *
 *  @param volValue 0.0 ~ 1.0
 */
-(void) musicVolume: (float) volValue;




@end
