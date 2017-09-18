//
//  OrgMoreStudentViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgMoreStudentViewController.h"
#import "OrginizationService.h"
#import "OrgMoreStudentTableViewCell.h"

@interface OrgMoreStudentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentIndex;
    NSMutableArray* datasourceArray;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrgMoreStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部学生";
    
    datasourceArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgMoreStudentTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgMoreStudent"];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex = 1;
        [datasourceArray removeAllObjects];
        [self getStudentListRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex +=1;
        
        [self getStudentListRequest];
        
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
    
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"OrgMoreStudent" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:cell indexpath:indexPath];
    }];
    return  height < 86 ? 86:height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrgMoreStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrgMoreStudent" forIndexPath:indexPath];
    [self configCell:cell indexpath:indexPath];
    return cell;
    
}

- (void)configCell:(OrgMoreStudentTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    
    DataItem * item = datasourceArray[indexpath.row];
    
    cell.studentContent.preferredMaxLayoutWidth = Main_Screen_Width-85;
    cell.studentContent.numberOfLines = 0;
    [cell bingdingViewModel:item];
}


-(void)getStudentListRequest{
    [[OrginizationService sharedOrginizationService] getStudentListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(currentIndex),@"pageSize":@(10)} onCompletion:^(id json) {
        
        DataResult* result = json;
        DataItemArray* itemArray =  [result.detailinfo getDataItemArray:@"studentList"];
        
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
