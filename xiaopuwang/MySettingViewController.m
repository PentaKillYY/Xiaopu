//
//  MySettingViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MySettingViewController.h"
#import "MySettingTableViewCell.h"
#import "MyService.h"
#import "LoginViewController.h"
@interface MySettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger cardNumber;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
    [self getUserBankCardRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return MySettingTitle.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySettingTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MySettingTableViewCell" owner:self options:nil].firstObject;
    cell.cellTitle.text = MySettingTitle[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.cellDetail.text = [NSString stringWithFormat:@"当前已绑定%ld张银行卡",(long)cardNumber];
    }else if (indexPath.row == 2){
        cell.cellDetail.text = [self fileSizeWithInterge:[[SDImageCache sharedImageCache]getSize]];
    }else if (indexPath.row == 3){
        cell.cellDetail.text = @"当前为最新版本";
    }else{
        cell.cellDetail.text = @"";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"MyToBankCard" sender:self];
        
    }else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"MyToChangePassword" sender:self];
    }else if (indexPath.row == 2) {
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [tableView reloadData];
        }];
        
    }else if (indexPath.row == 3){
        [self performSegueWithIdentifier:@"MyToAbout" sender:self];
    }else{
        
        //清空登录缓存信息
        UserInfo* info = [UserInfo sharedUserInfo];
        [info logout];
        
        //断开融云连接并不再接收通知
        [[RCIM sharedRCIM] logout];
        
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
}

//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fKB",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fMB",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fGB",aFloat];
    }
}

#pragma mark - NetworkRequest
-(void)getUserBankCardRequest{
    [[MyService sharedMyService] getUserBankCardWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        DataResult* result = json;
        cardNumber = result.items.size;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
