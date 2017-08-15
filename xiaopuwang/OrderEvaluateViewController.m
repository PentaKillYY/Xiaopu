//
//  OrderEvaluateViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrderEvaluateViewController.h"
#import "MyEvaluateTableViewCell.h"
#import "MyService.h"
@interface OrderEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DataResult* orderResult;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation OrderEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"MyEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyEvaluate"];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self getOrderListRequest];
    }];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return orderResult.items.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [tableView fd_heightForCellWithIdentifier:@"MyEvaluate" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self congigCell:cell Index:indexPath];
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyEvaluateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyEvaluateTableViewCell" owner:self options:nil].firstObject;
    [self congigCell:cell Index:indexPath];
    return cell;
}

-(void)congigCell:(MyEvaluateTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section]];
}

#pragma mark - NetworkRequest

-(void)getOrderListRequest{
    [[MyService sharedMyService] getUserOrderListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"orderType":@(1),@"evaluateStatus":@(0)} onCompletion:^(id json) {
        orderResult = json;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

@end
