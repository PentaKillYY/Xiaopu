//
//  AllOrderViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "AllOrderViewController.h"
#import "MyAppiontOrderTableViewCell.h"
#import "MyService.h"
#import "MyPayTableViewCell.h"
#import "MyEvaluateTableViewCell.h"
#import "MyAllOrderTableViewCell.h"

@interface AllOrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DataResult* appointmentResult;
    DataResult* orderResult;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation AllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAppiontOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAppiontOrder"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPay"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyEvaluate"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAllOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAllOrder"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self getAppointListRequest];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return appointmentResult.items.size+orderResult.items.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < appointmentResult.items.size) {
        return  [tableView fd_heightForCellWithIdentifier:@"MyAppiontOrder" cacheByIndexPath:indexPath configuration:^(id cell) {
                    [self congigCell:cell Index:indexPath];
        }];
    }else{
        DataItem* item = [orderResult.items getItem:indexPath.section-appointmentResult.items.size];
        if ([[item getString:@"TradeStatus1"] isEqual:@"未支付"]){
            return  [tableView fd_heightForCellWithIdentifier:@"MyPay" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configPayCell:cell Index:indexPath];
            }];
        }else if([[item getString:@"TradeStatus1"] isEqual:@"已支付"] &&[[item getString:@"EvaluateStatus"] isEqual:@"未评价"]) {
            return  [tableView fd_heightForCellWithIdentifier:@"MyEvaluate" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configEvaluateCell:cell Index:indexPath];
            }];
        }else{
            return  [tableView fd_heightForCellWithIdentifier:@"MyAllOrder" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configAllOrderCell:cell Index:indexPath];
            }];
        }
       
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < appointmentResult.items.size) {
        MyAppiontOrderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyAppiontOrderTableViewCell" owner:self options:nil].firstObject;
        [self congigCell:cell Index:indexPath];
        return cell;
    }else{
        DataItem* item = [orderResult.items getItem:indexPath.section-appointmentResult.items.size];
        DLog(@"indexPath.section:%d",indexPath.section);
        if ([[item getString:@"TradeStatus1"] isEqual:@"未支付"]) {
            MyPayTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyPayTableViewCell" owner:self options:nil].firstObject;

            [self configPayCell:cell Index:indexPath];
            return cell;
        }else if ([[item getString:@"TradeStatus1"] isEqual:@"已支付"] &&[[item getString:@"EvaluateStatus"] isEqual:@"未评价"]){
            MyEvaluateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyEvaluateTableViewCell" owner:self options:nil].firstObject;
            [self configEvaluateCell:cell Index:indexPath];
            return cell;
        }else{
            MyAllOrderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyAllOrderTableViewCell" owner:self options:nil].firstObject;
            [self configAllOrderCell:cell Index:indexPath];
            return cell;
        }
    }
}


-(void)congigCell:(MyAppiontOrderTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[appointmentResult.items getItem:indexpath.section]];
}

-(void)configPayCell:(MyPayTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section-appointmentResult.items.size]];
}

-(void)configEvaluateCell:(MyEvaluateTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section-appointmentResult.items.size]];
}

-(void)configAllOrderCell:(MyAllOrderTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section-appointmentResult.items.size]];
}

#pragma msrk - NetWorkRequest
-(void)getAppointListRequest{
    [[MyService sharedMyService] getUserAppointListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        appointmentResult = json;
        [self getOrderListRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)getOrderListRequest{
    [[MyService sharedMyService] getUserOrderListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"orderType":@(2),@"evaluateStatus":@(2)} onCompletion:^(id json) {
        orderResult = json;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

@end
