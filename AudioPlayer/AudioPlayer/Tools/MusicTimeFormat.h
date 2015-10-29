//
//  MusicTimeFormat.h
//  AudioPlayer
//
//  Created by lyh on 15/10/29.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicTimeFormat : NSObject

/**
 *  返回字符串
 *
 *  @param seconds 秒
 */
+(NSString *) getStringFormatBySeconds :(float) seconds;
/**
 *  返回秒
 *
 *  @param time 字符串
 */
+(float) getSecondsFormatByString: (NSString *) time;
@end
