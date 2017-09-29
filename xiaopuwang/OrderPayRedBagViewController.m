//
//  OrderPayRedBagViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrderPayRedBagViewController.h"
#import "UserConfirmOrderViewController.h"
#import "RedBagCommonSelectTableViewCell.h"
#import "RedBagSpecialSelectTableViewCell.h"
#import "NoRedBagTableViewCell.h"
#import "RedBagService.h"

@interface OrderPayRedBagViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DataItemArray* redbagArray;
    NSMutableArray* selectMutableArray;
    NSMutableArray* selectIDArray;
    NSInteger totalRegBag;
    NSInteger limitRedBagNumber;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrderPayRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [UIColor clearColor];
    [self calculateLimitRedBag];
    
    redbagArray = [DataItemArray new];
    selectMutableArray = [[NSMutableArray alloc] init];
    selectIDArray = [[NSMutableArray alloc] init];
    if (self.currentindex.length) {
        
        [selectMutableArray addObjectsFromArray:[self.currentindex componentsSeparatedByString:@","]];
        [selectIDArray addObjectsFromArray:[self.currentids componentsSeparatedByString:@","]];
        totalRegBag = [self.currentredbagNumber intValue];
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self getRedBagRequest];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - UITableViewdatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return redbagArray.size+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 52;
    }
    return 131;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        NoRedBagTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"NoRedBagTableViewCell" owner:self options:nil].firstObject;
        
        if (selectMutableArray.count == 0){
            [cell.selectStateButton setBackgroundColor:MAINCOLOR];
        }else{
            [cell.selectStateButton setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        return cell;
        
    }else{
        DataItem* item = [redbagArray getItem:indexPath.section-1];
        

        if ([item getInt:@"RedPacketType"]==0){
            RedBagCommonSelectTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"RedBagCommonSelectTableViewCell" owner:self options:nil].firstObject;
            
            if ([selectMutableArray containsObject:[NSString stringWithFormat:@"%ld",indexPath.section-1]]){
                [cell.selectStateButton setBackgroundColor:MAINCOLOR];
            }else{
                [cell.selectStateButton setBackgroundColor:[UIColor lightGrayColor]];
            }
            [cell bingdingViewModel:item];
            return cell;
        }else{
            RedBagSpecialSelectTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"RedBagSpecialSelectTableViewCell" owner:self options:nil].firstObject;
            
            if ([selectMutableArray containsObject:[NSString stringWithFormat:@"%ld",indexPath.section-1]]){
                [cell.selectStateButton setBackgroundColor:MAINCOLOR];
            }else{
                [cell.selectStateButton setBackgroundColor:[UIColor lightGrayColor]];
            }
            [cell bingdingViewModel:item];
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray* deleteArray = [[NSMutableArray alloc] init];
    NSMutableArray* deleteidArray = [[NSMutableArray alloc] init];
    
    if (indexPath.section==0) {
        [selectMutableArray removeAllObjects];
        [selectIDArray removeAllObjects];
        totalRegBag = 0;
    }else{
        DataItem* item = [redbagArray getItem:indexPath.section-1];
        
        if ([selectMutableArray containsObject:[NSString stringWithFormat:@"%ld",indexPath.section-1]]) {
            [deleteArray addObject:[NSString stringWithFormat:@"%ld",indexPath.section-1]];
            [deleteidArray addObject:[item getString:@"Id"]];
            
            totalRegBag -= [item getInt:@"Price"];
        }else{
            if ((totalRegBag + [item getInt:@"Price"]) > limitRedBagNumber) {
                [[AppCustomHud sharedEKZCustomHud] showTextHud:[NSString stringWithFormat:@"最多可选择%ld元现金红包",(long)limitRedBagNumber]];
            }else{
                totalRegBag += [item getInt:@"Price"];
                
                [selectMutableArray addObject:[NSString stringWithFormat:@"%ld",indexPath.section-1] ];
                [selectIDArray addObject:[item getString:@"Id"]];
            }
            
        }
        
        [selectMutableArray removeObjectsInArray:deleteArray];
        [selectIDArray removeObjectsInArray:deleteidArray];
    }
    
    [tableView reloadData];
}

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)confirmSelectRedBag:(id)sender{
    UserConfirmOrderViewController *ConfirmOrder = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    ConfirmOrder.redBagDic = nil;
    if (totalRegBag>0) {
        NSString *string = [selectIDArray componentsJoinedByString:@","];
        NSString* string2 = [selectMutableArray componentsJoinedByString:@","];
        
        ConfirmOrder.redBagDic = [NSMutableDictionary dictionaryWithDictionary:@{@"RedbagNumber":[NSString stringWithFormat:@"%ld",(long)totalRegBag],@"IDS":string,@"SelectIndex":string2}];
    }
    
    
    [self.navigationController popToViewController:ConfirmOrder animated:true];

}

#pragma mark - Networkrequest

-(void)getRedBagRequest{
    [redbagArray clear];
    
    [[RedBagService sharedRedBagService] getUserRedBagListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"state":@(0)} onCompletion:^(id json) {
        DataResult* result = json;
        for (int i =0; i < result.items.size; i++) {
            DataItem* item = [result.items getItem:i];
            if ([item getInt:@"RedPacketType"]==0) {
                [redbagArray addObject:item];
            }else if ([item getInt:@"RedPacketType"]==1 && [[item getString:@"Organization_Application_ID"] isEqualToString:self.orgId]){
                [redbagArray addObject:item];
            }
        }
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
    } onFailure:^(id json) {
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
    }];
    
}

-(void)calculateLimitRedBag{
    if ([self.originPrice doubleValue]>2000 && [self.originPrice doubleValue]<5000) {
        limitRedBagNumber = 100;
    }else if ([self.originPrice doubleValue]>4999 && [self.originPrice doubleValue]<10000){
        limitRedBagNumber = 200;
    }else if ([self.originPrice doubleValue]>9999 && [self.originPrice doubleValue]<15000){
        limitRedBagNumber = 300;
    }else if ([self.originPrice doubleValue]>14999 && [self.originPrice doubleValue]<20000){
        limitRedBagNumber = 400;
    }else if ([self.originPrice doubleValue]>19999){
        limitRedBagNumber = 500;
    }
}

@end
