//
//  MyViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyViewController.h"
#import "MyBannerCell.h"
#import "MyOrderCell.h"
#import "MyApplyCell.h"
#import "MyTableCell.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hideNavigationBar:YES animated:YES];
    [self changeStatusBarStyle:UIStatusBarStyleLightContent statusBarHidden:YES changeStatusBarAnimated:YES];
   // self.isExtendLayout = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MyBannerCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyBannerCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 1){
        MyOrderCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyOrderCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 2){
        MyApplyCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyApplyCell" owner:self options:nil].firstObject;
        return cell;
    }else {
        MyTableCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyTableCell" owner:self options:nil].firstObject;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 3){
        return 44;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
