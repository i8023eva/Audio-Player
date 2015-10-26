//
//  PlayListTableViewCell.h
//  AudioPlayer
//
//  Created by lyh on 15/10/26.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayListModel;
@interface PlayListTableViewCell : UITableViewCell

@property (nonatomic, strong) PlayListModel *playListModel;

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
