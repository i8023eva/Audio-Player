//
//  MusicTimeFormat.m
//  AudioPlayer
//
//  Created by lyh on 15/10/29.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "MusicTimeFormat.h"

@implementation MusicTimeFormat

#pragma mark - 格式化时间
+(NSString *) getStringFormatBySeconds: (float) seconds {
    // 00:00
    NSString *formatStr = [NSString stringWithFormat:@"%02d:%02d", (int)seconds / 60, (int)seconds % 60];
    
    return formatStr;
}

+(float) getSecondsFormatByString: (NSString *) time {
    NSArray *arr = [time componentsSeparatedByString:@":"];
    return [arr.firstObject integerValue] * 60.0 + [arr.lastObject integerValue];
}
@end
