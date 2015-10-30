//
//  MusicTimeFormat.h
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicTimeFormat : NSObject

+(NSString *) getStringFormatBySeconds :(float) seconds;

+(float) getSecondsFormatByString: (NSString *) time;
@end
