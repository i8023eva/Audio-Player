//
//  ListViewCell.h
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MusicInfo;
@interface ListViewCell : UITableViewCell

/**
 *  根据 musicInfo 为 cell 赋值
 *
 *  @param musicInfo <#musicInfo description#>
 */
-(void) setCellWithMusicInfo: (MusicInfo *)musicInfo;
@end
