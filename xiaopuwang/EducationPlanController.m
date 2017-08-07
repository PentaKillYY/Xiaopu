//
//  EducationPlanController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/19.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "EducationPlanController.h"
#import "HMSegmentedControl.h"
#import "TextFieldTableViewCell.h"
#import "TextViewTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "MultiTagSelectTableViewCell.h"
#import "MainService.h"

@interface EducationPlanController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    NSInteger currentSegIndex;
    
    NSString* pickerString;
}
@end

@implementation EducationPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"教育规划";
   
    [self.tableView registerNib:[UINib nibWithNibName:@"MultiTagSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultiTagSelectTableViewCell"];

    
    [self setUpTableView];
    self.tableView.contentOffset = CGPointMake(0, -45);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTableView
{
    UIView* footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
    
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setFrame:CGRectMake(15, 5, Main_Screen_Width-30, 40)];
    sendButton.backgroundColor = MAINCOLOR;
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton setTitle:@"确认提交" forState:0];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [footerView addSubview:sendButton];
    
    UILabel* tips = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, Main_Screen_Width-30, 20)];
    tips.text = EducationPlanTips;
    tips.textColor = [UIColor blackColor];
    tips.font = [UIFont systemFontOfSize:10.0];
    [footerView addSubview:tips];
    self.tableView.tableFooterView = footerView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (currentSegIndex == 0) {
        return EducationTrainingSchoolTitle.count;
    }else if (currentSegIndex == 1){
        return EducationInternationalSchoolTitle.count;
    }else{
        return EducationBoardSchoolTitle.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 0) {
        if (indexPath.row == EducationTrainingSchoolTitle.count-1){
            return 110;
        }else if (indexPath.row ==0 || indexPath.row == 10){
            return 40;
        }else{
            return 70;
        }
    }else if (currentSegIndex == 1){
        if (indexPath.row ==0 || indexPath.row == 8) {
            return 40;
        }else if (indexPath.row == EducationInternationalSchoolTitle.count-1){
            return 110;
        }else{
            return 70;
        }
    }else{
        if (indexPath.row ==0 || indexPath.row == 9) {
            return 40;
        }else if (indexPath.row == EducationBoardSchoolTitle.count-1){
            return 110;
        }else if (indexPath.row == 10){
            return [tableView fd_heightForCellWithIdentifier:@"MultiTagSelectTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                // configurations
                [self configCell:cell indexPath:indexPath];
                
            }];
        }else {
            return 70;
        }
    }
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"培训学校", @"国际学校", @"海外学校"]];
        segmentedControl.frame = CGRectMake(0 , 0, Main_Screen_Width, 40);
        [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        
        segmentedControl.selectionIndicatorColor = MAINCOLOR;
        segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        [segmentedControl setSelectedSegmentIndex:currentSegIndex];
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
        headerView.backgroundColor = TEXTFIELD_BG_COLOR;
        
        [headerView addSubview:segmentedControl];
        
        return headerView;
}
    

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (currentSegIndex == 0) {
        if (indexPath.row == 0 || indexPath.row == 10) {
            HeaderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableViewCell" owner:self options:nil].firstObject;
            
            cell.headerLabel.text = indexPath.row == 0 ? EducationTrainingSchoolHeader[0]:EducationTrainingSchoolHeader[1];
            return cell;
        }else if (indexPath.row == EducationTrainingSchoolTitle.count-1) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationTrainingSchoolTitle[EducationTrainingSchoolTitle.count-1];
            cell.contentTextView.text = EducationTrainingSchoolPlaceHolder[EducationTrainingSchoolPlaceHolder.count-1];
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationTrainingSchoolTitle[indexPath.row];
            if (indexPath.row != 1 && indexPath.row != 8 ) {
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
                
                cell.contentField.inputAccessoryView = customAccessoryView;
                cell.contentField.inputView = picker;
            }
            cell.contentField.placeholder = EducationTrainingSchoolPlaceHolder[indexPath.row];
            return cell;
        }

    }
    else if (currentSegIndex == 1){
        if (indexPath.row == 0 || indexPath.row == 8) {
            HeaderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableViewCell" owner:self options:nil].firstObject;
            
            cell.headerLabel.text = indexPath.row == 0 ? EducationTrainingSchoolHeader[0]:EducationInternationalSchoolHeader[1];
            return cell;
        }else if (indexPath.row == EducationInternationalSchoolTitle.count-1) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row];
            cell.contentTextView.text = EducationInternationalSchoolPlaceHolder[indexPath.row];
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row];
            if (indexPath.row != 1 && indexPath.row != 7) {
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
                
                cell.contentField.inputAccessoryView = customAccessoryView;
                cell.contentField.inputView = picker;
            }
            cell.contentField.placeholder = EducationInternationalSchoolPlaceHolder[indexPath.row];
            return cell;
        }
    }else{
        if (indexPath.row == 0 || indexPath.row == 9) {
            HeaderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableViewCell" owner:self options:nil].firstObject;
            
            cell.headerLabel.text = indexPath.row == 0 ? EducationTrainingSchoolHeader[0]:EducationInternationalSchoolHeader[1];
            return cell;
        }else if (indexPath.row == EducationBoardSchoolTitle.count -1) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row];
            cell.contentTextView.text = EducationBoardSchoolPlaceHolder[indexPath.row];
            return cell;
        }else if (indexPath.row == 10){
            MultiTagSelectTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MultiTagSelectTableViewCell" owner:self options:nil].firstObject;
            [self configCell:cell indexPath:indexPath];
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row];
            if (indexPath.row != 1 && indexPath.row !=8) {
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
                
                cell.contentField.inputAccessoryView = customAccessoryView;
                cell.contentField.inputView = picker;
            }
            cell.contentField.placeholder = EducationBoardSchoolPlaceHolder[indexPath.row];
            return cell;
        }
    }
    
    
    
    
}

-(void)configCell:(MultiTagSelectTableViewCell*)cell indexPath:(NSIndexPath*)indexPath{
    [cell setTags:@[@"美国",@"加拿大",@"英国",@"澳大利亚",@"新加坡",@"日本",@"其他国家"]];
}

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    
    [self.tableView reloadData];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (currentSegIndex == 0) {
        NSArray* pickerData = [NSArray arrayWithArray:EducationTrainingSchoolPickerData[pickerView.tag]];
        return pickerData.count;
    }else if (currentSegIndex == 1){
        NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag]];
        return pickerData.count;
    }else{
        NSArray* pickerData = [NSArray arrayWithArray:EducationBoardPickerData[pickerView.tag]];
        return pickerData.count;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (currentSegIndex == 0) {
        return EducationTrainingSchoolPickerData[pickerView.tag][row];
    }else if (currentSegIndex == 1){
        return EducationInternationalPickerData[pickerView.tag][row];
    }else{
        return EducationBoardPickerData[pickerView.tag][row];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (currentSegIndex == 0) {
        pickerString = EducationTrainingSchoolPickerData[pickerView.tag][row];
    }else if (currentSegIndex == 1){
        pickerString = EducationInternationalPickerData[pickerView.tag][row];
    }else{
        pickerString = EducationBoardPickerData[pickerView.tag][row];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissInput:(UIBarButtonItem*)item{
    UIBarButtonItem* aitem = item;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:aitem.tag inSection:0];
    TextFieldTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.contentField.text = pickerString;
    [cell.contentField resignFirstResponder];
}
@end
