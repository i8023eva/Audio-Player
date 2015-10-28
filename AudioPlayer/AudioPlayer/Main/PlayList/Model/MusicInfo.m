//
//  MusicInfo.m
//  AudioPlayer
//
//  Created by lyh on 15/10/28.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "MusicInfo.h"

@implementation MusicInfo

-(instancetype)init {
    self = [super init];
    if (self) {
        /**
         *  实例化时间&歌词数组
         */
        self.timeForLyric = [NSMutableArray array];
    }
    return self;
}
















-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }else if ([key isEqualToString:@"lyric"]) {
        [self formatLrcWithLrcString:value];
    }
}

-(void) formatLrcWithLrcString: (NSString *) lrc {
    /**
     *  以 \n 拆解字符串   _--- "[00:00.000] xxxx"
     */
    NSArray *lrcCmps = [lrc componentsSeparatedByString:@"\n"];
    
    [lrcCmps enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqualToString:@""]) {
            /**
             *  以 ']' 拆解字符串 _--- ("[00:00.000", "xxxx")
             */
            NSArray *lrcAndTimeArr = [obj componentsSeparatedByString:@"]"];
            /**
             *  截取 00:00 作为字典的键
             */
            NSString *timeKey = [[lrcAndTimeArr firstObject] substringWithRange:NSMakeRange(1, 5)];
            //创建字典, 数组的后一个元素[歌词]作为 value
            NSDictionary *lrcDict = @{timeKey: [lrcAndTimeArr lastObject]};
            /**
             *  ( {key: value},
             {key: value}, ...
             );
             */
            [self.timeForLyric addObject:lrcDict];
        }
    }];
}


@end
