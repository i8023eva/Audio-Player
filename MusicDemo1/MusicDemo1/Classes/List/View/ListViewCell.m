//
//  ListViewCell.m
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "ListViewCell.h"
#import "MusicInfo.h"
#import "UIImageView+WebCache.h"

@interface ListViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *musicPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;

@end

@implementation ListViewCell

-(void)setCellWithMusicInfo:(MusicInfo *)musicInfo {
    self.musicNameLabel.text = musicInfo.name;
    self.singerNameLabel.text = musicInfo.singer;
    [self.musicPicImageView sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl] placeholderImage:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
