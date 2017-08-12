//
//  MyAddBankCardViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyAddBankCardViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyService.h"
@interface MyAddBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSString* cardUserName;
    NSString* cardNumber;
    NSString* cardBankName;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation MyAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加银行卡";
    
    self.navigationController.navigationBar.barTintColor = SPECIALISTNAVCOLOR;
    
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(30, 5, Main_Screen_Width-60, 35);
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton setTitle:@"确认绑定" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setBackgroundColor:SPECIALISTNAVCOLOR];
    [sendButton addTarget:self action:@selector(judgeCardNameRequest) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
    [footerView addSubview:sendButton];
    
    self.tableView.tableFooterView = footerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTextFieldData{
    cardUserName = @"";
    cardNumber = @"";
    cardBankName = @"";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return AddCardTitle.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* array = [NSArray arrayWithArray:AddCardTitle[section]];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:self options:nil].firstObject;
    if (indexPath.section == 0) {
        cell.cellContent.userInteractionEnabled = NO;
        cell.cellTitle.textColor = [UIColor lightGrayColor];
    }
    
    if (indexPath.row == 2) {
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
    
    cell.cellTitle.text = AddCardTitle[indexPath.section][indexPath.row];
    cell.cellContent.tag = indexPath.row;
    cell.cellContent.delegate = self;
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.cellContent.text = cardUserName;
    }else if (indexPath.row == 1){
        cell.cellContent.text = cardNumber;
    }else if (indexPath.row == 2){
        cell.cellContent.text = cardBankName;
    }
    return cell;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return AddCardBankName.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return AddCardBankName[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    cardBankName = AddCardBankName[row];
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
    if (textField.tag == 0) {
        cardUserName = textField.text;
    }else if (textField.tag == 1){
        cardNumber = textField.text;
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        cardUserName = textField.text;
    }else if (textField.tag == 1){
        cardNumber = textField.text;
    }

}

- (void)doClickBackAction:(id)sender {
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)judgeCardNameRequest{
    
    if (cardUserName.length == 0 ){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyCardUserName];
    }else if (![VerifyRegexTool validateBankCard:cardNumber]) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:CardNumberInvalid];
    }else if(cardBankName.length == 0 ){
        [[AppCustomHud sharedEKZCustomHud] showTextHud:EmptyCardBankName];
    }else{
        [[MyService sharedMyService] judgeCardIsAddWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"cardNum":cardNumber} onCompletion:^(id json) {
            DataResult* result = json;
            if ([result.message isEqualToString:@"1"]) {
                [[AppCustomHud sharedEKZCustomHud] showTextHud:AddExistCard];
            }else{
                [self addCardNumberRequest];
            }
        } onFailure:^(id json) {
            
        }];
    }
}

- (void)addCardNumberRequest{
    [[MyService sharedMyService] addCardWithParameters:@{@"User_Id":[UserInfo sharedUserInfo].userID,@"UserType":@(0),@"UserName":cardUserName,@"CardNum":cardNumber,@"BankName":cardBankName,@"ClassName":@""} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];
}
@end
