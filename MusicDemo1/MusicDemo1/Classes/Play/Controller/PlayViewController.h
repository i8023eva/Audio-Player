//
//  PlayViewController.h
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "ViewController.h"

@interface PlayViewController : ViewController
@property (nonatomic, assign) NSUInteger musicIndex;

+(instancetype) sharedPlayViewController;
@end
