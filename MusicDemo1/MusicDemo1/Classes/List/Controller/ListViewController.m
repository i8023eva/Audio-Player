//
//  ListViewController.m
//  MusicDemo1
//
//  Created by lyh on 15/10/30.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "ListViewController.h"
#import "PlayViewController.h"
#import "PlayManager.h"
#import "MusicInfo.h"
#import "ListViewCell.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PlayManager *playManager;
@end

@implementation ListViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playManager.playListCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"music" forIndexPath:indexPath];
    
    MusicInfo *info = [self.playManager getMusicInfoWithIndex:indexPath.row];

    [cell setCellWithMusicInfo:info];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.playManager prepareMusicWithIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayViewController *playCon = [PlayViewController sharedPlayViewController];
    
    playCon.musicIndex = indexPath.row;
    
    [self.navigationController pushViewController:playCon animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.playManager = [PlayManager sharedPlayManager];
    
    [self.playManager playListCompletionHandler:^{
        [self.tableView reloadData];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"播放列表";
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
