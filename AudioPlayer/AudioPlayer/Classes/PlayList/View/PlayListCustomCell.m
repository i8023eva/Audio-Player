//
//  PlayListCustomCell.m
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayListCustomCell.h"
#import "MusicInfo.h"
#import "UIImageView+WebCache.h"

@interface PlayListCustomCell ()
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UILabel *singerName;
@property (weak, nonatomic) IBOutlet UIImageView *musicPic;

@end

@implementation PlayListCustomCell


-(void) setCellWithMusicInfo: (MusicInfo *)musicInfo {
    self.musicName.text = musicInfo.name;
    self.singerName.text = musicInfo.singer;
    [self.musicPic sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl] placeholderImage:[UIImage imageNamed:@"logo.tiff"]];
}


- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
