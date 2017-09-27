//
//  UserDealOrderTableViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "UserDealOrderTableViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyService.h"
#import "RedBagService.h"

@interface UserDealOrderTableViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString* orderNumber;
    NSString* orgID;
    NSString* studentName;
    float originalPrice;
    NSString* subject;
    NSInteger paytype;
}
@end

@implementation UserDealOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"立即下单";
    
    [self loadCelldata];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    UILabel* orderNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, Main_Screen_Width-16, 30)];
    
    orderNameLabel.font = [UIFont systemFontOfSize:13.0];
    orderNameLabel.text = [self.item getString:@"OrganizationName"];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    [headerView addSubview:orderNameLabel];
    self.tableView.tableHeaderView = headerView;
    
    
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(30, 5, Main_Screen_Width-60, 35);
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton setTitle:@"生成订单" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [sendButton setBackgroundColor:MAINCOLOR];
    [sendButton addTarget:self action:@selector(dealOrderRequest) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
    [footerView addSubview:sendButton];
    
    self.tableView.tableFooterView = footerView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadCelldata{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];

    orderNumber = [NSString stringWithFormat:@"On%@",timeLocal];
    orgID = [self.item getString:@"Organization_Application_ID"];
    studentName = @"";
    originalPrice = 0;
    subject = @"";
    paytype = 1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return DealOrderTitle.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:self options:nil].firstObject;
    cell.cellTitle.text = DealOrderTitle[indexPath.row];
    cell.cellContent.tag = indexPath.row;
    cell.cellContent.delegate = self;
    
    if (indexPath.row == 0) {
        cell.cellContent.text = orderNumber;
        cell.cellContent.userInteractionEnabled = NO;
    }else if (indexPath.row == 2){
        cell.cellContent.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (indexPath.row == 3){
        cell.cellContent.text = [UserInfo sharedUserInfo].telphone;
        cell.cellContent.userInteractionEnabled = NO;
    }else if (indexPath.row == 5){
    
        if (indexPath.row !=0) {
            UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 180)];
            picker.delegate = self;
            picker.dataSource = self;
            picker.backgroundColor = [UIColor whiteColor];
            picker.tag = indexPath.row;
            
            UIToolbar*customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,Main_Screen_Width,40}];
            customAccessoryView.barTintColor = [UIColor whiteColor];
            UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissInput:)];
            finish.tag = indexPath.row;
            [customAccessoryView setItems:@[space,space,finish]];
            
            cell.cellContent.inputAccessoryView = customAccessoryView;
            cell.cellContent.inputView = picker;
        }
    
    }
    
    
    if (indexPath.row == 1) {
        cell.cellContent.text = subject;
    }else if (indexPath.row == 2 && originalPrice>0){
        cell.cellContent.text =  [NSString stringWithFormat:@"%.2f",originalPrice];
    }else if (indexPath.row == 4){
        cell.cellContent.text = studentName;
    }else if (indexPath.row == 5 ){
        
        cell.cellContent.text = PayType[paytype-1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return PayType.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return PayType[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    paytype = row+1;
}

//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 35)];
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)dismissInput:(UIBarButtonItem*)item{
    UIBarButtonItem* aitem = item;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:aitem.tag inSection:0];
    MyInfoTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [cell.cellContent resignFirstResponder];
    
    [self.tableView reloadData];
}


#pragma mark - UITextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        subject = textField.text;
    }else if (textField.tag == 2){
        originalPrice = [textField.text floatValue];
    }else if (textField.tag == 4){
        studentName = textField.text;
    }
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        subject = textField.text;
    }else if (textField.tag == 2){
        originalPrice = [textField.text floatValue];
    }else if (textField.tag == 4){
        studentName = textField.text;
    }
}


#pragma mark - NetworkRequest
-(void)dealOrderRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    //1线上  2线下
    
    if(originalPrice == 0){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"下单金额不能为0"];
    }else if (orgID.length >0 && studentName.length >0 &&subject.length>0 && paytype>0) {
        [[MyService sharedMyService] userMakeOrderWithParameters:@{@"OrderNum":orderNumber,@"CourseId":@"",@"Organization_Application_ID":orgID,@"Purchaser":info.userID,@"StudentName":studentName,@"TotalPrice":@(originalPrice),@"OriginalPrice":@(originalPrice),@"BackPrice":@(0),@"Subject":subject,@"PayType":@(paytype)} onCompletion:^(id json) {
            
            [self updateOrderRequest];
        } onFailure:^(id json) {
            
        }];
        
        if (paytype ==1) {
            
            //下单得红包
            [self redBagByDealOrderRequest];
            
        }
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"下单内容不完整"];
    }
    
}


-(void)updateOrderRequest{
    
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[MyService sharedMyService] updateUserAppointmentWithParameters:@{@"orgApplication_ID":orgID,@"userId":info.userID} onCompletion:^(id json) {
        if ([self.isAll isEqualToString:@"no"]) {
           [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAppointment" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAll" object:nil];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(id json) {
        
    }];
}

-(void)redBagByDealOrderRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[RedBagService sharedRedBagService] getRedBagByConfirmOrderWithParameters:@{@"userId":info.userID,@"organization_Application_ID":orgID} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];
}
@end
