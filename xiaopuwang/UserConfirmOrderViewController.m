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
@interface UserConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate,UIPickerViewDelegate,PayTypeCellDelegate>{
    DataResult* orderResult;
    DataResult* couponResult;
    UILabel* orderNameLabel;
    NSInteger couponNumber;
    UIView* bgView ;
    UIView* couponView;
    NSMutableArray* selectCouponArray;
    NSString* payType;
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
    selectCouponArray = [NSMutableArray new];
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

-(IBAction)payOrderAction:(id)sender{
    if ([payType isEqualToString:@"1"]) {
        [self alipaySignRequest];
    }else{
        [self wxPaySignRequest];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return couponNumber+1;
    }else{
        return DealOrderTitle.count+1+1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        return 44;
    }else{
        if (indexPath.row == 5) {
            return 105;
        }else{
            return 44;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        MyCouponSimpleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyCouponSimpleTableViewCell" owner:self options:nil].firstObject;

        if (selectCouponArray.count == 0 && indexPath.row == couponNumber) {
            cell.couponSelectImage.image = V_IMAGE(@"roundCheckSelected");
        }else if ([selectCouponArray containsObject:@(indexPath.row)]) {
            cell.couponSelectImage.image = V_IMAGE(@"roundCheckSelected");
        }else{
            cell.couponSelectImage.image = V_IMAGE(@"roundCheck");
        }
        
        if (indexPath.row == couponNumber) {
            cell.couponTitle.text = @"不使用优惠券";
        }
        return cell;
    }else{
        if (indexPath.row == 4) {
            PaySelectCouponTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PaySelectCouponTableViewCell" owner:self options:nil].firstObject;
            if (couponNumber == 0) {
                cell.couponNumber.text = @"不使用优惠券";
            }else{
                cell.couponNumber.text = [NSString stringWithFormat:@"节省%d元",selectCouponArray.count*100];
            }
            return cell;
        }else if (indexPath.row == 5){
            PayTypeTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PayTypeTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            return cell;
        }else{
            MyInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:self options:nil].firstObject;
            cell.cellTitle.text = DealOrderTitle[indexPath.row];
            cell.cellContent.userInteractionEnabled = NO;
            if (orderResult) {
                if (indexPath.row == 0) {
                    cell.cellContent.text = [[orderResult.items getItem:0] getString:@"OrderNum"];
                }else if (indexPath.row ==1){
                    cell.cellContent.text = [[orderResult.items getItem:0] getString:@"Subject"];
                }else if (indexPath.row ==2){
                    cell.cellContent.text = [UserInfo sharedUserInfo].telphone;
                }else{
                    cell.cellContent.text = [[orderResult.items getItem:0] getString:@"StudentName"];
                }
            }
            return cell;
        }

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        if (indexPath.row == couponNumber) {
            [selectCouponArray removeAllObjects];
        }else{
            if ([selectCouponArray containsObject:@(indexPath.row)]) {
                [selectCouponArray removeObject:@(indexPath.row)];
            }else{
                [selectCouponArray addObject:@(indexPath.row)];
            }
        }
        [tableView reloadData];
    }else{
        if (indexPath.row == 4) {
            [self showCouponView];
        }
    }
}

#pragma mark - CouponView
-(void)showCouponView{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    bgView.backgroundColor = [UIColor colorWithRed:135/255 green:135/255 blue:135/255 alpha:0.8];
    [self.view addSubview:bgView];
    
    couponView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height/2)];
    couponView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:couponView];
    
    UILabel* couponTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, Main_Screen_Width, 44)];
    couponTitle.text = @"可用优惠券";
    couponTitle.textAlignment = NSTextAlignmentCenter;
    couponTitle.font = [UIFont systemFontOfSize:15.0];
    [couponView addSubview:couponTitle];
    
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, Main_Screen_Height/2-44, Main_Screen_Width, 44);
    [closeButton setTitle:@"关闭" forState:0];
    [closeButton setTitleColor:[UIColor whiteColor] forState:0];
    [closeButton setBackgroundColor:MAINCOLOR];
    [closeButton addTarget:self action:@selector(dismissCouponView) forControlEvents:UIControlEventTouchUpInside];
    [couponView addSubview:closeButton];
    
    UITableView* couponTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44,Main_Screen_Width , Main_Screen_Height/2-88)];
    couponTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    couponTable.dataSource = self;
    couponTable.delegate = self;
    couponTable.tag =1;
    [couponView addSubview:couponTable];
    
    [UIView animateWithDuration:0.3 animations:^{
        couponView.center = CGPointMake(Main_Screen_Width/2, Main_Screen_Height/4*3);

    } completion:^(BOOL finished) {
        
    }];
}

-(void)dismissCouponView{
    [UIView animateWithDuration:0.3 animations:^{
        couponView.center = CGPointMake(Main_Screen_Width/2, Main_Screen_Height/4+Main_Screen_Height);
        
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        [self.tableView reloadData];
        
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f",[[orderResult.items getItem:0] getDouble:@"TotalPrice"]-selectCouponArray.count*100];

    }];
    
    
}

#pragma mark - PayTypeCellDelegate

-(void)payTypeDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (button.tag == 0) {
        payType = @"1";
    }else{
        payType = @"2";
    }
}

#pragma mark - NetwordRequest

-(void)getUserOrderInfoRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[MyService sharedMyService] getUserOrderInfoWithParameters:@{@"userId":info.userID,@"orderNo":self.orderNumber} onCompletion:^(id json) {
        orderResult = json;
        orderNameLabel.text = [[orderResult.items getItem:0] getString:@"OrganizationName"];
        
        
        double totalPrice = [[orderResult.items getItem:0] getDouble:@"TotalPrice"];
        
        if (totalPrice>100 && totalPrice <1001) {
            couponNumber = 1;
        }else if (totalPrice > 1000 && totalPrice < 5001){
            couponNumber = 2;
        }else if (totalPrice > 5000){
            couponNumber = 3;
        }
        
        for (int i =0; i< couponNumber; i++) {
            
            [selectCouponArray addObject:@(i)];
        }
        
        self.totalPrice.text = [NSString stringWithFormat:@"合计:%.2f",[[orderResult.items getItem:0] getDouble:@"TotalPrice"]-selectCouponArray.count*100];

        [self getUserCouponListRequest];
        
       
    } onFailure:^(id json) {
        
    }];
}


-(void)getUserCouponListRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[MyService sharedMyService] getUserCouponListWithParameters:@{@"userId":info.userID} onCompletion:^(id json) {
        couponResult = json;
        info.userCoupon = [NSString stringWithFormat:@"%ld",couponResult.items.size];
        [info synchronize];
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)alipaySignRequest{
    [[MyService sharedMyService] aliPaySignWithParameters:@{@"title":[[orderResult.items getItem:0] getString:@"Subject"],@"orderNum":[[orderResult.items getItem:0] getString:@"OrderNum"],@"orderPirce":@([[orderResult.items getItem:0] getDouble:@"TotalPrice"]-selectCouponArray.count*100)} onCompletion:^(id json) {
        DataResult* alipayresult = json;
    } onFailure:^(id json) {
        
    }];
}

-(void)wxPaySignRequest{
    [[MyService sharedMyService] wxPaySignWithParameters:@{@"title":[[orderResult.items getItem:0] getString:@"Subject"],@"orderNum":[[orderResult.items getItem:0] getString:@"OrderNum"],@"orderPirce":@([[orderResult.items getItem:0] getDouble:@"TotalPrice"]-selectCouponArray.count*100)} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];
}
@end
