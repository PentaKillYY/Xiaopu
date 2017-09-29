//
//  UserConfirmOrderViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "UserConfirmOrderViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyService.h"
#import "PaySelectCouponTableViewCell.h"
#import "PayTypeTableViewCell.h"
#import "MyCouponSimpleTableViewCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "RedBagService.h"

@interface UserConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate,UIPickerViewDelegate,PayTypeCellDelegate>{
    DataResult* orderResult;
    DataResult* couponResult;
    UILabel* orderNameLabel;
    NSInteger couponNumber;
    UIView* bgView ;
    NSString* payType;
    
    double totalPriceNumber;
    NSString* tradeNo;
    NSInteger payMode;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet UIButton* payButton;
@property(nonatomic,weak)IBOutlet UILabel* totalPrice;
@end

@implementation UserConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"支付订单";
    payType = @"1";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    orderNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, Main_Screen_Width-16, 30)];
    
    orderNameLabel.font = [UIFont systemFontOfSize:13.0];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    [headerView addSubview:orderNameLabel];
    self.tableView.tableHeaderView = headerView;
    
    
    [self getUserOrderInfoRequest];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotificationBack:) name:@"AliPay" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotificationBack:) name:@"WXPay" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AliPay" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXPay" object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([_redBagDic allKeys].count) {
        totalPriceNumber =[[orderResult.items getItem:0] getDouble:@"TotalPrice"]-[[_redBagDic objectForKey:@"RedbagNumber"] doubleValue];
        
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f",totalPriceNumber];
        
    }
    
    [self.tableView reloadData];
}

-(IBAction)payOrderAction:(id)sender{
    if ([payType isEqualToString:@"1"]) {
        [self alipaySignRequest];
    }else{
        [self wxPaySignRequest];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PayToSelectRedBag"]){
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[NSString stringWithFormat:@"%.2f",[[orderResult.items getItem:0] getDouble:@"TotalPrice"]] forKey:@"originPrice"];
        [theSegue setValue:[[orderResult.items getItem:0] getString:@"Organization_Application_ID"] forKey:@"orgId"];
        
        if ([_redBagDic allKeys].count) {
            [theSegue setValue:[_redBagDic objectForKey:@"SelectIndex"] forKey:@"currentindex"];
            [theSegue setValue:[_redBagDic objectForKey:@"IDS"] forKey:@"currentids"];
            [theSegue setValue:[_redBagDic objectForKey:@"RedbagNumber"] forKey:@"currentredbagNumber"];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ConfirmOrderTitle.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        return 105;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        PaySelectCouponTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PaySelectCouponTableViewCell" owner:self options:nil].firstObject;
        if ([_redBagDic allKeys].count){
            cell.couponNumber.text = [NSString stringWithFormat:@"现金红包减%d元",[[_redBagDic objectForKey:@"RedbagNumber"] intValue]];
            cell.couponNumber.textColor = [UIColor redColor];
        }else{
            cell.couponNumber.text = @"不使用红包";
            cell.couponNumber.textColor = [UIColor lightGrayColor];
            
        }

        return cell;
    }else
        if (indexPath.row == 5){
            PayTypeTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PayTypeTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            return cell;
        }else{
            MyInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:self options:nil].firstObject;
            cell.cellTitle.text = ConfirmOrderTitle[indexPath.row];
            cell.cellContent.userInteractionEnabled = NO;
            if (orderResult) {
                if (indexPath.row == 0) {
                    cell.cellContent.text = [[orderResult.items getItem:0] getString:@"OrderNum"];
                }else if (indexPath.row ==1){
                    cell.cellContent.text = [[orderResult.items getItem:0] getString:@"Subject"];
                }else if (indexPath.row ==2){
                    cell.cellContent.text = [UserInfo sharedUserInfo].telphone;
                }else {
                    cell.cellContent.text = [[orderResult.items getItem:0] getString:@"StudentName"];
                }
            }
            return cell;
        }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        [self performSegueWithIdentifier:@"PayToSelectRedBag" sender:self];
    }
}



#pragma mark - PayTypeCellDelegate

-(void)payTypeDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (button.tag == 0) {
        payType = @"1";
    }else{
        payType = @"2";
    }
    payMode = [payType intValue];
    
}

#pragma mark - NetwordRequest

-(void)getUserOrderInfoRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[MyService sharedMyService] getUserOrderInfoWithParameters:@{@"userId":info.userID,@"orderNo":self.orderNumber} onCompletion:^(id json) {
        orderResult = json;
        
        totalPriceNumber =[[orderResult.items getItem:0] getDouble:@"TotalPrice"];
        
        orderNameLabel.text = [[orderResult.items getItem:0] getString:@"OrganizationName"];
        
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f",totalPriceNumber];

        [self.tableView reloadData];
       
    } onFailure:^(id json) {
        
    }];
}



