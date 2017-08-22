//
//  ReflectBalanceViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ReflectBalanceViewController.h"
#import "MyService.h"
#import "ReflectBannerTableViewCell.h"
#import "ReflectPriceTableViewCell.h"
#import "ReflectCardTableViewCell.h"
#import "AddReflectTableViewCell.h"

@interface ReflectBalanceViewController ()<UITableViewDelegate,UITableViewDataSource,ReflectCardDelegate>
{
    DataResult* cardResult;
    NSInteger selectIndex;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation ReflectBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请提现";
    self.navigationController.navigationBar.barTintColor = SPECIALISTNAVCOLOR;
    self.tableView.hidden = YES;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIButton* reflectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reflectButton.frame = CGRectMake(30, 30, Main_Screen_Width-60, 30);
    [reflectButton setTitle:@"提交申请" forState:0];
    [reflectButton.layer setCornerRadius:3.0];
    [reflectButton.layer setMasksToBounds:YES];
    [reflectButton setBackgroundColor:SPECIALISTNAVCOLOR];
    [reflectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reflectButton addTarget:self action:@selector(userReflectRequest) forControlEvents:UIControlEventTouchUpInside];
    UILabel* tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, Main_Screen_Width-60, 20)];
    tipLabel.text = ReflectTip;
    tipLabel.font = [UIFont systemFontOfSize:10];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 80)];
    [footerView addSubview:reflectButton];
    [footerView addSubview:tipLabel];
    
    self.tableView.tableFooterView = footerView;
    
    selectIndex = 3;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getCardListRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3+cardResult.items.size;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row ==1){
        return 60;
    }else{
        return 44;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ReflectBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ReflectBannerTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel];
        return cell;
    }else if (indexPath.row == 1){
        ReflectPriceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ReflectPriceTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel];
        return cell;
    }else if (indexPath.row == 2){
        AddReflectTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"AddReflectTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else{
        ReflectCardTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ReflectCardTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:[cardResult.items getItem:indexPath.row-3]];
        if (selectIndex == indexPath.row) {
            cell.selectImage.hidden = NO;
        }else{
            cell.selectImage.hidden = YES;
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath.row;
    [self.tableView reloadData];
}

#pragma mark - ReflectCardDelegate

-(void)addCardDelegate:(id)sender{
    [self performSegueWithIdentifier:@"ReflectToAddCard" sender:self];
}

-(void)getCardListRequest{
    [[MyService sharedMyService] getUserBankCardWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        cardResult = json;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)userReflectRequest{
    [[MyService sharedMyService] userReflectWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"cardNum":[[cardResult.items getItem:selectIndex-3] getString:@"CardNum"]} onCompletion:^(id json) {
        
        UserInfo* info = [UserInfo sharedUserInfo];
        info.userBalance = @"0.00";
        [info synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(id json) {
        
    }];
}
@end
