//
//  CommunityLocationViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityLocationViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>
@interface CommunityLocationViewController ()<UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate>
{
    NSString* address;
    NSInteger selectAddressIndex;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,strong)AMapSearchAPI* search;
@end

@implementation CommunityLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择位置";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                 initWithImage:V_IMAGE(@"close") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftItem rightBarButtonItem:nil];
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor darkGrayColor]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self geoSearch];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"LocationCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
     UserInfo* info = [UserInfo sharedUserInfo];
    
    if (info.address.length) {
        if (indexPath.row==0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
    }else {
        if (indexPath.row==0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    }
    
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"不显示位置";
    }else{
        cell.textLabel.text = address;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectAddressIndex = indexPath.row;
    if (selectAddressIndex==0) {
        address = @"";
    }
    
    UserInfo* info = [UserInfo sharedUserInfo];
    info.address = address;
    [info synchronize];

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)geoSearch{
    UserInfo* info = [UserInfo sharedUserInfo];
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location= [AMapGeoPoint locationWithLatitude:[info.userLatitude doubleValue] longitude:[info.userLongitude doubleValue]];
    regeo.requireExtension  = YES;
    [self.search AMapReGoecodeSearch:regeo];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        address = response.regeocode.formattedAddress;
        [self.tableView reloadData];
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}
@end