-(void)alipaySignRequest{
    [[MyService sharedMyService] aliPaySignWithParameters:@{@"Title":[[orderResult.items getItem:0] getString:@"Subject"],@"Order_no":[[orderResult.items getItem:0] getString:@"OrderNum"],@"Price":@(totalPriceNumber)} onCompletion:^(id json) {
        DataResult* alipayresult = json;
        
        [[AlipaySDK defaultService] payOrder:alipayresult.message fromScheme:@"xiaopuwang" callback:^(NSDictionary *resultDic) {

            [self payBack:resultDic];
        }];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)wxPaySignRequest{
    [[MyService sharedMyService] wxPaySignWithParameters:@{@"Title":[[orderResult.items getItem:0] getString:@"Subject"],@"Order_no":[[orderResult.items getItem:0] getString:@"OrderNum"],@"Price":@(totalPriceNumber)} onCompletion:^(id json) {
        DataResult* wxpayResult = json;
        
        PayReq *request = [[PayReq alloc] init] ;
        
        request.partnerId = [[wxpayResult.detailinfo getDataItem:@"PayParam"] getString:@"mch_id"];
        request.prepayId= [[wxpayResult.detailinfo getDataItem:@"PayParam"] getString:@"prepayid"];
        request.package = @"Sign=WXPay";
        request.nonceStr = [[wxpayResult.detailinfo getDataItem:@"PayParam"] getString:@"nonce_str"];
        request.timeStamp = (UInt32)[[[wxpayResult.detailinfo getDataItem:@"PayParam"] getString:@"timestamp"] integerValue];
        request.sign = [[wxpayResult.detailinfo getDataItem:@"PayParam"] getString:@"sign"];
        [WXApi sendReq:request];

    } onFailure:^(id json) {
        
    }];
}

-(void)updateOderAfterPayRequest{
    //支付后处理1
    
    [self invalidUserRedBagRequest];
    
    [[MyService sharedMyService] userUpdateOrderAfterPayWithParameters:@{
        @"OrderNum":[[orderResult.items getItem:0] getString:@"OrderNum"],
        @"Organization_Application_ID":[[orderResult.items getItem:0] getString:@"Organization_Application_ID"],
        @"Purchaser":[UserInfo sharedUserInfo].userID,
        @"TradeNo":@"null",
        @"PayMode":@(payMode),
        @"TradeStatus1":@"TRADE_SUCCESS"
    } onCompletion:^(id json) {
        // 支付后处理2
        [self updateUserBalanceRequest];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)updateTotalPriceAfterRequest{
    [[MyService sharedMyService] userUpdateTotaoPriceAfterPayWithParameters:@{
        @"OrderNum":[[orderResult.items getItem:0] getString:@"OrderNum"],
        @"CourseId":@"",
        @"Organization_Application_ID":[[orderResult.items getItem:0] getString:@"Organization_Application_ID"],
        @"Purchaser":[UserInfo sharedUserInfo].userID,
        @"StudentName":[[orderResult.items getItem:0] getString:@"StudentName"],
        @"TotalPrice":@(totalPriceNumber),
        @"OriginalPrice":@([[orderResult.items getItem:0] getDouble:@"TotalPrice"]),
        @"BackPrice":@([[orderResult.items getItem:0] getDouble:@"BackPrice"]),
        @"Subject":[[orderResult.items getItem:0] getString:@"Subject"],
        @"PayType":@([[orderResult.items getItem:0] getInt:@"PayType"]),
        @"RedPackPrice":@([[orderResult.items getItem:0] getDouble:@"TotalPrice"]-totalPriceNumber)
    } onCompletion:^(id json) {
        if ([self.isAll isEqualToString:@"no"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshPay" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAll" object:nil];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(id json) {
        
    }];
}


-(void)updateUserBalanceRequest{
    if ([[orderResult.items getItem:0] getDouble:@"TotalPrice"] > 1000 && [UserInfo sharedUserInfo].recommand.length) {
        [[MyService sharedMyService] updateUserBalanceWithParameters:@{@"UserId":[UserInfo sharedUserInfo].userID,@"Price":@(0),@"ChannelName":@"邀请奖励",@"ChannelCode":@"",@"OperationType":@(0)} onCompletion:^(id json) {
            //支付后处理4
            [self updateTotalPriceAfterRequest];
        } onFailure:^(id json) {
            
        }];
    }else{
        //支付后处理4
        [self updateTotalPriceAfterRequest];
    }
    
}

-(void)invalidUserRedBagRequest{
    if ([_redBagDic allKeys].count) {
        [[RedBagService sharedRedBagService] updateRedBagStateWithParameters:@{@"ids":[_redBagDic objectForKey:@"IDS"]} onCompletion:^(id json) {
            
        } onFailure:^(id json) {
            
        }];

    }
}

#pragma PayCallBack

-(void)payBack:(NSDictionary*)resultDic{
    /*
     1、更新订单信息
     2、推荐人(Recommender)余额增加55
     3、优惠券失效
     4、更新订单TotalPrice
    */
    NSInteger resultCode = [[resultDic objectForKey:@"resultStatus"] intValue];
    if (resultCode == 9000 ) {
        // 1、更新订单信息
        [self updateOderAfterPayRequest];
    }else {
        if ([self.isAll isEqualToString:@"no"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshPay" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAll" object:nil];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)payNotificationBack:(NSNotification *)notification{
    /*
     1、更新订单信息
     2、推荐人(Recommender)余额增加55
     3、优惠券失效
     4、更新订单TotalPrice
     */
    
    
    if ([notification.object isEqualToString:@"success"]){
        // 1、更新订单信息
        [self updateOderAfterPayRequest];
        
    }else{
        if ([self.isAll isEqualToString:@"no"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshPay" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAll" object:nil];
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end
