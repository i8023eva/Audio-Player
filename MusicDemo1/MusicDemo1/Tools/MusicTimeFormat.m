//
//  MusicTimeFormat.m
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "MusicTimeFormat.h"

@implementation MusicTimeFormat

+(NSString *) getStringFormatBySeconds :(float) seconds {
    return [NSString stringWithFormat:@"%02d:%02d", (int)seconds / 60, (int)seconds % 60];
}

+(float) getSecondsFormatByString: (NSString *) time {
    NSArray *timeArr = [time componentsSeparatedByString:@":"];
    
    return [timeArr.firstObject integerValue] * 60 + [timeArr.lastObject integerValue];
}
@end
