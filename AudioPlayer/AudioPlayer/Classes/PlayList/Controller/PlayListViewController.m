//
//  PlayListViewController.m
//  AudioPlayer
//
//  Created by lyh on 15/10/26.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "PlayListViewController.h"
#import "PlayerViewController.h"
#import "AVPlayerManager.h"
#import "MusicInfo.h"
#import "PlayListCustomCell.h"

@interface PlayListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) AVPlayerManager *playerManager;

@end

@implementation PlayListViewController

#pragma mark - dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playerManager.playListCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    PlayListCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MusicInfo *musicInfo = [self.playerManager getMusicInfoWithIndex:indexPath.row];
    
    [cell setCellWithMusicInfo:musicInfo];
    
    return cell;
}

#pragma mark - delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.playerManager prepareMusicWithIndex:indexPath.row];
    
    PlayerViewController *playerVC = [PlayerViewController sharedPlayerViewController];
//    PlayerViewController *playerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayerViewController"];
    
//    playerVC.view.y = [UIScreen mainScreen].bounds.size.height;
//    [UIView animateWithDuration:1.0 animations:^{
//        
//        playerVC.view.y = 0;
//    } completion:^(BOOL finished) {
//        
//    }];
    playerVC.musicIndex = indexPath.row;
    
    
    [self.navigationController pushViewController:playerVC animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - view load
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.title = @"播放列表";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.playerManager = [AVPlayerManager sharedAVPlayer];
    
    [self.playerManager getPlayListCompletionHandler:^{
        
        [self.tableView reloadData];
    }];
}

#pragma mark -
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
