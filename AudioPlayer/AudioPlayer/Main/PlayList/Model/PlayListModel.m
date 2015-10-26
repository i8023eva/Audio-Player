//
//  PlayListModel.m
//  AudioPlayer
//
//  Created by lyh on 15/10/26.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayListModel.h"

@interface PlayListModel ()

@end

@implementation PlayListModel
-(instancetype) initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype) playListWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

+(NSMutableArray *) playList{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    NSURL *URL = [NSURL URLWithString:@"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15];

        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSArray *arr = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:NULL];
            
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [tmpArray addObject: [self playListWithDict:obj]];
            }];
            
        }];
        [dataTask resume];
    
    return tmpArray;
}



-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(NSString *) description{
    
    return [NSString stringWithFormat:@"<%@: %p> {name: %@}", self.class, self, self.name];
}
@end
