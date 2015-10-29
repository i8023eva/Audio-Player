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
#import "AVPlayerManager.h"

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

-(void) playMusicWithFormatString: (NSString *)time {
    self.timeSlider.value = [MusicTimeFormat getSecondsFormatByString:time];
    self.currentLabel.text = time;
}
#pragma mark - 播放& 暂停
-(IBAction) didPlayButtonClick: (UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"播放"]) {
        [sender setTitle:@"暂停" forState: UIControlStateNormal];
        [[AVPlayerManager sharedAVPlayer] musicPlay];
    }else {
        [sender setTitle:@"播放" forState: UIControlStateNormal];
        [[AVPlayerManager sharedAVPlayer] musicPause];
    }
}

-(IBAction) didTimeSliderValueChange: (UISlider *)sender {
    [[AVPlayerManager sharedAVPlayer] musicSeekToTime:sender.value];
}

-(IBAction) didVolumeValueChange: (UISlider *)sender {
    [[AVPlayerManager sharedAVPlayer] musicVolume:sender.value];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
