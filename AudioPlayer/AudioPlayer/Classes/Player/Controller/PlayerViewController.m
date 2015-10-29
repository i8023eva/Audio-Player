//
//  PlayerViewController.m
//  AudioPlayer
//
//  Created by lyh on 15/10/26.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayerViewController.h"
#import "AVPlayerManager.h"
#import "MusicInfo.h"
#import "UIImageView+WebCache.h"
#import "PlayerConsole.h"

@interface PlayerViewController ()<UITableViewDataSource, UITableViewDelegate, AVPlayerManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *musicLyric;
@property (weak, nonatomic) IBOutlet UIImageView *musicPic;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
//控制台
@property (weak, nonatomic) IBOutlet PlayerConsole *playerConsole;


@property (nonatomic, strong) AVPlayerManager *playerManager;
//接收歌词
@property (nonatomic, strong) NSArray *lyricArr;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.playerManager = [AVPlayerManager sharedAVPlayer];
    self.playerManager.delegate = self;
    
    //调用准备播放的歌曲同时获取模型
    MusicInfo *musicInfo = [self.playerManager prepareMusicWithIndex:self.musicIndex];
    
    //控制台信息
    [self.playerConsole prepareMusicWithInfo:musicInfo];
    
    self.lyricArr = [NSArray arrayWithArray:musicInfo.timeForLyric];
    //tableView刷新
    [self.musicLyric reloadData];
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:musicInfo.blurPicUrl] placeholderImage:[UIImage imageNamed:@"logo.tiff"]];
    [self.musicPic sd_setImageWithURL:[NSURL URLWithString:musicInfo.picUrl] placeholderImage:[UIImage imageNamed:@"logo.tiff"]];

#warning 提前约束的生命周期
    [self.musicPic layoutIfNeeded];
    
    [self.musicPic.layer setMasksToBounds:YES];
    self.musicPic.layer.cornerRadius = self.musicPic.height / 2;
    
    

     
    
    [self.playerManager musicPlay];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    /**
     *  约束在此方法内才会进行设置   需要提前
     */
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.lyricArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //
    NSDictionary *dict = self.lyricArr[indexPath.row];
    //
    cell.textLabel.text = [[dict allValues] lastObject];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    //设置歌词高亮颜色
    cell.textLabel.highlightedTextColor = [UIColor magentaColor];
    
    UIView *view = [[UIView alloc]initWithFrame:cell.contentView.frame];
    view.backgroundColor = [UIColor clearColor];
    
    cell.selectedBackgroundView = view;
    
    return cell;
}

#pragma mark - AVPlayerManagerDelegate
-(void)didPlayChangeStatus:(NSString *)time {
    for (int i = 0; i < self.lyricArr.count; i++) {
        NSDictionary *dict = self.lyricArr[i];
        //是否和歌词中的时间相同
        if ([time isEqualToString:[[dict allKeys] lastObject]]) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            [self.musicLyric selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
    self.musicPic.transform = CGAffineTransformRotate(self.musicPic.transform, M_PI / 180);
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
