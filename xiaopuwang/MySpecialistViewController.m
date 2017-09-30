//
//  MySpecialistViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MySpecialistViewController.h"
#import "MySpecialistTableViewCell.h"
#import "MyService.h"

@interface MySpecialistViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DataResult* allDataResult;
    DataResult* orgResult;
    DataResult* chinaSchoolRequest;
    DataResult* overseaSchoolRequest;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation MySpecialistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"教育规划受理状态";
    
    allDataResult = [DataResult new];
        
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:nil];
    
    self.tableView.hidden = YES;
    
    [self getSpecialistOrgRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

#pragma mark - UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return allDataResult.items.size;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySpecialistTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MySpecialistTableViewCell" owner:self options:nil].firstObject;
    if (indexPath.section < orgResult.items.size) {
        [cell bingdingViewModelTypeName:@"培训学校" State:[[allDataResult.items getItem:indexPath.section] getInt:@"IsState"] Time:[[allDataResult.items getItem:indexPath.section] getString:@"CreateTime"]];
    }else if (indexPath.section < orgResult.items.size+chinaSchoolRequest.items.size){
        [cell bingdingViewModelTypeName:@"国际学校" State:[[allDataResult.items getItem:indexPath.section] getInt:@"IsState"] Time:[[allDataResult.items getItem:indexPath.section] getString:@"CreateTime"]];
    }else{
        [cell bingdingViewModelTypeName:@"海外学校" State:[[allDataResult.items getItem:indexPath.section] getInt:@"IsState"] Time:[[allDataResult.items getItem:indexPath.section] getString:@"CreateTime"]];
    }
    
    return cell;
}

#pragma mark - NetworkRequest
-(void)getSpecialistOrgRequest{
    [[MyService sharedMyService] getSpecialistOrgWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        orgResult = json;
        [allDataResult append:orgResult];
        
        [self getSpecialistChinaSchoolRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)getSpecialistChinaSchoolRequest{
    [[MyService sharedMyService] getSpecialistChinaSchoolWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        chinaSchoolRequest = json;
        [allDataResult append:chinaSchoolRequest];
        
        [self getSpecialistOverseaSchoolRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)getSpecialistOverseaSchoolRequest{
    [[MyService sharedMyService] getSpecialistOverseaSchoolWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        overseaSchoolRequest = json;
        [allDataResult append:overseaSchoolRequest];
        if (allDataResult.items.size) {
            self.tableView.hidden = NO;
        }
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
