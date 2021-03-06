//
//  OrderPayViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrderPayViewController.h"
#import "MyPayTableViewCell.h"
#import "MyService.h"
@interface OrderPayViewController ()<UITableViewDelegate,UITableViewDataSource,PayCellDelegate,UIAlertViewDelegate>{
    DataResult* orderResult;
    NSInteger currentOrderIndex;
}


@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPay"];
    
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PayToConfirmOrder"]){
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [orderResult.items getItem:currentOrderIndex];
        [theSegue setValue:[item getString:@"OrderNum"] forKey:@"orderNumber"];
        [theSegue setValue:@"no" forKey:@"isAll"];

    }
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshPay" object:nil];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerRefresh) name:@"RefreshPay" object:nil];
    [super viewWillDisappear:animated];
}

-(void)observerRefresh{
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UItableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (orderResult.items.size) {
        return orderResult.items.size;
    }else{
        return 1;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (orderResult.items.size) {
        return  [tableView fd_heightForCellWithIdentifier:@"MyPay" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self congigCell:cell Index:indexPath];
        }];
    }else{
        return Main_Screen_Height-64-45;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (orderResult.items.size) {
        MyPayTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyPayTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        cell.cancelOrderButton.tag = indexPath.section;
        cell.dealOrderButton.tag = indexPath.section;
        [self congigCell:cell Index:indexPath];
        return cell;
    }else{
        NoOrderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"NoOrderTableViewCell" owner:self options:nil].firstObject;
        
        return cell;
    }
   
}

-(void)congigCell:(MyPayTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section]];
}


#pragma mark - PayCellDelegate

-(void)cancelDelegate:(id)sender{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定取消订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
    
    UIButton* button = (UIButton*)sender;
    currentOrderIndex = button.tag;
  
}

#define UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self cancelOrderRequest];
    }
}


-(void)payDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentOrderIndex = button.tag;
    
    [self performSegueWithIdentifier:@"PayToConfirmOrder" sender:self];
}

#pragma mark - NetworkRequest

-(void)getOrderListRequest{
    [[MyService sharedMyService] getUserOrderListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"orderType":@(0),@"evaluateStatus":@(2)} onCompletion:^(id json) {
        orderResult = json;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)cancelOrderRequest{
    [[MyService sharedMyService] cancelUserOrderWithParameters:@{@"orderNum":[[orderResult.items getItem:currentOrderIndex] getString:@"OrderNum"],@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        [self.tableView.mj_header beginRefreshing];
    } onFailure:^(id json) {
        
    }];
}

@end
