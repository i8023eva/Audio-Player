//
//  PlayListModel.h
//  AudioPlayer
//
//  Created by lyh on 15/10/26.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayListModel : NSObject

@property (nonatomic, strong) NSString *mp3Url;
@property (nonatomic, strong) NSNumber *_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *blurPicUrl;
@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSString *singer;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSString *artists_name;
@property (nonatomic, strong) NSString *lyric;


-(instancetype) initWithDict:(NSDictionary *) dict;
+(instancetype) playListWithDict:(NSDictionary *) dict;

+(NSMutableArray *) playList;
@end
