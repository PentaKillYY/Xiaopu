//
//  MyWalletViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyWalletViewController.h"
#import "WalletBannerTableViewCell.h"
#import "WalletBankCardTableViewCell.h"
#import "MyViewController.h"
#import "MyBankCardViewController.h"

@interface MyWalletViewController ()<UITableViewDelegate,UITableViewDataSource,WallectCellDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"我的钱包";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

#pragma mark - UItableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }else{
        return 5;
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WalletBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"WalletBannerTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else{
        WalletBankCardTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"WalletBankCardTableViewCell" owner:self options:nil].firstObject;
        cell.walletLabel.text = WalletTitle[indexPath.section][indexPath.row];
        [cell.walletLogo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Wallet-%ld-%ld",(long)indexPath.section,(long)indexPath.row]]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row ==0) {
            [self performSegueWithIdentifier:@"WalletToRedBag" sender:self];
        }else{
            if ([[UserInfo sharedUserInfo].userBalance doubleValue]>0) {
                [self performSegueWithIdentifier:@"WalletToReflectBalance" sender:self];
            }else{
                [[AppCustomHud sharedEKZCustomHud] showTextHud:NoBalance];
            }
        }
    }else if (indexPath.section == 2 ){
        [self performSegueWithIdentifier:@"WalletToBankCard" sender:self];
    }
}


#pragma mark WallectCellDelegate

-(void)detailDelegate:(id)sender{
    [self performSegueWithIdentifier:@"WalletToTradeDetail" sender:self];
}



@end
