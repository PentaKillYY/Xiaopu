//
//  MainViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainViewController.h"
#import "MainCycleTableViewCell.h"
#import "MainRollingTableViewCell.h"
#import "MainServiceTableViewCell.h"
#import "MainActivityTableViewCell.h"
#import "MainPreferedTableViewCell.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeStatusBarStyle:UIStatusBarStyleLightContent statusBarHidden:NO changeStatusBarAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MainCycleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainCycleTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 1){
        MainRollingTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainRollingTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 2){
        MainServiceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainServiceTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 5){
        MainPreferedTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainPreferedTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else{
        MainActivityTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainActivityTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }else if (indexPath.section == 1){
        return 44;
    }else if (indexPath.section == 2){
        return 100;
    }else {
        return 140;
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
