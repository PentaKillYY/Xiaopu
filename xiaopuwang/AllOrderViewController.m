//
//  AllOrderViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "AllOrderViewController.h"
#import "MyAppiontOrderTableViewCell.h"
#import "MyService.h"
#import "MyPayTableViewCell.h"
#import "MyEvaluateTableViewCell.h"
#import "MyAllOrderTableViewCell.h"

@interface AllOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate, AppointCellDelegate,PayCellDelegate,EvaluateCellDelegate,MyAllCellDelegate>{
    DataResult* appointmentResult;
    DataResult* orderResult;
    
    NSInteger currentAppointIndex;
    NSInteger currentOrderIndex;
    
    NSString* appointmentId;
    
    NSInteger currentCellIndex;
    DataResult* backPriceResult;
    UIView* backPriceBgView;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation AllOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAppiontOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAppiontOrder"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPay"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyEvaluate"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyAllOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAllOrder"];
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AllOrderToDealOrder"]){
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [appointmentResult.items getItem:currentAppointIndex];
        [theSegue setValue:item forKey:@"item"];
    }else if([segue.identifier isEqualToString:@"AllOrderToConfirmOrder"]){
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [orderResult.items getItem:currentOrderIndex-appointmentResult.items.size];
        [theSegue setValue:[item getString:@"OrderNum"] forKey:@"orderNumber"];
    }else if([segue.identifier isEqualToString:@"AllOrderToPostEvaluate"]){
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [orderResult.items getItem:currentCellIndex-appointmentResult.items.size];
        [theSegue setValue:[item getString:@"Organization_Application_ID"] forKey:@"orgId"];
        [theSegue setValue:[item getString:@"courseOrderID"] forKey:@"orderId"];
    }
}


#pragma mark - UItableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return appointmentResult.items.size+orderResult.items.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < appointmentResult.items.size) {
        return  [tableView fd_heightForCellWithIdentifier:@"MyAppiontOrder" cacheByIndexPath:indexPath configuration:^(id cell) {
                    [self congigCell:cell Index:indexPath];
        }];
    }else{
        DataItem* item = [orderResult.items getItem:indexPath.section-appointmentResult.items.size];
        if ([[item getString:@"TradeStatus1"] isEqual:@"未支付"]){
            return  [tableView fd_heightForCellWithIdentifier:@"MyPay" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configPayCell:cell Index:indexPath];
            }];
        }else if([[item getString:@"TradeStatus1"] isEqual:@"已支付"] &&[[item getString:@"EvaluateStatus"] isEqual:@"未评价"]) {
            return  [tableView fd_heightForCellWithIdentifier:@"MyEvaluate" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configEvaluateCell:cell Index:indexPath];
            }];
        }else{
            return  [tableView fd_heightForCellWithIdentifier:@"MyAllOrder" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configAllOrderCell:cell Index:indexPath];
            }];
        }
       
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < appointmentResult.items.size) {
        MyAppiontOrderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyAppiontOrderTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        cell.dealOrderButton.tag =indexPath.section;
        cell.cancelOrderButton.tag = indexPath.section;
        
        [self congigCell:cell Index:indexPath];
        return cell;
    }else{
        DataItem* item = [orderResult.items getItem:indexPath.section-appointmentResult.items.size];
        if ([[item getString:@"TradeStatus1"] isEqual:@"未支付"]) {
            MyPayTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyPayTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            cell.cancelOrderButton.tag = indexPath.section;
            cell.dealOrderButton.tag = indexPath.section;
            [self configPayCell:cell Index:indexPath];
            return cell;
        }else if ([[item getString:@"TradeStatus1"] isEqual:@"已支付"] &&[[item getString:@"EvaluateStatus"] isEqual:@"未评价"]){
            MyEvaluateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyEvaluateTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            cell.cancelOrderButton.tag = indexPath.section;
            cell.dealOrderButton.tag = indexPath.section;
            
            [self configEvaluateCell:cell Index:indexPath];
            return cell;
        }else{
            MyAllOrderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyAllOrderTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            cell.deleteOrderButton.tag = indexPath.section;
            [self configAllOrderCell:cell Index:indexPath];
            return cell;
        }
    }
}


-(void)congigCell:(MyAppiontOrderTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[appointmentResult.items getItem:indexpath.section]];
}

-(void)configPayCell:(MyPayTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section-appointmentResult.items.size]];
}

-(void)configEvaluateCell:(MyEvaluateTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section-appointmentResult.items.size]];
}

-(void)configAllOrderCell:(MyAllOrderTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section-appointmentResult.items.size]];
}

#pragma mark - AppointCellDelegate

-(void)deleteOrderDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentAppointIndex =button.tag;
    appointmentId = [[appointmentResult.items getItem:button.tag] getString:@"User_Appointment_ID"];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定取消预约" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
}

-(void)dealOrderDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentAppointIndex = button.tag;
    [self performSegueWithIdentifier:@"AllOrderToDealOrder" sender:self];
}

#pragma mark - PayCellDelegate

-(void)cancelDelegate:(id)sender{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定取消订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
    
    UIButton* button = (UIButton*)sender;
    currentOrderIndex = button.tag;
    
}

-(void)payDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentOrderIndex = button.tag;
    
    [self performSegueWithIdentifier:@"AllOrderToConfirmOrder" sender:self];
}

#pragma mark - EvaluateCellDelegate

-(void)cancelEvaluateDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentCellIndex = button.tag;
    
    DataItem* item = [orderResult.items getItem:button.tag];
    if ([item getInt:@"IsShare"]==1) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定删除订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
        [alert show];
    }else{
        [self shareUIShow];
    }
}

