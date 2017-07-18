//
//  ActivityWebViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ActivityWebViewController.h"
#import "ActivityBannerCell.h"
#import "ActivityDetailCell.h"
#import "ActivityPickerCell.h"
#import "ActivityGenderTableViewCell.h"
#import "ActivityTextViewTableViewCell.h"
#import "ActivityTextFieldCell.h"
#import "ActivityEmptyTextViewCell.h"
#import "ActivityEmptyTextFieldCell.h"
@implementation ActivityWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton* footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerButton setFrame:CGRectMake(50, 5, Main_Screen_Width-100, 40)];
    [footerButton setBackgroundColor:MAINCOLOR];
    [footerButton setTitle:@"提交" forState:0];
    [footerButton.layer setCornerRadius:3.0];
    [footerButton.layer setMasksToBounds:YES];
    
    UIView* footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    [footerview addSubview:footerButton];
    
    
    self.tableView.tableFooterView = footerview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.activityType intValue] == 0) {
        return 11;
    }else{
        return 6;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        ActivityBannerCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityBannerCell" owner:self options:nil].firstObject;
        return cell;
    }else{
        if ([self.activityType intValue] == 0) {
            if (indexPath.row == 1) {
                ActivityDetailCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityDetailCell" owner:self options:nil].firstObject;
                return cell;
            }else if (indexPath.row == 3){
                ActivityPickerCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityPickerCell" owner:self options:nil].firstObject;
                
                picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, Main_Screen_Width, 180)];
                picker.datePickerMode = UIDatePickerModeDate;
                picker.backgroundColor = [UIColor whiteColor];
                
                UIToolbar*customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,Main_Screen_Width,40}];
                customAccessoryView.barTintColor = [UIColor whiteColor];
                UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
                UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissInput)];
                [customAccessoryView setItems:@[space,space,finish]];
                
                [picker addTarget:self action:@selector(seletedBirthyDate:) forControlEvents:UIControlEventValueChanged];

                
                cell.dateTextField.inputAccessoryView = customAccessoryView;
                cell.dateTextField.inputView = picker;
                
                return cell;
            }else if (indexPath.row == 4){
                ActivityGenderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityGenderTableViewCell" owner:self options:nil].firstObject;
                return cell;
            }else if (indexPath.row == 10){
                ActivityTextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityTextViewTableViewCell" owner:self options:nil].firstObject;
                return cell;
            }else{
                ActivityTextFieldCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityTextFieldCell" owner:self options:nil].firstObject;
                cell.contentTextField.delegate = self;
            
                return cell;
            }
        }else{
        
            if (indexPath.row == 3) {
                ActivityEmptyTextFieldCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityEmptyTextFieldCell" owner:self options:nil].firstObject;
                return cell;
            }else if (indexPath.row == 5){
                ActivityTextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityTextViewTableViewCell" owner:self options:nil].firstObject;
                return cell;
            }else{
                ActivityEmptyTextFieldCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ActivityEmptyTextFieldCell" owner:self options:nil].firstObject;
                cell.contentTextField.delegate = self;
                return cell;
            }
        }
    
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return (Main_Screen_Width-10)/2;
    }else{
        if ([self.activityType intValue] == 0) {
            if (indexPath.row == 1) {
                return 50;
            }else if (indexPath.row == 3){
                return 88;
            }else if (indexPath.row == 4){
                return 104;
            }else if (indexPath.row == 10){
                return 82;
            }else{
                return 90;
            }
  
        }else{
            if (indexPath.row == 3) {
                return 44;
            }else if (indexPath.row == 5){
                return 108;
            }else{
                return 44;
            }

        }
    }
}

-(void)dismissInput{
    if ([self.activityType intValue] == 0) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        ActivityPickerCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell.dateTextField resignFirstResponder];
    }
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

-(void)seletedBirthyDate:(id)sender{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    ActivityPickerCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.dateTextField.text = [self stringFromDate: picker.date];
    [cell layoutSubviews];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
