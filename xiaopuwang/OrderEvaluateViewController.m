//
//  OrderEvaluateViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/14.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrderEvaluateViewController.h"
#import "MyEvaluateTableViewCell.h"
#import "MyService.h"
@interface OrderEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource,EvaluateCellDelegate,UIAlertViewDelegate>{
    DataResult* orderResult;
    NSInteger currentCellIndex;
    DataResult* backPriceResult;
    UIView* backPriceBgView;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation OrderEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"MyEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyEvaluate"];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self getOrderListRequest];
    }];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return orderResult.items.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [tableView fd_heightForCellWithIdentifier:@"MyEvaluate" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self congigCell:cell Index:indexPath];
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyEvaluateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyEvaluateTableViewCell" owner:self options:nil].firstObject;
    cell.delegate = self;
    cell.cancelOrderButton.tag = indexPath.section;
    cell.dealOrderButton.tag = indexPath.section;
    
    [self congigCell:cell Index:indexPath];
    return cell;
}

-(void)congigCell:(MyEvaluateTableViewCell*)cell Index:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:[orderResult.items getItem:indexpath.section]];
}

#pragma mark - EvaluateCellDelegate

-(void)cancelDelegate:(id)sender{
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
}

#define UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self deleteUserOrderRequest];
    }
}


#pragma mark - NetworkRequest

-(void)getOrderListRequest{
    [[MyService sharedMyService] getUserOrderListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"orderType":@(1),@"evaluateStatus":@(0)} onCompletion:^(id json) {
        orderResult = json;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)deleteUserOrderRequest{
    [[MyService sharedMyService] deleteUserOrderWithParameters:@{@"orderNum":[[orderResult.items getItem:currentCellIndex] getString:@"OrderNum"],@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        
        [self.tableView.mj_header beginRefreshing];
    } onFailure:^(id json) {
        
    }];
}

-(void)getBackPriceRequest{
    [[MyService sharedMyService] getBackPriceWithParameters:@{@"id":[[orderResult.items getItem:currentCellIndex] getString:@"Organization_Application_ID"],@"price":@([[orderResult.items getItem:currentCellIndex] getDouble:@"TotalPrice"])} onCompletion:^(id json) {
        backPriceResult = json;
        
        [self updateShareRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)updateShareRequest{
    [[MyService sharedMyService] updateOrderShareWithParameters:@{@"orderId":[[orderResult.items getItem:currentCellIndex] getString:@"courseOrderID"]} onCompletion:^(id json) {
        [self addBackPriceRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)addBackPriceRequest{
    [[MyService sharedMyService] addBackPriceWithParameters:@{@"orderId":[[orderResult.items getItem:currentCellIndex] getString:@"courseOrderID"],@"price":@""} onCompletion:^(id json) {
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
