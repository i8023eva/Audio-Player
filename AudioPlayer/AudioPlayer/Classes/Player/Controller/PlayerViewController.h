//
//  PlayerViewController.h
//  AudioPlayer
//
//  Created by lyh on 15/10/26.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "ViewController.h"

@interface PlayerViewController : ViewController
@property (nonatomic, assign) NSUInteger musicIndex;

+(instancetype) sharedPlayerViewController;
@end
