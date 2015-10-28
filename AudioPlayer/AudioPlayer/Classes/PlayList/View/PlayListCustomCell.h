//
//  PlayListCustomCell.h
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//


@class MusicInfo;
@interface PlayListCustomCell : UITableViewCell
/**
 *  设置单元格   赋值对应的音乐信息
 *
 *  @param musicInfo 音乐信息
 */
-(void) setCellWithMusicInfo: (MusicInfo *)musicInfo;
@end
