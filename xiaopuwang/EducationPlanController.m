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
#import "MainService.h"
#import "IQUIView+IQKeyboardToolbar.h"

@interface EducationPlanController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate>{
    NSInteger currentSegIndex;
    NSInteger currentPickerComponent;
    
    NSString* pickerString;
    
    NSString* trainingGrade;
    NSString* trainingSchool;
    NSString* trainingCourse;
    NSString* trainingLocation;
    NSString* trainingPhone;
    
    NSString* internationalGrade;
    NSString* internationalSchool;
    NSString* internationalCity;
    NSString* internationalWhen;
    NSString* internationalDirection;
    NSString* internationalPhone;

    NSString* overseaGrade;
    NSString* overseaSchool;
    NSString* overseaCountry;
    NSString* overseaRequirement;
    NSString* overseaWantSchool;
    NSString* overseaWantCourse;
    NSString* overseaWhen;
    NSString* overIsExam;
    NSString* overseaExamScore;
    NSString* overseaPhone;
    
}

@property (nonatomic,strong) UIButton* rightButton;
@end

@implementation EducationPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"教育规划";
    currentSegIndex = [self.currentSelectIndex intValue];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"MultiTagSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultiTagSelectTableViewCell"];

    [self setUpTableView];
    [self setupTitleView];
   
    [self setupTrainingParameter];
    [self setupInternationalParameter];
    [self setupOverseaParameter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTitleView{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightButton addTarget:self action:@selector(shareEducationPlan) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setImage:V_IMAGE(@"GroupCourseShare 2") forState:0];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightItem];
}

-(void)setUpTableView
{
    self.tableView.contentOffset = CGPointMake(0, -45);
    
    UIView* footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
    
    UIButton* sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setFrame:CGRectMake(15, 5, Main_Screen_Width-30, 40)];
    sendButton.backgroundColor = MAINCOLOR;
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setMasksToBounds:YES];
    [sendButton setTitle:@"确认提交" forState:0];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [sendButton addTarget:self action:@selector(postSpecialist:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:sendButton];
    
    UILabel* tips = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, Main_Screen_Width-30, 20)];
    tips.text = EducationPlanTips;
    tips.textColor = [UIColor blackColor];
    tips.font = [UIFont systemFontOfSize:10.0];
    [footerView addSubview:tips];
    self.tableView.tableFooterView = footerView;
}

-(void)setupTrainingParameter{
    trainingGrade = @"";
    trainingSchool = @"";
    trainingCourse = @"";
    trainingLocation = @"";
    trainingPhone = @"";
}

-(void)setupInternationalParameter{
    internationalGrade = @"";
    internationalSchool = @"";
    internationalCity = @"";
    internationalWhen = @"";
    internationalDirection = @"";
    internationalPhone = @"";
}

