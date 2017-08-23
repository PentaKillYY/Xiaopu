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
    self.navigationController.navigationBar.barTintColor = SPECIALISTNAVCOLOR;
    

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"我的钱包";
    self.navigationController.delegate = self;
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else{
        return 44;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WalletBannerTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"WalletBannerTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else{
        WalletBankCardTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"WalletBankCardTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"WalletToBankCard" sender:self];
    }
}


#pragma mark WallectCellDelegate

-(void)couponDelegate:(id)sender{
    [self performSegueWithIdentifier:@"WalletToCoupon" sender:self];
}

-(void)detailDelegate:(id)sender{
    [self performSegueWithIdentifier:@"WalletToTradeDetail" sender:self];
}

-(void)reflectDelegate:(id)sender{
    [self performSegueWithIdentifier:@"WalletToReflectBalance" sender:self];

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([viewController isKindOfClass:[MyViewController class]]) {
        self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    }else if ([viewController isKindOfClass:[MyWalletViewController class]]){
        self.navigationController.navigationBar.barTintColor = SPECIALISTNAVCOLOR;
    }else if ([viewController isKindOfClass:[MyBankCardViewController class]]){
        self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    }
}
@end
