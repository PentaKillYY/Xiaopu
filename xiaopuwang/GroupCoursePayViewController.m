//
//  GroupCoursePayViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCoursePayViewController.h"
#import "GroupCourseService.h"
#import "GroupCourseDetailTableViewCell.h"
#import "PayTypeTableViewCell.h"
#import "GroupCoursePayInfoTitleCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "MyInfoTableViewCell.h"
#import "GroupCoursePayTableViewCell.h"
#import "VerifyRegexTool.h"
@interface GroupCoursePayViewController ()<UITableViewDelegate,UITableViewDataSource,PayTypeCellDelegate,UITextFieldDelegate,GroupCoursePayDelegate>
{
    DataResult*detailResult;
    NSString* payType;
    
    NSInteger payMode;
    NSString* userName;
    NSString* userPhone;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation GroupCoursePayViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotificationBack:) name:@"AliPay" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotificationBack:) name:@"WXPay" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AliPay" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXPay" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupCourseDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"GroupCourseDetailTableViewCell"];
    
    payType = @"1";
    [self gerGroupCourseDetailRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0 || section==2) {
        return 1;
    }else{
        return 3;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        GroupCourseDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailTableViewCell" owner:self options:nil].firstObject;
        [self configCourseDetailCell:cell IndexPath:indexPath];
        return cell;
    }else if (indexPath.section==1){
        if (indexPath.row ==0) {
            GroupCoursePayInfoTitleCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCoursePayInfoTitleCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            MyInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:self options:nil].firstObject;
            cell.cellTitle.text = GroupCourseInfoTitle[indexPath.row-1];
            cell.cellContent.placeholder = GroupCourseInfoPlaceholder[indexPath.row-1];
            cell.cellContent.delegate = self;
            cell.cellContent.tag = indexPath.row;
            if (indexPath.row ==1) {
                cell.cellContent.text = userName;
            }else{
                cell.cellContent.keyboardType = UIKeyboardTypeNumberPad;
                cell.cellContent.text = userPhone;
            }
            return cell;
        }
    }else{
//        PayTypeTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"PayTypeTableViewCell" owner:self options:nil].firstObject;
//        cell.delegate = self;
//        cell.tipLabel.hidden = NO;
//        return cell;
        GroupCoursePayTableViewCell* payCell =[[NSBundle mainBundle] loadNibNamed:@"GroupCoursePayTableViewCell" owner:self options:nil].firstObject;
        payCell.delegate = self;
        
        return payCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
//        return 108;
        return [tableView fd_heightForCellWithIdentifier:@"GroupCourseDetailTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configCourseDetailCell:cell IndexPath:indexPath];
        }];

        
    }else if (indexPath.section==2){
        return 165;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

-(void)configCourseDetailCell:(GroupCourseDetailTableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    [cell bingdingViewModel:detailResult.detailinfo];
}

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)payOrderAction:(id)sender{
    if (userName.length == 0) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"您还未填写姓名"];
    }else if (userPhone.length ==0){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"您还未输入联系方式"];
    }else if (![VerifyRegexTool validateMobile:userPhone]){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"手机号码格式不正确"];
    }else{
        if ([payType isEqualToString:@"1"]) {
            [self alipaySignRequest];
        }else{
            [self wxPaySignRequest];
        }
    }
}

#pragma mark - UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==1) {
        userName = textField.text;
    }else{
        userPhone = textField.text;
    }
}

#pragma mark - GroupCoursePayDelegate
-(void)payType:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (button.tag == 0) {
        payType = @"1";
    }else{
        payType = @"2";
    }
    payMode = [payType intValue];
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


#pragma mark - Networkrequest

-(void)gerGroupCourseDetailRequest{
    [[GroupCourseService sharedGroupCourseService] getGroupCourseDetailWithParameters:@{@"fightCourseId":self.courseId,@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        
        detailResult = json;
        [self.tableView reloadData];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)alipaySignRequest{
    [[GroupCourseService sharedGroupCourseService] groupCoursePayWithParameters:@{@"FightCourseId":self.courseId,@"UserId":[UserInfo sharedUserInfo].userID,@"UserName":userName,@"UserPhone":userPhone,@"PayType":@(1)} onCompletion:^(id json) {
        DataResult* alipayresult = json;
        
        [[AlipaySDK defaultService] payOrder:alipayresult.message fromScheme:@"xiaopuwang" callback:^(NSDictionary *resultDic) {
            [self payBack:resultDic];
        }];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)wxPaySignRequest{
    [[GroupCourseService sharedGroupCourseService] groupCoursePayWithParameters:@{@"FightCourseId":self.courseId,@"UserId":[UserInfo sharedUserInfo].userID,@"UserName":userName,@"UserPhone":userPhone,@"PayType":@(2)} onCompletion:^(id json) {
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

-(void)payBack:(NSDictionary*)resultDic{
   
    NSInteger resultCode = [[resultDic objectForKey:@"resultStatus"] intValue];
    if (resultCode == 9000 ) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
       [[AppCustomHud sharedEKZCustomHud] showTextHud:@"支付失败"];
    }
}


-(void)payNotificationBack:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"success"]){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"支付失败"];
    }
}
@end
