//
//  MyInfoTableViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyInfoTableViewController.h"
#import "MyInfoTableViewCell.h"
#import "MyService.h"
#import "SchoolService.h"
@interface MyInfoTableViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    DataResult* countryResult;
    DataResult* provinceResult;
    DataResult* cityResult;
    
    NSString* pickerString;
    NSString* selectCountryId;
    NSString* selectProvinceId;
    
    
    NSString* userName;
    NSString* userGender;
    NSString* userCountry;
    NSString* userProvince;
    NSString* userCity;
}
@end

@implementation MyInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(updateInfoRequest:)];
    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = rightItm;

    [self loadUserInfo];
    
    [self getSchoolCountryListRequest];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadUserInfo{
    UserInfo *info = [UserInfo sharedUserInfo];
    if (info.username.length) {
        userName = info.username;
    }else{
        userName = @"";
    }
    
    if (info.userGender.length) {
        userGender = info.userGender;
    }else{
        userGender = @"";
    }
    
    if (info.userCountry) {
        userCountry=info.userCountry;
    }else{
        userCountry = @"";
    }
    
    if (info.userProvince) {
        userProvince=info.userProvince;
    }else{
        userProvince = @"";
    }
    
    if (info.userCity) {
        userCity = info.userCity;
    }else{
        userCity=@"";
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyInfoTableViewCell" owner:self options:nil].firstObject;
    cell.cellTitle.text = MyInfoTitle[indexPath.row];
    cell.cellContent.tag = indexPath.row;
    cell.cellContent.delegate = self;
    
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

    if (indexPath.row == 0) {
        cell.cellContent.text = userName;
    }else if (indexPath.row ==1){
        cell.cellContent.text = userGender;
    }else if (indexPath.row ==2){
        cell.cellContent.text = userCountry;
    }else if (indexPath.row==3){
        cell.cellContent.text = userProvince;
    }else{
        cell.cellContent.text = userCity;
    }
    return cell;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag == 1){
        return Gender.count;
    }else if (pickerView.tag == 2){
        return countryResult.items.size;
    }else if(pickerView.tag == 3){
        return provinceResult.items.size;
    }else{
        return cityResult.items.size;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return Gender[row];
    }else if (pickerView.tag ==2){
        return [[countryResult.items getItem:row] getString:@"text"];
    }else if (pickerView.tag == 3){
        return [[provinceResult.items getItem:row] getString:@"text"];
    }else{
        return [[cityResult.items getItem:row] getString:@"text"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        userGender = Gender[row];
    }else if (pickerView.tag == 2){
        selectCountryId = [[countryResult.items getItem:row] getString:@"value"];
        userCountry = [[countryResult.items getItem:row] getString:@"text"];
        [self getSchoolProvinceListRequest];
    }else if (pickerView.tag == 3){
        selectProvinceId = [[provinceResult.items getItem:row] getString:@"value"];
        userProvince = [[provinceResult.items getItem:row] getString:@"text"];
        [self getSchoolCityLIstRequest];
    }else{
        userCity = [[cityResult.items getItem:row] getString:@"text"];
    }
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
        userName = textField.text;
    }
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - NetWorkRequest

-(void)updateInfoRequest:(id)sender{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[MyService sharedMyService] updateUserInfoWithParameters:@{
                                                                @"UserId":info.userID,
                                                                @"UserName":userName,
                                                                @"UserNickName":userName,
                                                                @"Sex":userGender,
                                                                @"Birthday":@"",
                                                                @"Country":userCountry,
                                                                @"Province":userProvince,
                                                                @"City":userCity,
                                                                @"SchoolStatus":@"",
                                                                @"School":@"",
                                                                @"UserQQ":@"",
                                                                @"Grade":@"",
                                                                @"Major":@"",
                                                                @"AverageScore":@""} onCompletion:^(id json) {
                                                                    
                                                                    UserInfo* info = [UserInfo sharedUserInfo];
                                                                    info.username = userName;
                                                                    info.userGender= userGender;
                                                                    info.userCountry = userCountry;
                                                                    info.userProvince = userProvince;
                                                                    info.userCity = userCity;
                                                                    [self.navigationController popViewControllerAnimated:YES];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolCountryListRequest{
    [[SchoolService sharedSchoolService] getSchoolCountryListonCompletion:^(id json) {
        countryResult = json;
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolProvinceListRequest{
    [[SchoolService sharedSchoolService] getSchoolProvinceListWithParameters:@{@"countryId":selectCountryId} onCompletion:^(id json) {
        provinceResult = json;
    } onFailure:^(id json) {
        
    }];
    
}


-(void)getSchoolCityLIstRequest{
    [[SchoolService sharedSchoolService] getSchoolCityListWithParameters:@{@"provinceId":selectProvinceId} onCompletion:^(id json) {
        cityResult= json;
    } onFailure:^(id json) {
        
    }];
}

@end
