//
//  OrgVideoViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/27.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgVideoViewController.h"
#import "OrginizationService.h"
#import "VideoTableViewCell.h"
@interface OrgVideoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    DataResult* _videoRequest;
    NSMutableArray* videoItemArray;
    NSInteger pageIndex;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrgVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"机构视频";
    
    videoItemArray = [[NSMutableArray alloc] init];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        pageIndex = 1;
        
        [videoItemArray removeAllObjects];
        [self getVideoAlbumRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        pageIndex +=1;
        
        [self getVideoAlbumRequest];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return videoItemArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"VideoTableViewCell" owner:self options:nil].firstObject;
    [cell bingdingViewModel:videoItemArray[indexPath.row]];
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"VideoListToPlayer" sender:self];
}

-(void)getVideoAlbumRequest{
    [[OrginizationService sharedOrginizationService] getVideoWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(pageIndex),@"pageSize":@(10)} onCompletion:^(id json) {
        _videoRequest = json;
        
        if ([self.videoType intValue] ==0){
            //视频
            
            DataItemArray* itemArray =  [_videoRequest.detailinfo getDataItemArray:@"videoList"];
            
            for (int i = 0; i <itemArray.size; i++) {
                DataItem* item = [itemArray getItem:i];
                if ([item getInt:@"VideoType"] == 0) {
                    [videoItemArray addObject:item];
                }
            }
            
        }else{
            //在线试听
            
            DataItemArray* itemArray =  [_videoRequest.detailinfo getDataItemArray:@"videoList"];
            
            for (int i = 0; i <itemArray.size; i++) {
                DataItem* item = [itemArray getItem:i];
                if ([item getInt:@"VideoType"] != 0) {
                    [videoItemArray addObject:item];
                }
            }
        }

        [self.tableView.mj_header endRefreshing];
        
        if (pageIndex*10 < [_videoRequest.detailinfo getInt:@"TotalCount"]) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
        
        
    } onFailure:^(id json) {
        
    }];
}

@end
