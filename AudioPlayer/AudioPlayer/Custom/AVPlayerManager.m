//
//  AVPlayerManager.m
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "AVPlayerManager.h"
#import "URL.h"

@implementation AVPlayerManager

EVASingletonM(AVPlayer)

-(void)getPlayListCompletionHandler:(void (^)())handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *tmpArray = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kPlayListURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(tmpArray);
        });
    });
    
}

@end