-(void)evaluateDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentCellIndex = button.tag;
    
    [self performSegueWithIdentifier:@"AllOrderToPostEvaluate" sender:self];
}


#pragma mark - AllOrderCellDelegate

-(void)deleteOrShareOrderDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    currentOrderIndex = button.tag;
    
    if ([button.titleLabel.text isEqualToString:@"  分享抽学费  "]) {
        [self shareUIShow];
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"确定取消订单" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
        [alert show];
        
        UIButton* button = (UIButton*)sender;
        currentOrderIndex = button.tag;
 
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    DataItem* item = [orderResult.items getItem:currentOrderIndex-appointmentResult.items.size];
    
    if (buttonIndex == 1 && currentAppointIndex<appointmentResult.items.size) {
        [self deleteOrderRequest];
    }else if (buttonIndex == 1 ){
        
        if ([[item getString:@"TradeStatus1"] isEqual:@"未支付"]) {
            [self cancelOrderRequest];
        }else if ([[item getString:@"TradeStatus1"] isEqual:@"已支付"]){
            [self deleteUserOrderRequest];
        }
        
    }
}

#pragma mark - NetworkRequest
-(void)deleteOrderRequest{
    [[MyService sharedMyService] deleteUserAppointmentWithParameters:@{@"userAppointmentId":appointmentId} onCompletion:^(id json) {
        [self.tableView.mj_header beginRefreshing];
    } onFailure:^(id json) {
        
    }];
}

-(void)cancelOrderRequest{
    [[MyService sharedMyService] cancelUserOrderWithParameters:@{@"orderNum":[[orderResult.items getItem:currentOrderIndex-appointmentResult.items.size] getString:@"OrderNum"],@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        [self.tableView.mj_header beginRefreshing];
    } onFailure:^(id json) {
        
    }];
}

-(void)deleteUserOrderRequest{
    [[MyService sharedMyService] deleteUserOrderWithParameters:@{@"orderNum":[[orderResult.items getItem:currentCellIndex-appointmentResult.items.size] getString:@"OrderNum"],@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        
        [self.tableView.mj_header beginRefreshing];
    } onFailure:^(id json) {
        
    }];
}

-(void)getAppointListRequest{
    [[MyService sharedMyService] getUserAppointListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        appointmentResult = json;
        [self getOrderListRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)getOrderListRequest{
    [[MyService sharedMyService] getUserOrderListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"orderType":@(2),@"evaluateStatus":@(2)} onCompletion:^(id json) {
        orderResult = json;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}


-(void)getBackPriceRequest{
    [[MyService sharedMyService] getBackPriceWithParameters:@{@"id":[[orderResult.items getItem:currentCellIndex] getString:@"Organization_Application_ID"],@"price":@([[orderResult.items getItem:currentCellIndex-appointmentResult.items.size] getDouble:@"TotalPrice"])} onCompletion:^(id json) {
        backPriceResult = json;
        
        [self updateShareRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)updateShareRequest{
    [[MyService sharedMyService] updateOrderShareWithParameters:@{@"orderId":[[orderResult.items getItem:currentCellIndex-appointmentResult.items.size] getString:@"courseOrderID"]} onCompletion:^(id json) {
        [self addBackPriceRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)addBackPriceRequest{
    [[MyService sharedMyService] addBackPriceWithParameters:@{@"orderId":[[orderResult.items getItem:currentCellIndex-appointmentResult.items.size] getString:@"courseOrderID"],@"price":@""} onCompletion:^(id json) {
        [self updateUserBalanceRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)updateUserBalanceRequest{
    [[MyService sharedMyService] updateUserBalanceWithParameters:@{@"UserId":[UserInfo sharedUserInfo].userID,@"Price":@([backPriceResult.message doubleValue]),@"ChannelName":@"订单返现",@"ChannelCode":[[orderResult.items getItem:currentCellIndex-appointmentResult.items.size] getString:@"courseOrderID"],@"OperationType":@(0)} onCompletion:^(id json) {
        [self shareUIShow];
    } onFailure:^(id json) {
        
    }];
}

#pragma mark - UMShare

-(void)shareUIShow{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareWebPageToPlatformType:platformType];
        
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    UserInfo* info = [UserInfo sharedUserInfo];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:ShareDetailTitle descr:nil thumImage:[UIImage imageNamed:@"ShareLogo"]];
    //设置网页地址
    shareObject.webpageUrl =[NSString stringWithFormat:@"http://www.admin.ings.org.cn/UserRegister/GetCoupon?userId=%@&couponId=",info.userID];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            
            [self getBackPriceRequest];
            
            
        }
    }];
}


-(void)showRewardBackView{
    backPriceBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    
    backPriceBgView.backgroundColor = [UIColor colorWithRed:135/255 green:135/255 blue:135/255 alpha:0.8];
    
    UIImageView* backPriceImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 255, 217)];
    backPriceImage.center = CGPointMake(Main_Screen_Width/2, (Main_Screen_Height-44-64)/2);
    backPriceImage.image = V_IMAGE(@"rewardbg");
    
    
    [backPriceBgView addSubview:backPriceImage];
    
    UILabel* backPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(backPriceImage.frame.origin.x+72, backPriceImage.frame.origin.y+106, 75, 35)];
    backPriceLabel.text = backPriceResult.message;
    backPriceLabel.textColor = [UIColor whiteColor];
    backPriceLabel.backgroundColor = [UIColor clearColor];
    [backPriceBgView addSubview:backPriceLabel];
    
    
    [self.view addSubview:backPriceBgView];
    
    UITapGestureRecognizer* dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissBackPriceView)];
    
    [backPriceBgView addGestureRecognizer:dismissTap];
    
}

-(void)dismissBackPriceView {
    [backPriceBgView removeFromSuperview];
}

@end
