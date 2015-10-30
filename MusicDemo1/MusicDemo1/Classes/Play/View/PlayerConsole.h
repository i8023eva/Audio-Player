//
//  PlayerConsole.h
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MusicInfo;
@interface PlayerConsole : UIView

-(void) prepareMusicWithInfo: (MusicInfo *)musicInfo;

-(void) playMusicWithFormatString: (NSString *)time;
@end
