//
//  OrgMoreEvaluateViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgMoreEvaluateViewController.h"
#import "OrginizationService.h"
#import "OrgEvaluateTableViewCell.h"

@interface OrgMoreEvaluateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentIndex;
    NSMutableArray* datasourceArray;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrgMoreEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部评价";
    
    datasourceArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgEvaluate"];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex = 1;
        [datasourceArray removeAllObjects];
        [self getRelyListRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex +=1;
        
        [self getRelyListRequest];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datasourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"OrgEvaluate" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:cell indexpath:indexPath];
    }];
    return  height < 86 ? 86:height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrgEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrgEvaluate" forIndexPath:indexPath];
    [self configCell:cell indexpath:indexPath];
    return cell;
    
}

- (void)configCell:(OrgEvaluateTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    
    DataItem * item = datasourceArray[indexpath.row];
    
    cell.relyContent.preferredMaxLayoutWidth = Main_Screen_Width-85;
    cell.relyContent.numberOfLines = 0;
    [cell bingdingViewModel:item];
}


-(void)getRelyListRequest{
    [[OrginizationService sharedOrginizationService] getOrgRelyContentListWithParameters:@{@"orgId":self.orgID,@"pageIndex":@(currentIndex),@"pageSize":@(10),@"replyflag":@"全部"} onCompletion:^(id json) {
        
        DataResult* result = json;
        DataItemArray* itemArray =  [result.detailinfo getDataItemArray:@"replyList"];
        
        for (int i = 0 ; i < itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            [datasourceArray addObject:item];
        }
        
        [self.tableView.mj_header endRefreshing];
        if (currentIndex*10 < [result.detailinfo getInt:@"TotalCount"]) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
        
    } onFailure:^(id json) {
        
    }];
}

@end
