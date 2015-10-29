//
//  PlayerConsole.m
//  AudioPlayer
//
//  Created by lyh on 15/10/29.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayerConsole.h"
#import "MusicInfo.h"
#import "MusicTimeFormat.h"

@interface PlayerConsole ()

@property (nonatomic, weak) IBOutlet UISlider *timeSlider;
@property (nonatomic, weak) IBOutlet UISlider *volumeSlider;
@property (nonatomic, weak) IBOutlet UILabel  *currentLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalTimeLabel;
@property (nonatomic, weak) IBOutlet UIButton *upButton;
@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UIButton *playButton;

@end

@implementation PlayerConsole

-(void) prepareMusicWithInfo: (MusicInfo *)musicInfo {
    self.currentLabel.text = @"00:00";
    //总时间
    NSInteger time = [musicInfo.duration intValue] / 1000;
    self.totalTimeLabel.text = [MusicTimeFormat getStringFormatBySeconds: time];
    //
    self.timeSlider.maximumValue = time;
    
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
