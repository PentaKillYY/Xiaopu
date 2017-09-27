//
//  TradeDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "TradeDetailViewController.h"
#import "MyService.h"
#import "TredeDetailTableViewCell.h"
@interface TradeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataResult*tradeResult;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation TradeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交易明细";
    self.tableView.hidden = YES;
    [self getUserTradeDetailRequest];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

#pragma mark - UITableViewdatasource

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tradeResult.items.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TredeDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TredeDetailTableViewCell" owner:self options:nil].firstObject;
    [cell bingdingViewModel:[tradeResult.items getItem:indexPath.section]];
    return cell;
}

#pragma mark - NetworkRequest

-(void)getUserTradeDetailRequest{
    [[MyService sharedMyService] getUserTradeDetailWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        tradeResult = json;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
