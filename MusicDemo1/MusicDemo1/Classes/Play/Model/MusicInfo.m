//
//  MusicInfo.m
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "MusicInfo.h"

@implementation MusicInfo

-(instancetype)init {
    self = [super init];
    if (self) {
        self.timeForLyric = [NSMutableArray array];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }else if ([key isEqualToString:@"lyric"]) {
        [self formatLrcWithString:value];
    }
}

-(void) formatLrcWithString: (NSString *)value {
    
    NSArray *lrcTotal = [value componentsSeparatedByString:@"\n"];
    
    [lrcTotal enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@""]) {
            //( "[00:00.000" , "xxxx" )
            NSArray *lrcItem = [obj componentsSeparatedByString:@"]"];
            // "00:00"
            NSString *timeKey = [lrcItem.firstObject substringWithRange:NSMakeRange(1, 5)];
            
            NSDictionary *lrc = @{timeKey: lrcItem.lastObject};
            
            [self.timeForLyric addObject:lrc];
        }
    }];
}

@end
