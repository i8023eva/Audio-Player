//
//  AVPlayerManager.h
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVPlayerManager : NSObject

EVASingletonH(AVPlayer)

-(void) getPlayListCompletionHandler: (void(^)())handler;

@end
