//
//  PlayListTableViewCell.m
//  AudioPlayer
//
//  Created by lyh on 15/10/26.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayListTableViewCell.h"
#import "PlayListModel.h"

@interface PlayListTableViewCell ()


@end

@implementation PlayListTableViewCell


-(void)setPlayListModel:(PlayListModel *)playListModel {
    _playListModel = nil;
    _playListModel = playListModel;
    
    self.picImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: playListModel.picUrl]]];
    self.nameLabel.text = playListModel.name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
