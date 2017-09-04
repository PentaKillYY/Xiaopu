//
//  OrderAppointViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrderAppointViewController.h"
#import "MyAppiontOrderTableViewCell.h"
#import "MyService.h"

@interface OrderAppointViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate, AppointCellDelegate>{
    DataResult* appointmentResult;
    NSInteger currentAppointIndex;
    NSString* appointmentId;
}

@end

@implementation OrderAppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appointmentId = @"";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAppiontOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAppiontOrder"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self getAppointListRequest];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshAppointment" object:nil];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerRefresh) name:@"RefreshAppointment" object:nil];
    [super viewWillDisappear:animated];
}

-(void)observerRefresh{
    [self.tableView.mj_header beginRefreshing];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AppointToDealOrder"]){
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [appointmentResult.items getItem:currentAppointIndex];
        [theSegue setValue:item forKey:@"item"];
        [theSegue setValue:@"no" forKey:@"isAll"];
    }
}

#pragma mark - UItableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (appointmentResult.items.size) {
        return appointmentResult.items.size;
    }else{
        return 1;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (appointmentResult.items.size) {
        return  [tableView fd_heightForCellWithIdentifier:@"MyAppiontOrder" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self congigCell:cell Index:indexPath];
        }];
    }else{
        return Main_Screen_Height-64-45;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (appointmentResult.items.size) {
        MyAppiontOrderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyAppiontOrderTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        cell.dealOrderButton.tag =indexPath.section;
        cell.cancelOrderButton.tag = indexPath.section;
        
        [self congigCell:cell Index:indexPath];
        return cell;
    }else{
        NoOrderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"NoOrderTableViewCell" owner:self options:nil].firstObject;

        return cell;

    }
    
}

-(void)congigCell:(MyAppiontOrderTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[appointmentResult.items getItem:indexpath.section]];
}

#pragma mark - AppointCellDelegate

-(void)deleteOrderDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    
    appointmentId = [[appointmentResult.items getItem:button.tag] getString:@"User_Appointment_ID"];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定取消预约" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
}

-(void)dealOrderDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentAppointIndex = button.tag;
    [self performSegueWithIdentifier:@"AppointToDealOrder" sender:self];
}

#define UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
       [self deleteOrderRequest];
    }
}

#pragma mark - NetworkRequest

-(void)getAppointListRequest{
    [[MyService sharedMyService] getUserAppointListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        appointmentResult = json;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)deleteOrderRequest{
    [[MyService sharedMyService] deleteUserAppointmentWithParameters:@{@"userAppointmentId":appointmentId} onCompletion:^(id json) {
        [self.tableView.mj_header beginRefreshing];
    } onFailure:^(id json) {
        
    }];
}
@end