-(void)setupOverseaParameter{
    overseaGrade = @"";
    overseaSchool = @"";
    overseaCountry = @"";
    overseaRequirement = @"";
    overseaWantSchool = @"";
    overseaWantCourse = @"";
    overseaWhen = @"";
    overIsExam = @"";
    overseaExamScore = @"";
    overseaPhone = @"";
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
    if (currentSegIndex == 0 || currentSegIndex == 1) {
        if (indexPath.row==0) {
            return 34;
        }else{
            return 70;
        }
    }else{
        if (indexPath.row ==0) {
            return 34;
        }else if (indexPath.row==4){
            return 110;
        }else{
            return 70;
        }
    }

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"培训规划", @"国际选校规划", @"留学规划"]];
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
    if (indexPath.row==0) {
        HeaderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableViewCell" owner:self options:nil].firstObject;
        
        cell.headerLabel.text = EducationTrainingSchoolHeader[0];
        return cell;

    }else{
        if (currentSegIndex == 0) {
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.tag = indexPath.row;
            
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationTrainingSchoolTitle[indexPath.row];
            cell.contentField.placeholder = EducationTrainingSchoolPlaceHolder[indexPath.row];
            
            [cell.contentField addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
            
            if (indexPath.row==1) {
                UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 180)];
                picker.delegate = self;
                picker.dataSource = self;
                picker.backgroundColor = [UIColor whiteColor];
                picker.tag = indexPath.row;
                cell.contentField.inputView = picker;
                
            }
            
            if (indexPath.row==1) {
                cell.contentField.text = trainingGrade;
            }else if (indexPath.row==2){
                cell.contentField.text = trainingSchool;
            }else if (indexPath.row==3){
                cell.contentField.text = trainingCourse;
            }else if (indexPath.row==4){
                cell.contentField.text = trainingLocation;
            }else{
                cell.contentField.text = trainingPhone;
            }
            
            return cell;
        }else if (currentSegIndex ==1){
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.tag = indexPath.row;
            
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row];
            cell.contentField.placeholder = EducationInternationalSchoolPlaceHolder[indexPath.row];
            [cell.contentField addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
            if (indexPath.row==1 || indexPath.row==3 || indexPath.row==4 || indexPath.row ==5) {
                UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 180)];
                picker.delegate = self;
                picker.dataSource = self;
                picker.backgroundColor = [UIColor whiteColor];
                picker.tag = indexPath.row;
                cell.contentField.inputView = picker;
            }
            
            if (indexPath.row==1) {
                cell.contentField.text = internationalGrade;
            }else if (indexPath.row==2){
                cell.contentField.text = internationalSchool;
            }else if (indexPath.row==3){
                cell.contentField.text = internationalCity;
            }else if (indexPath.row==4){
                cell.contentField.text = internationalWhen;
            }else if (indexPath.row==5){
                cell.contentField.text = internationalDirection;
            }else{
                cell.contentField.text = internationalPhone;
            }
            
            return cell;

        }else{
            if (indexPath.row==4) {
                TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
                cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row];
                cell.contentTextView.text = overseaRequirement;
                cell.contentTextView.delegate = self;
                return cell;
            }else{
                TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
                cell.contentField.tag = indexPath.row;
                
                cell.contentField.delegate = self;
                cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row];
                cell.contentField.placeholder = EducationBoardSchoolPlaceHolder[indexPath.row];
                [cell.contentField addDoneOnKeyboardWithTarget:self action:@selector(doneAction:)];
                if (indexPath.row==1 || indexPath.row==3 || indexPath.row==7 || indexPath.row ==8 || indexPath.row==9) {
                    UIPickerView* picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 180)];
                    picker.delegate = self;
                    picker.dataSource = self;
                    picker.backgroundColor = [UIColor whiteColor];
                    picker.tag = indexPath.row;
                    cell.contentField.inputView = picker;
                }
                
                if (indexPath.row==1) {
                    cell.contentField.text = overseaGrade;
                }else if (indexPath.row==2){
                    cell.contentField.text = overseaSchool;
                }else if (indexPath.row==3){
                    cell.contentField.text = overseaCountry;
                }else if (indexPath.row==5){
                    cell.contentField.text = overseaWantSchool;
                }else if (indexPath.row==6){
                    cell.contentField.text = overseaWantCourse;
                }else if(indexPath.row==7){
                    cell.contentField.text = overseaWhen;
                }else if (indexPath.row==8){
                    cell.contentField.text = overIsExam;
                }else if (indexPath.row==9){
                    cell.contentField.text = overseaExamScore;
                }else{
                    cell.contentField.text = overseaPhone;
                }
                
                return cell;

            }
            
        }
    }

}

