//
//  CommunityTypeViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityTypeViewController.h"
#import "CommunityService.h"
@interface CommunityTypeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DataResult*communityTypeResult;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation CommunityTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择标签";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                 initWithImage:V_IMAGE(@"close") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftItem rightBarButtonItem:nil];
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor darkGrayColor]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    

    [self getCommunityTypeRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return communityTypeResult.items.size;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"TypeCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.text = [[communityTypeResult.items getItem:indexPath.row] getString:@"TypeName"];

    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.communityType.length) {
        if (indexPath.row == [info.communityType intValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfo* info = [UserInfo sharedUserInfo];
    info.communityType = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [info synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getCommunityTypeRequest{
    [[CommunityService sharedCommunityService] getCommunityTypeWithParameters:nil onCompletion:^(id json) {
        communityTypeResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
