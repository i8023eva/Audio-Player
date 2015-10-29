//
//  PlayerConsole.h
//  AudioPlayer
//
//  Created by lyh on 15/10/29.
//  Copyright © 2015年 lyh. All rights reserved.
//

@class MusicInfo;
@interface PlayerConsole : UIView

/**
 *  准备播放时
 *
 *  @param musicInfo 音乐模型
 */
-(void) prepareMusicWithInfo: (MusicInfo *)musicInfo;
@end