#pragma mark - SegmentControlChangeValue

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    
    [self.tableView reloadData];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (currentSegIndex==1 && pickerView.tag ==3) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (currentSegIndex==0) {
        NSArray* pickerData = [NSArray arrayWithArray:EducationTrainingSchoolPickerData[pickerView.tag]];
        return pickerData.count;
    }else if (currentSegIndex==1){
        if (pickerView.tag ==3) {
            NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"allprovinces" ofType:@"json"];
            NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
            NSMutableArray *typeArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];

            if (component==0) {
                return typeArray.count;
            }else{
                NSDictionary* dic = [NSDictionary dictionaryWithDictionary:typeArray[currentPickerComponent]];
                NSArray * array = [NSArray arrayWithArray:[dic objectForKey:@"cities"]];
                return array.count;
            }
        }else{
            NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag]];
            return pickerData.count;
        }
        
    }else{
        NSArray* pickerData = [NSArray arrayWithArray:EducationBoardPickerData[pickerView.tag]];
        return pickerData.count;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (currentSegIndex==0) {
        NSArray* pickerData = [NSArray arrayWithArray:EducationTrainingSchoolPickerData[pickerView.tag]];
        
        return pickerData[row];
    }else if (currentSegIndex==1){
        if (pickerView.tag ==3) {
            NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"allprovinces" ofType:@"json"];
            NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
            NSMutableArray *typeArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            if (component==0) {
                NSDictionary* dic = [NSDictionary dictionaryWithDictionary:typeArray[row]];
                return [dic objectForKey:@"name"];
            }else{
                NSDictionary* dic = [NSDictionary dictionaryWithDictionary:typeArray[currentPickerComponent]];
                NSArray * array = [NSArray arrayWithArray:[dic objectForKey:@"cities"]];
                return array[row];
            }
        }else{
            NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag]];
            
            return pickerData[row];
        }
    }else{
        NSArray* pickerData = [NSArray arrayWithArray:EducationBoardPickerData[pickerView.tag]];
        
        return pickerData[row];
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
    if (currentSegIndex ==1 && pickerView.tag ==3 && component==0) {
        currentPickerComponent = row;
        [pickerView reloadComponent:1];
    }else{
        if (currentSegIndex ==0) {
            NSArray* pickerData = [NSArray arrayWithArray:EducationTrainingSchoolPickerData[pickerView.tag]];
            if (row>0) {
                trainingGrade = pickerData[row];
            }else{
                trainingGrade = @"";
            }
        }else if (currentSegIndex ==1){
            if (pickerView.tag == 1) {
                NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag]];
                if (row>0) {
                    internationalGrade = pickerData[row];
                }else{
                    internationalGrade = @"";
                }
                
            }else if(pickerView.tag == 3){
                NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"allprovinces" ofType:@"json"];
                NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
                NSMutableArray *typeArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
                NSDictionary* provinceDic = [NSDictionary dictionaryWithDictionary:typeArray[row]];
                NSDictionary* cityDic = [NSDictionary dictionaryWithDictionary:typeArray[currentPickerComponent]];
                NSArray * array = [NSArray arrayWithArray:[cityDic objectForKey:@"cities"]];
                if (row>0) {
                    internationalCity = [NSString stringWithFormat:@"%@ - %@",[provinceDic objectForKey:@"name"],array[row]];
                }else{
                    internationalCity = @"";
                }
                
            }else if(pickerView.tag == 4){
                NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag]];
                if (row>0) {
                    internationalWhen = pickerData[row];
                }else{
                    internationalWhen = @"";
                }
                
            }else if(pickerView.tag == 5){
                NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag]];
                if (row>0) {
                    internationalDirection = pickerData[row];
                }else{
                    internationalDirection = @"";
                }
                
            }
        }else{
            NSArray* pickerData = [NSArray arrayWithArray:EducationBoardPickerData[pickerView.tag]];
            if (pickerView.tag == 1) {
                if (row>0) {
                    overseaGrade = pickerData[row];
                }else{
                    overseaGrade = @"";
                }
            }else if (pickerView.tag ==3){
                if (row>0) {
                    overseaCountry = pickerData[row];
                }else{
                    overseaCountry = @"";
                }
            }else if (pickerView.tag ==7){
                if (row>0) {
                    overseaWhen = pickerData[row];
                }else{
                    overseaWhen = @"";
                }
            }else if (pickerView.tag ==8){
                if (row>0) {
                    overIsExam = pickerData[row];
                }else{
                    overIsExam = @"";
                }
            }else{
                if (row>0) {
                    overseaExamScore = pickerData[row];
                }else{
                    overseaExamScore = @"";
                }
            }
        }
        
    }
    
}

-(void)doneAction:(UITextField*)field{
    [self.tableView reloadData];
}

