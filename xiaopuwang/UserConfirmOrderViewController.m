//
//  UserConfirmOrderViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "UserConfirmOrderViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyService.h"

@interface UserConfirmOrderViewController ()<UITextFieldDelegate,UIPickerViewDelegate>{
    DataResult* orderResult;
    UILabel* orderNameLabel;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation UserConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"支付订单";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    orderNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, Main_Screen_Width-16, 30)];
    
    orderNameLabel.font = [UIFont systemFontOfSize:13.0];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    [headerView addSubview:orderNameLabel];
    self.tableView.tableHeaderView = headerView;
    
    
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(30, 5, Main_Screen_Width-60, 35);
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton setTitle:@"确认付款" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [sendButton setBackgroundColor:MAINCOLOR];
    
    UILabel* tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 45, Main_Screen_Width-60, 20)];
    tipLabel.text = @"注:请确认以上信息无误后，再付款";
    tipLabel.font = [UIFont systemFontOfSize:11];
    tipLabel.textColor = [UIColor lightGrayColor];
    
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 65)];
    [footerView addSubview:tipLabel];
    [footerView addSubview:sendButton];
    
    self.tableView.tableFooterView = footerView;
    
    [self getUserOrderInfoRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DealOrderTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:self options:nil].firstObject;
    cell.cellTitle.text = DealOrderTitle[indexPath.row];
    cell.cellContent.userInteractionEnabled = NO;
    if (orderResult) {
        if (indexPath.row == 0) {
            cell.cellContent.text = [[orderResult.items getItem:0] getString:@"OrderNum"];
        }else if (indexPath.row ==1){
            cell.cellContent.text = [[orderResult.items getItem:0] getString:@"Subject"];
        }else if (indexPath.row ==2){
            cell.cellContent.text = [NSString stringWithFormat:@"%.2f",[[orderResult.items getItem:0] getDouble:@"OriginalPrice"]] ;
        }else if (indexPath.row ==3){
            cell.cellContent.text = [UserInfo sharedUserInfo].telphone;
        }else if (indexPath.row ==4){
            cell.cellContent.text = [[orderResult.items getItem:0] getString:@"StudentName"];
        }else{
            cell.cellContent.text = PayType [[[orderResult.items getItem:0] getInt:@"PayType"]-1] ;
        }
    }
    
    
    return cell;
}

#pragma mark - NetwordRequest

-(void)getUserOrderInfoRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[MyService sharedMyService] getUserOrderInfoWithParameters:@{@"userId":info.userID,@"orderNo":self.orderNumber} onCompletion:^(id json) {
        orderResult = json;
        orderNameLabel.text = [[orderResult.items getItem:0] getString:@"OrganizationName"];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
