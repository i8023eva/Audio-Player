//
//  PlayerConsole.m
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayerConsole.h"
#import "MusicInfo.h"
#import "MusicTimeFormat.h"
#import "PlayManager.h"

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
    
    NSInteger time = [musicInfo.duration integerValue] / 1000;
    
    self.totalTimeLabel.text = [MusicTimeFormat getStringFormatBySeconds:time];
    
    self.timeSlider.maximumValue = time;
    
}

-(void) playMusicWithFormatString: (NSString *)time {
    self.timeSlider.value = [MusicTimeFormat getSecondsFormatByString:time];
    
    self.currentLabel.text = time;
}

-(IBAction) didPlayButtonClick: (UIButton *)sender {
    if ([self.playButton.currentTitle isEqualToString:@"播放"]) {
        [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];
        [[PlayManager sharedPlayManager] musicPlay];
    }else {
        [self.playButton setTitle:@"播放" forState: UIControlStateNormal];
        [[PlayManager sharedPlayManager] musicPause];
    }
}

-(IBAction) didTimeSliderValueChange: (UISlider *)sender {
    [[PlayManager sharedPlayManager] musicSeekToTime:sender.value];
}

-(IBAction) didVolumeValueChange: (UISlider *)sender {
    [[PlayManager sharedPlayManager] musicVolume:sender.value];
}

-(IBAction) didUpButtonClick:(UIButton *)sender {
    [[PlayManager sharedPlayManager] musicUp];
}

-(IBAction) didNextButtonClivk:(UIButton *)sender {
    [[PlayManager sharedPlayManager] musicNext];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