-(void)postSpecialist:(id)sender{
    if ([UserInfo sharedUserInfo].userID) {
        if (currentSegIndex == 0) {
            [self postTrainingSchoolRequest];
        }else if (currentSegIndex == 1){
            [self postInternationalSchoolRequest];
        }else{
            [self postOverseaSchoolRequest];
        }
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([UserInfo sharedUserInfo].userID) {
        
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger tag = textField.tag;
    if (currentSegIndex==0) {
        
        switch (tag) {
            case 2:
            {
                trainingSchool = textField.text;
            }
                break;
            case 3:
            {
                trainingCourse = textField.text;
            }
                break;
            case 4:
            {
                trainingLocation = textField.text;
            }
                break;
            case 5:
            {
                trainingPhone = textField.text;
            }
                break;
        }
    }else if (currentSegIndex==1){
        switch (tag) {
            case 2:
            {
                internationalSchool = textField.text;
            }
                break;
            case 6:
            {
                internationalPhone = textField.text;
            }
                break;
        }

    }else{
        switch (tag){
            case 2:
            {
                overseaSchool = textField.text;
            }
                break;
            case 5:
            {
                overseaWantSchool = textField.text;
            }
                break;
            case 6:
            {
                overseaWantCourse = textField.text;
            }
                break;
            case 10:
            {
                overseaPhone = textField.text;
            }
                break;
        }
    }
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([UserInfo sharedUserInfo].userID) {
        
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    overseaRequirement = textView.text;
}

#pragma mark - NetworkRequest
-(void)postTrainingSchoolRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (![VerifyRegexTool validateMobile:trainingPhone]) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:InvalidPhone];

    }else if (trainingGrade.length && trainingSchool.length && trainingCourse.length && trainingLocation.length && trainingPhone.length) {
        [[MainService sharedMainService] postSpecialistOrgWithParameters:@{
            @"Id":@"",@"UserId":info.userID,@"InGrade":trainingGrade,
            @"InSchool":trainingSchool,@"SignUpTrainCourse":trainingCourse,
            @"TrainAddress":trainingLocation,@"Contact":trainingPhone}
        onCompletion:^(id json) {
            [[AppCustomHud sharedEKZCustomHud] showTextHud:SuccessSpecialistPost];
            [self.navigationController popViewControllerAnimated:YES];
        } onFailure:^(id json) {
                                                                
        }];

    }else{
       [[AppCustomHud sharedEKZCustomHud] showTextHud:@"填写资料不完整"];
    }
}

-(void)postInternationalSchoolRequest{
    UserInfo* info = [UserInfo sharedUserInfo];

    if (![VerifyRegexTool validateMobile:internationalPhone]) {
       [[AppCustomHud sharedEKZCustomHud] showTextHud:InvalidPhone];
    }else if (internationalGrade.length && internationalSchool.length && internationalCity.length && internationalWhen.length && internationalDirection.length && internationalPhone.length){
        [[MainService sharedMainService] postSpecialistChinaSchoolWithParameters:@{@"Id":@"",@"UserId":info.userID,@"InGrade":internationalGrade,@"InSchool":internationalSchool,@"IntentionalCity":internationalCity,@"IntentionalDate":internationalWhen,@"SchoolDirection":internationalDirection,@"Contact":internationalPhone}
        onCompletion:^(id json) {
            [[AppCustomHud sharedEKZCustomHud] showTextHud:SuccessSpecialistPost];
            [self.navigationController popViewControllerAnimated:YES];
        } onFailure:^(id json) {
                                                                        
        }];
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"填写资料不完整"];
    }
}

-(void)postOverseaSchoolRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (![VerifyRegexTool validateMobile:overseaPhone]) {
        
    }else if (overseaGrade.length && overseaSchool.length && overseaCountry.length && overseaRequirement.length && overseaWantSchool.length && overseaWantCourse.length && overseaWhen.length && overIsExam.length && overseaExamScore.length && overseaPhone.length) {
        [[MainService sharedMainService] postSpecialistOverseaSchoolWithParameters:@{@"Id":@"",@"UserId":info.userID,@"InGrade":overseaGrade,@"InSchool":overseaSchool,
            @"IntentionalCountry":overseaCountry,
            @"RequirementsOfStudyAbroad":overseaRequirement,
            @"WantSchool":overseaWantSchool,@"WantMajor":overseaWantCourse,
            @"StudyAbroadTime":overseaWhen,@"LanguageAchievementAbroad":overIsExam,@"InAverage":overseaExamScore,@"Contact":overseaPhone}
         onCompletion:^(id json) {
            [[AppCustomHud sharedEKZCustomHud] showTextHud:SuccessSpecialistPost];
            [self.navigationController popViewControllerAnimated:YES];
        } onFailure:^(id json) {
        
        }];
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"填写资料不完整"];
    }
}

-(void)shareEducationPlan{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareWebPageToPlatformType:platformType];
        
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:EducationPlanShareTitle descr:EducationPlanShareDesc thumImage:[UIImage imageNamed:@"GroupCourseShare"]];
    
    shareObject.webpageUrl =@"";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
