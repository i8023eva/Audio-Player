//
//  PlayManager.h
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MusicInfo;

@protocol PlayManagerDelegate <NSObject>

-(void) didPlayChangeStatus: (NSString *)time;
/**
 *  切换歌曲信息
 *
 *  @param musicInfo <#musicInfo description#>
 */
-(void) didMusicCutWithMusicInfo: (MusicInfo *) musicInfo;

@end

@interface PlayManager : NSObject

@property (nonatomic, weak) id<PlayManagerDelegate> delegate;



//歌曲数目
@property (nonatomic, assign) NSInteger playListCount;

+(instancetype) sharedPlayManager;

-(void) playListCompletionHandler: (void (^)()) handler;
/**
 *  根据 cell 下标来获取当前音乐信息
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
-(MusicInfo *) getMusicInfoWithIndex: (NSInteger) index;
/**
 *  播放前的准备
 *
 *  @param index <#index description#>
 */
-(void) prepareMusicWithIndex: (NSUInteger) index;
/**
 *  播放音乐
 */
-(void) musicPlay;
/**
 *  暂停
 */
-(void) musicPause;
/**
 *  上一首
 *
 *  @return <#return value description#>
 */
-(void) musicUp;
/**
 *  下一首
 */
-(void) musicNext;
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
