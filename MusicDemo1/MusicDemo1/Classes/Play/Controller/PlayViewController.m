//
//  PlayViewController.m
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayViewController.h"
#import "PlayManager.h"
#import "MusicInfo.h"
#import "UIImageView+WebCache.h"
#import "PlayerConsole.h"

@interface PlayViewController ()<UITableViewDataSource, UITabBarDelegate, PlayManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *musicPicImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
//控制台
@property (weak, nonatomic) IBOutlet PlayerConsole *playConsole;


@property (nonatomic, strong) PlayManager *playManager;

@property (nonatomic, strong) NSArray *lrcArr;
@end

static PlayViewController *_instance = nil;
@implementation PlayViewController
/**
 *  storyboard 单例化
 *
 *  @return <#return value description#>
 */
+(instancetype) sharedPlayViewController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _instance = [storyboard instantiateViewControllerWithIdentifier:@"PlayViewController"];
    });
    return _instance;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lrc" forIndexPath:indexPath];
    
    NSDictionary *dict = self.lrcArr[indexPath.row];
    
    cell.textLabel.text = dict.allValues.lastObject;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    
    UIView *view = [[UIView alloc]initWithFrame:cell.bounds];
    view.backgroundColor = [UIColor clearColor];
    
    cell.selectedBackgroundView = view;
    
    return cell;
    
}

-(void)didPlayChangeStatus:(NSString *)time {
    [self.lrcArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        
        if ([time isEqualToString:dict.allKeys.lastObject]) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:idx inSection:0];
            
            [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }];
    
    self.musicPicImageView.transform = CGAffineTransformRotate(self.musicPicImageView.transform, M_PI / 180);
    [self.playConsole playMusicWithFormatString:time];
}
/**
 *  换歌刷新数据
 *
 *  @param musicInfo <#musicInfo description#>
 */
-(void)didMusicCutWithMusicInfo:(MusicInfo *)musicInfo {
    
    [self.playConsole prepareMusicWithInfo:musicInfo];
    
    self.lrcArr = [NSArray arrayWithArray:musicInfo.timeForLyric];
    [self.tableView reloadData];
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:musicInfo.blurPicUrl] placeholderImage:nil];
    [self.musicPicImageView sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl] placeholderImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playManager = [PlayManager sharedPlayManager];
    self.playManager.delegate = self;

    
    [self.musicPicImageView layoutIfNeeded];
    self.musicPicImageView.layer.cornerRadius = self.musicPicImageView.bounds.size.height / 2;
    [self.musicPicImageView.layer setMasksToBounds:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.playManager prepareMusicWithIndex:self.musicIndex];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
