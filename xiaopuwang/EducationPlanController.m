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
#import "DoubleCheckBoxTableViewCell.h"
#import "MultiCheckBoxTableViewCell.h"
@interface EducationPlanController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    NSInteger currentSegIndex;
    
    NSString* pickerString;
}
@end

@implementation EducationPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerNib:[UINib nibWithNibName:@"TextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextFieldTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TextViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextViewTableViewCell"];
    
    self.title = @"教育规划";
    
    [self setUpTableView];
    self.tableView.contentOffset = CGPointMake(0, -50);
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTableView
{
    UIView* footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setFrame:CGRectMake(80, 5, Main_Screen_Width-160, 40)];
    sendButton.backgroundColor = MAINCOLOR;
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton setTitle:@"确认提交" forState:0];
    
    [footerView addSubview:sendButton];
    
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
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 0) {
        if (indexPath.row == 11) {
            return 90;
        }else{
            return [tableView fd_heightForCellWithIdentifier:@"TextFieldTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                // configurations
            }];
            
        }
    }else if (currentSegIndex == 1){
        if (indexPath.row == 3) {
            return 80;
        }else if (indexPath.row == 8){
            return 90;
        }else{
            return [tableView fd_heightForCellWithIdentifier:@"TextFieldTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                // configurations
            }];

        }
    }else{
        if (indexPath.row == 3) {
            return 80;
        }else if (indexPath.row == 7){
            return 80;
        }else if (indexPath.row == 10){
            return 90;
        }else{
            return [tableView fd_heightForCellWithIdentifier:@"TextFieldTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                // configurations
            }];

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
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    headerView.backgroundColor = [UIColor lightGrayColor];

    [headerView addSubview:segmentedControl];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (currentSegIndex == 0) {
        if (indexPath.row == 11) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationTrainingSchoolTitle[indexPath.row];
            cell.contentTextView.text = EducationTrainingSchoolPlaceHolder[indexPath.row];
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationTrainingSchoolTitle[indexPath.row];
            if (indexPath.row != 6 && indexPath.row != 7) {
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

    }else if (currentSegIndex == 1){
        if (indexPath.row == 8) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row];
            cell.contentTextView.text = EducationInternationalSchoolPlaceHolder[indexPath.row];
            return cell;
        }else if (indexPath.row == 3){
            DoubleCheckBoxTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"DoubleCheckBoxTableViewCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row];
            if (indexPath.row != 5) {
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
        if (indexPath.row == 10) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row];
            cell.contentTextView.text = EducationBoardSchoolPlaceHolder[indexPath.row];
            return cell;
        }else if (indexPath.row == 3){
            DoubleCheckBoxTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"DoubleCheckBoxTableViewCell" owner:self options:nil].firstObject;
            return cell;
        }else if (indexPath.row == 7){
            MultiCheckBoxTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MultiCheckBoxTableViewCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row];
            if (indexPath.row != 6) {
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
