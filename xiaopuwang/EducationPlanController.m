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
#import "AddTableViewCell.h"
#import "AdditionalTableViewCell.h"
#import <LGAlertView/LGAlertView.h>

@interface EducationPlanController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,LGAlertViewDelegate,DeleteAdditionalCellDelegate,TextTagDelegate>{
    NSInteger currentSegIndex;
    
    NSString* pickerString;
    
    NSMutableArray* internationalArray;
    NSMutableArray* internationalScoreArray;
    NSMutableArray* boardArray;
    NSMutableArray* boardScoreArray;
    NSMutableArray* overseaCountryArray;
    
    NSString* trainingName;
    NSString* trainingGender;
    NSString* trainingCharacter;
    NSString* trainingInGrade;
    NSString* trainingSchoolLearningAtmosphere;
    NSString* trainingIndependentLearningAttitude;
    NSString* trainingAcademicRecord;
    NSString* trainigMoreInterested;
    NSString* trainingReadingtrainingCourse;
    NSString* trainingChildCareEducation;
    NSString* trainingCommunicationFrequency;
    NSString* trainingLearningContent;
    NSString* trainingRemarks;
    
    NSString* internationalName;
    NSString* internationalGender;
    NSString* internationalCharacter;
    NSString* internationalInGrade;
    NSString* internationalEnglishAchievement;
    NSMutableString* internationalForeignLanguageAchievement;
    NSString* internationalMathematicsAchievement;
    NSString* internationalInternationalExamination;
    NSString* internationalInternationalCurriculumGrade;
    NSString* internationalInternationalCurriculum;
    NSString* internationalRemarks;
    
    NSString* overseaName;
    NSString* overseaGender;
    NSString* overseaCharacter;
    NSString* overseaInGrade;
    NSString* overseaEnglishAchievement;
    NSMutableString* overseaForeignLanguageAchievement;
    NSString* overseaAverageScoresOfSubjects;
    NSString* overseaExtracurricularPractice;
    NSString* overseaInternationalExamination;
    NSString* overseaIntentionStudyCountry;
    NSString* overseaIntentionToStudyAbroad;
    NSString* overseaTimeToGoAbroad;
    NSString* overseaRemarks;
    
    
}
@end

@implementation EducationPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"教育规划";
   
    internationalArray = [NSMutableArray new];
    internationalScoreArray = [NSMutableArray new];
    
    boardArray = [NSMutableArray new];
    boardScoreArray = [NSMutableArray new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MultiTagSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"MultiTagSelectTableViewCell"];

    [self setUpTableView];
    
   
    [self setupTrainingParameter];
    [self setupInternationalParameter];
    [self setupOverseaParameter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
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
    trainingGender = @"";
    trainingCharacter = @"";
    trainingInGrade = @"";
    trainingSchoolLearningAtmosphere = @"";
    trainingIndependentLearningAttitude = @"";
    trainingAcademicRecord = @"";
    trainigMoreInterested = @"";
    trainingReadingtrainingCourse = @"";
    trainingChildCareEducation = @"";
    trainingCommunicationFrequency = @"";
    trainingLearningContent = @"";
    trainingRemarks = @"";
}

-(void)setupInternationalParameter{
    internationalGender = @"";
    internationalCharacter = @"";
    internationalInGrade = @"";
    internationalForeignLanguageAchievement = [NSMutableString new];
    internationalMathematicsAchievement = @"";
    internationalInternationalExamination = @"";
    internationalInternationalCurriculumGrade = @"";
    internationalInternationalCurriculum = @"";
    internationalRemarks = @"";
}

-(void)setupOverseaParameter{
    overseaGender = @"";
    overseaCharacter = @"";
    overseaInGrade = @"";
    overseaEnglishAchievement = @"";
    overseaForeignLanguageAchievement = [NSMutableString new];
    overseaAverageScoresOfSubjects = @"";
    overseaExtracurricularPractice = @"";
    overseaInternationalExamination = @"";
    overseaIntentionStudyCountry = @"";
    overseaIntentionToStudyAbroad = @"";
    overseaTimeToGoAbroad = @"";
    overseaRemarks = @"";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (currentSegIndex == 0) {
        return EducationTrainingSchoolTitle.count;
    }else if (currentSegIndex == 1){
        return EducationInternationalSchoolTitle.count+internationalArray.count+1;
    }else{
        return EducationBoardSchoolTitle.count+boardArray.count+1;
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
        if (indexPath.row ==0 || indexPath.row == 8+internationalArray.count+1) {
            return 40;
        }else if (indexPath.row == EducationInternationalSchoolTitle.count+internationalArray.count+1-1){
            return 110;
        }else if (indexPath.row == 5+internationalArray.count+1){
            return 25;
        }else if (indexPath.row > 5 && indexPath.row < 5+internationalArray.count+1){
            return 80;
        }
        else{
            return 70;
        }
    }else{
        if (indexPath.row ==0 || indexPath.row == 9+boardArray.count+1) {
            return 40;
        }else if (indexPath.row == EducationBoardSchoolTitle.count+boardArray.count+1-1){
            return 110;
        }else if (indexPath.row == 5+boardArray.count+1){
            return 25;
        }else if (indexPath.row > 5 && indexPath.row < 5+boardArray.count+1){
            return 80;
        }else if (indexPath.row == 10+boardArray.count+1){
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
            UIToolbar*customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,Main_Screen_Width,40}];
            customAccessoryView.barTintColor = [UIColor whiteColor];
            UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissTextViewInput:)];
            finish.tag = indexPath.row;
            [customAccessoryView setItems:@[space,space,finish]];
            cell.contentTextView.inputAccessoryView =customAccessoryView;
            
            cell.contentTextView.text = trainingRemarks;
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.tag = indexPath.row;
            
            cell.contentField.delegate = self;
            cell.contentTitle.text = EducationTrainingSchoolTitle[indexPath.row];
            cell.contentField.placeholder = EducationTrainingSchoolPlaceHolder[indexPath.row];
            
            if (indexPath.row != 1 && indexPath.row != 8 && indexPath.row != 9) {
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
            
            if (indexPath.row == 1) {
                cell.contentField.text = trainingName;
            }else if (indexPath.row ==2) {
                cell.contentField.text = trainingGender;
            }else if (indexPath.row == 3){
                cell.contentField.text = trainingCharacter;
            }else if (indexPath.row == 4){
                cell.contentField.text = trainingInGrade;
            }else if (indexPath.row == 5){
                cell.contentField.text = trainingSchoolLearningAtmosphere;
            }else if (indexPath.row == 6){
                cell.contentField.text = trainingIndependentLearningAttitude;
            }else if (indexPath.row == 7){
                cell.contentField.text = trainingAcademicRecord;
            }else if (indexPath.row ==8){
                cell.contentField.text = trainigMoreInterested;
            }else if (indexPath.row == 9){
                cell.contentField.text =trainingReadingtrainingCourse;
            }else if (indexPath.row == 11){
                cell.contentField.text = trainingChildCareEducation;
            }else if (indexPath.row == 12){
                cell.contentField.text = trainingCommunicationFrequency;
            }else if (indexPath.row == 13){
                cell.contentField.text = trainingLearningContent;
            }
            
            
            
            return cell;
        }

    }
    else if (currentSegIndex == 1){
        if (indexPath.row == 0 || indexPath.row == 8+internationalArray.count+1) {
            HeaderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableViewCell" owner:self options:nil].firstObject;
            
            cell.headerLabel.text = indexPath.row == 0 ? EducationTrainingSchoolHeader[0]:EducationInternationalSchoolHeader[1];
            return cell;
        }else if (indexPath.row == EducationInternationalSchoolTitle.count+internationalArray.count+1-1) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row-internationalArray.count-1];
            cell.contentTextView.text = EducationInternationalSchoolPlaceHolder[indexPath.row-internationalArray.count-1];
            cell.contentTextView.text = internationalRemarks;
            
            UIToolbar*customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,Main_Screen_Width,40}];
            customAccessoryView.barTintColor = [UIColor whiteColor];
            UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissTextViewInput:)];
            finish.tag = indexPath.row;
            [customAccessoryView setItems:@[space,space,finish]];
            cell.contentTextView.inputAccessoryView =customAccessoryView;

            return cell;
        }else if (indexPath.row == 5+internationalArray.count+1){
            AddTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"AddTableViewCell" owner:self options:nil].firstObject;
            
            return cell;
        }else if (indexPath.row > 5 && indexPath.row < 5+internationalArray.count+1){
            AdditionalTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"AdditionalTableViewCell" owner:self options:nil].firstObject;
            
            cell.delegate = self;
            cell.deleteButton.tag = indexPath.row;
            
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
            
            cell.contentTextField.inputAccessoryView = customAccessoryView;
            cell.contentTextField.inputView = picker;
            
            cell.addTitle.text = internationalArray[indexPath.row-6];
            cell.contentTextField.text = internationalScoreArray[indexPath.row-6];
            
            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.tag = indexPath.row;
            cell.contentField.delegate = self;
            if (indexPath.row < 6 ) {
                cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row];
                cell.contentField.placeholder = EducationInternationalSchoolPlaceHolder[indexPath.row];
            }else{
                cell.contentTitle.text = EducationInternationalSchoolTitle[indexPath.row-internationalArray.count-1];
                cell.contentField.placeholder = EducationInternationalSchoolPlaceHolder[indexPath.row-internationalArray.count-1];
            }
            
            if (indexPath.row != 1 && indexPath.row != 7+internationalArray.count+1 ) {
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
            if (indexPath.row == 1) {
                cell.contentField.text = internationalName;
            }else if (indexPath.row == 2) {
                cell.contentField.text = internationalGender;
            }else if (indexPath.row ==3){
                cell.contentField.text = internationalCharacter;
            }else if (indexPath.row == 4){
                cell.contentField.text = internationalInGrade;
            }else if (indexPath.row == 5){
                cell.contentField.text = internationalEnglishAchievement;
            }else if (indexPath.row == 5+1+internationalArray.count+1){
                cell.contentField.text = internationalMathematicsAchievement;
            }else if (indexPath.row == 5+1+internationalArray.count+2){
                cell.contentField.text = internationalInternationalExamination;
            }else if (indexPath.row == 5+1+internationalArray.count+4){
                cell.contentField.text = internationalInternationalCurriculumGrade;
            }else if (indexPath.row == 5+1+internationalArray.count+5){
                cell.contentField.text = internationalInternationalCurriculum;
            }
            
            return cell;
        }
    }
    else{
        if (indexPath.row == 0 || indexPath.row == 9+boardArray.count+1) {
            HeaderTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableViewCell" owner:self options:nil].firstObject;
            
            cell.headerLabel.text = indexPath.row == 0 ? EducationTrainingSchoolHeader[0]:EducationInternationalSchoolHeader[1];
            return cell;
        }else if (indexPath.row == EducationBoardSchoolTitle.count+boardArray.count+1-1) {
            TextViewTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextViewTableViewCell" owner:self options:nil].firstObject;
            cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row-boardArray.count-1];
            cell.contentTextView.text = EducationBoardSchoolPlaceHolder[indexPath.row-boardArray.count-1];
            cell.contentTextView.text = overseaRemarks;

            UIToolbar*customAccessoryView = [[UIToolbar alloc]initWithFrame:(CGRect){0,0,Main_Screen_Width,40}];
            customAccessoryView.barTintColor = [UIColor whiteColor];
            UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissTextViewInput:)];
            finish.tag = indexPath.row;
            [customAccessoryView setItems:@[space,space,finish]];
            cell.contentTextView.inputAccessoryView =customAccessoryView;
            
            return cell;
        }else if (indexPath.row == 10+boardArray.count+1){
            MultiTagSelectTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MultiTagSelectTableViewCell" owner:self options:nil].firstObject;
            cell.deletage = self;
            [self configCell:cell indexPath:indexPath];
            return cell;
        }else if (indexPath.row == 5+boardArray.count+1){
            AddTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"AddTableViewCell" owner:self options:nil].firstObject;
            
            return cell;
        }else if (indexPath.row > 5 && indexPath.row < 5+boardArray.count+1){
            AdditionalTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"AdditionalTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            cell.deleteButton.tag = indexPath.row;
            
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
            
            cell.contentTextField.inputAccessoryView = customAccessoryView;
            cell.contentTextField.inputView = picker;
            
            cell.addTitle.text = boardArray[indexPath.row-6];
            cell.contentTextField.text = boardScoreArray[indexPath.row-6];

            return cell;
        }else{
            TextFieldTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableViewCell" owner:self options:nil].firstObject;
            cell.contentField.tag = indexPath.row;
            cell.contentField.delegate = self;
            if (indexPath.row < 6) {
                cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row];
                cell.contentField.placeholder = EducationBoardSchoolPlaceHolder[indexPath.row];
            }else{
                cell.contentTitle.text = EducationBoardSchoolTitle[indexPath.row-boardArray.count-1];
                cell.contentField.placeholder = EducationBoardSchoolPlaceHolder[indexPath.row-boardArray.count-1];
            }
            
            if (indexPath.row != 1 && indexPath.row != 7+boardArray.count+1 && indexPath.row != 7+boardArray.count+2) {
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
            
            if (indexPath.row == 1) {
                cell.contentField.text = overseaName;
            }else if (indexPath.row == 2) {
                cell.contentField.text = overseaGender;
            }else if (indexPath.row ==3){
                cell.contentField.text = overseaCharacter;
            }else if (indexPath.row == 4){
                cell.contentField.text = overseaInGrade;
            }else if (indexPath.row == 5){
                cell.contentField.text = overseaEnglishAchievement;
            }else if (indexPath.row == 5+1+boardArray.count+1){
                cell.contentField.text = overseaAverageScoresOfSubjects;
            }else if (indexPath.row == 5+1+boardArray.count+2){
                cell.contentField.text = overseaExtracurricularPractice;
            }else if (indexPath.row == 5+1+boardArray.count+3){
                cell.contentField.text = overseaInternationalExamination;
            }else if (indexPath.row == 5+1+boardArray.count+6){
                cell.contentField.text = overseaIntentionToStudyAbroad;
            }else if (indexPath.row == 5+1+boardArray.count+7){
                cell.contentField.text = overseaTimeToGoAbroad;
            }

            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 1 && indexPath.row == 5+internationalArray.count+1) {
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"请输入其它语言名称";
        textField.font = [UIFont systemFontOfSize:13];
        [[[LGAlertView alloc] initWithViewAndTitle:@"语言名称"
                                           message:nil
                                             style:LGAlertViewStyleAlert
                                              view:textField
                                      buttonTitles:@[@"确认"]
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                                          delegate:self] showAnimated:YES completionHandler:nil];
    }else if (currentSegIndex == 2 && indexPath.row == 5+boardArray.count+1){
        UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 240, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"请输入其它语言名称";
        textField.font = [UIFont systemFontOfSize:13];
        [[[LGAlertView alloc] initWithViewAndTitle:@"语言名称"
                                           message:nil
                                             style:LGAlertViewStyleAlert
                                              view:textField
                                      buttonTitles:@[@"确认"]
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                                          delegate:self] showAnimated:YES completionHandler:nil];
    }
}



#pragma mark - LGAlertViewDelegate

- (void)alertView:(nonnull LGAlertView *)alertView clickedButtonAtIndex:(NSUInteger)index title:(nullable NSString *)title{
    if (index==0) {
        UITextField* currentTextField = (UITextField*)alertView.innerView;
        if (currentTextField.text.length == 0) {
            
        }else{
            
            if (currentSegIndex ==1) {
                [internationalArray addObject:currentTextField.text];
                [internationalScoreArray addObject:@""];
                
            }else{
                [boardArray addObject:currentTextField.text];
                [boardScoreArray addObject:@""];
            }
            [self.tableView reloadData];
        }
    }
}


-(void)configCell:(MultiTagSelectTableViewCell*)cell indexPath:(NSIndexPath*)indexPath{
    [cell setTags:EducationOverSeaCountry];
}

#pragma mark - SegmentControlChangeValue

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
        if (pickerView.tag > 5 && pickerView.tag < 5+internationalArray.count+1+1){
            return EducationInternationalForeignScore.count;
        }else if (pickerView.tag < 6) {
            NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag]];
            return pickerData.count;
        }else{
            NSArray* pickerData = [NSArray arrayWithArray:EducationInternationalPickerData[pickerView.tag-internationalArray.count-1]];
            return pickerData.count;
        }
    }else{
        if (pickerView.tag > 5 && pickerView.tag < 5+boardArray.count+1+1){
            return EducationInternationalForeignScore.count;
        }else if (pickerView.tag < 6) {
            NSArray* pickerData = [NSArray arrayWithArray:EducationBoardPickerData[pickerView.tag]];
            return pickerData.count;
        }else{
            NSArray* pickerData = [NSArray arrayWithArray:EducationBoardPickerData[pickerView.tag-boardArray.count-1]];
            return pickerData.count;
        }
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (currentSegIndex == 0) {
        return EducationTrainingSchoolPickerData[pickerView.tag][row];
    }else if (currentSegIndex == 1){
        if (pickerView.tag > 5 && pickerView.tag < 5+internationalArray.count+1+1){
            return EducationInternationalForeignScore[row];
        }else if (pickerView.tag < 6) {
            return EducationInternationalPickerData[pickerView.tag][row];
        }else{
            return EducationInternationalPickerData[pickerView.tag-internationalArray.count-1][row];
        }
    }else{
        if (pickerView.tag > 5 && pickerView.tag < 5+boardArray.count+1+1){
        return EducationInternationalForeignScore[row];
        }else if (pickerView.tag < 6) {
            return EducationBoardPickerData[pickerView.tag][row];
        }else{
            return EducationBoardPickerData[pickerView.tag-boardArray.count-1][row];
        }
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
        if (pickerView.tag > 5 && pickerView.tag < 5+internationalArray.count+1+1){
            pickerString = EducationInternationalForeignScore[row];
        }else if(pickerView.tag <6){
            pickerString = EducationInternationalPickerData[pickerView.tag][row];
        }else{
            pickerString = EducationInternationalPickerData[pickerView.tag-internationalArray.count-1][row];
        }
    }else{
        if (pickerView.tag > 5 && pickerView.tag < 5+boardArray.count+1+1){
            pickerString = EducationInternationalForeignScore[row];
        }else if(pickerView.tag <6){
            pickerString = EducationBoardPickerData[pickerView.tag][row];
        }else{
            pickerString = EducationBoardPickerData[pickerView.tag-boardArray.count-1][row];
        }
    }
}

-(void)postSpecialist:(id)sender{
    if (currentSegIndex == 0) {
        [self postTrainingSchoolRequest];
    }else if (currentSegIndex == 1){
        [self postInternationalSchoolRequest];
    }else{
        [self postOverseaSchoolRequest];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (currentSegIndex == 0 && textField.tag == 1) {
        trainingName = textField.text;
    }else if (currentSegIndex == 1 && textField.tag == 1){
        internationalName = textField.text;
    }else if (currentSegIndex == 0 && textField.tag == 8) {
        trainigMoreInterested = textField.text;
    }else if (currentSegIndex == 0 && textField.tag == 9){
        trainingReadingtrainingCourse = textField.text;
    }else if (currentSegIndex == 1 && textField.tag == 7+internationalArray.count +1){
        internationalInternationalExamination = textField.text;
    }else if (currentSegIndex ==2 && textField.tag ==1){
        overseaName = textField.text;
    }else if (currentSegIndex == 2 && textField.tag == 7+internationalArray.count +1){
        overseaExtracurricularPractice = textField.text;
    }else if (currentSegIndex == 2 && textField.tag == 8+boardArray.count +1){
        overseaInternationalExamination = textField.text;
    }
    
    [textField resignFirstResponder];
    
    
    return YES;
}

-(void)dismissTextViewInput:(UIBarButtonItem*)item{
    UIBarButtonItem* aitem = item;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:aitem.tag inSection:0];
    TextViewTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (currentSegIndex == 0) {
        trainingRemarks = cell.contentTextView.text;
    }else if (currentSegIndex == 1){
        internationalRemarks = cell.contentTextView.text;
    }else{
        overseaRemarks = cell.contentTextView.text;
    }
    
    [cell.contentTextView resignFirstResponder];
}

-(void)dismissInput:(UIBarButtonItem*)item{
    UIBarButtonItem* aitem = item;
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:aitem.tag inSection:0];
    
    
    if (currentSegIndex == 0) {
        TextFieldTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        if (pickerString.length) {
            cell.contentField.text = pickerString;
        }

        switch (indexPath.row) {
            case 2:
            {
                trainingGender =  cell.contentField.text;
            }
                break;
            case 3:
            {
                trainingCharacter =  cell.contentField.text;
            }
                break;
            case 4:
            {
                trainingInGrade =  cell.contentField.text;
            }
                break;
            case 5:
            {
                trainingSchoolLearningAtmosphere =  cell.contentField.text;
            }
                break;
            case 6:
            {
                trainingIndependentLearningAttitude =  cell.contentField.text;
            }
                break;
            case 7:
            {
                trainingAcademicRecord =  cell.contentField.text;
            }
                break;
            case 8:
            {
                trainigMoreInterested =  cell.contentField.text;
            }
                break;
            case 9:
            {
                trainingReadingtrainingCourse =  cell.contentField.text;
            }
                break;
            case 11:
            {
                trainingChildCareEducation =  cell.contentField.text;
            }
                break;
            case 12:
            {
                trainingCommunicationFrequency =  cell.contentField.text;
            }
                break;
                
            case 13:
            {
                trainingLearningContent =  cell.contentField.text;
            }
                break;
        }
        
        
        pickerString = @"";
        [cell.contentField resignFirstResponder];
    }
    else if (currentSegIndex == 1){
        if (indexPath.row >5 && indexPath.row < 5+internationalArray.count+1){
            
            AdditionalTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (pickerString.length) {
                cell.contentTextField.text = pickerString;
                [internationalScoreArray replaceObjectAtIndex:indexPath.row-6 withObject:pickerString];
            }
            pickerString = @"";
            [cell.contentTextField resignFirstResponder];
        }else {
            TextFieldTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            if (pickerString.length) {
                cell.contentField.text = pickerString;
            }

            if (indexPath.row == 2) {
                internationalGender =  cell.contentField.text;
            }else if (indexPath.row == 3){
                internationalCharacter =  cell.contentField.text;
            }else if (indexPath.row == 4){
                internationalInGrade =  cell.contentField.text;
            }else if (indexPath.row == 5){
                internationalEnglishAchievement = cell.contentField.text;
            }else{
                if (indexPath.row == 5+internationalArray.count+1+1) {
                    internationalMathematicsAchievement = cell.contentField.text;
                }else if (indexPath.row == 5+internationalArray.count+1+1+1){
                }else if (indexPath.row == 5+internationalArray.count+1+1+3){
                    internationalInternationalCurriculumGrade = cell.contentField.text;
                }else if (indexPath.row == 5+internationalArray.count+1+1+4){
                    internationalInternationalCurriculum = cell.contentField.text;
                }
            }
            
            pickerString = @"";
            [cell.contentField resignFirstResponder];
        }
        
    }else{
        if (indexPath.row >5 && indexPath.row < 5+boardArray.count+1){
            
            AdditionalTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (pickerString.length) {
                cell.contentTextField.text = pickerString;
                [boardScoreArray replaceObjectAtIndex:indexPath.row-6 withObject:pickerString];
            }
            pickerString = @"";
            [cell.contentTextField resignFirstResponder];
        }else{
            TextFieldTableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            if (pickerString.length) {
                cell.contentField.text = pickerString;
            }
            
            if (indexPath.row == 2) {
                overseaGender =  cell.contentField.text;
            }else if (indexPath.row == 3){
                overseaCharacter =  cell.contentField.text;
            }else if (indexPath.row == 4){
                overseaInGrade =  cell.contentField.text;
            }else if (indexPath.row == 5){
                overseaEnglishAchievement = cell.contentField.text;
            }else{
                if (indexPath.row == 5+boardArray.count+1+1) {
                    overseaAverageScoresOfSubjects = cell.contentField.text;
                }else if (indexPath.row == 5+boardArray.count+1+6){
                    overseaIntentionToStudyAbroad = cell.contentField.text;
                }else if (indexPath.row == 5+boardArray.count+1+7){
                    overseaTimeToGoAbroad = cell.contentField.text;
                }
            }
            
            pickerString = @"";
            [cell.contentField resignFirstResponder];

        }
    }

}

#pragma mark - DeleteCellDeleagate
-(void)deleteAdditionalCell:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (currentSegIndex == 1) {
        [internationalArray removeObjectAtIndex:button.tag-6];
        [internationalScoreArray removeObjectAtIndex:button.tag-6];
    }else{
        [boardArray removeObjectAtIndex:button.tag-6];
        [boardScoreArray removeObjectAtIndex:button.tag-6];
    }
    
    [self.tableView reloadData];
}

#pragma mark - MultiTagSelectDelegte
-(void)selectTextTag:(NSArray*)tagArray{
    overseaCountryArray = [NSMutableArray arrayWithArray:tagArray];
}

#pragma mark - NetworkRequest
-(void)postTrainingSchoolRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    if (trainingGender.length && trainingCharacter.length && trainingInGrade.length && trainingSchoolLearningAtmosphere.length && trainingIndependentLearningAttitude.length && trainingAcademicRecord.length && trainigMoreInterested.length && trainingReadingtrainingCourse.length && trainingChildCareEducation.length && trainingCommunicationFrequency.length && trainingLearningContent.length && trainingRemarks.length) {
        [[MainService sharedMainService] postSpecialistOrgWithParameters:@{@"Id":@"",
                                                                           @"UserId":info.userID,
                                                                           @"Gender":trainingGender,
                                                                           @"Character":trainingCharacter,
                                                                           @"InGrade":trainingInGrade,
                                                                           @"SchoolLearningAtmosphere":trainingSchoolLearningAtmosphere,
                                                                           @"IndependentLearningAttitude":trainingIndependentLearningAttitude,
                                                                           @"AcademicRecord":trainingAcademicRecord,
                                                                           @"MoreInterested":trainigMoreInterested,
                                                                           @"ReadingtrainingCourse":trainingReadingtrainingCourse,
                                                                           @"ChildCareEducation":trainingChildCareEducation,
                                                                           @"CommunicationFrequency":trainingCommunicationFrequency,
                                                                           @"LearningContent":trainingLearningContent,
                                                                           @"Remarks":trainingRemarks,
                                                                           @"CreateTime":@"2017-08-07T02:55:28.111Z",
                                                                           @"IsState":@(0)
                                                                           }
                                                            onCompletion:^(id json) {
                                                                
                                                            } onFailure:^(id json) {
                                                                
                                                            }];

    }
    
    
}

-(void)postInternationalSchoolRequest{
    UserInfo* info = [UserInfo sharedUserInfo];

    if (internationalEnglishAchievement.length) {
        [internationalForeignLanguageAchievement appendString:[NSString stringWithFormat:@"英语:%@",internationalEnglishAchievement]];
    }
    
    for (int i = 6; i<5+internationalArray.count+1; i++) {
        [internationalForeignLanguageAchievement appendString:[NSString stringWithFormat:@",%@:%@",internationalArray[i-6],internationalScoreArray[i-6]]];
    }
    
    
    [[MainService sharedMainService] postSpecialistChinaSchoolWithParameters:@{@"Id":@"",
                                                                               @"UserId":info.userID,
                                                                               @"Gender":internationalGender,
                                                                               @"Character":internationalCharacter,
                                                                               @"InGrade":internationalInGrade,
                                                                               @"ForeignLanguageAchievement":internationalForeignLanguageAchievement,
                                                                               @"MathematicsAchievement":internationalMathematicsAchievement,
                                                                               @"InternationalExamination":internationalInternationalExamination,
                                                                               @"InternationalCurriculumGrade":internationalInternationalCurriculumGrade,
                                                                               @"InternationalCurriculum":internationalInternationalCurriculum,
                                                                               @"Remarks":internationalRemarks,
                                                                               @"CreateTime":@"2017-08-07T02:55:28.111Z",
                                                                               @"IsState":@(0)
                                                                               }
     onCompletion:^(id json) {
        
     } onFailure:^(id json) {
        
     }];
}

-(void)postOverseaSchoolRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    if (overseaEnglishAchievement.length) {
        [overseaForeignLanguageAchievement appendString:[NSString stringWithFormat:@"英语:%@",overseaEnglishAchievement]];
    }
    
    for (int i = 6; i<5+boardArray.count+1; i++) {
        [overseaForeignLanguageAchievement appendString:[NSString stringWithFormat:@",%@:%@",boardArray[i-6],boardScoreArray[i-6]]];
    }
    
    if (overseaCountryArray.count >0) {
        overseaIntentionStudyCountry = [overseaCountryArray componentsJoinedByString:@","];
    }
    
    if (overseaCountryArray.count>0) {
        NSMutableString* astring = [NSMutableString new];
        
        for (NSString*string in overseaCountryArray) {
            [astring appendString:EducationOverSeaCountry[[string intValue]]];
            [astring appendString:@","];
        }
       overseaIntentionStudyCountry = [astring substringToIndex:astring.length-1];
        
    }
    
    
    if (overseaGender.length && overseaCharacter.length && overseaInGrade.length && overseaForeignLanguageAchievement.length && overseaAverageScoresOfSubjects.length && overseaExtracurricularPractice.length && overseaInternationalExamination.length && overseaIntentionStudyCountry.length && overseaIntentionToStudyAbroad.length && overseaTimeToGoAbroad.length && overseaRemarks.length) {
        [[MainService sharedMainService] postSpecialistOverseaSchoolWithParameters:@{@"Id":@"",
                                                                                     @"UserId":info.userID,
                                                                                     @"Gender":overseaGender,
                                                                                     @"Character":overseaCharacter,
                                                                                     @"InGrade":overseaInGrade,
                                                                                     @"ForeignLanguageAchievement":overseaForeignLanguageAchievement,
                                                                                     @"AverageScoresOfSubjects":overseaAverageScoresOfSubjects,
                                                                                     @"ExtracurricularPractice":overseaExtracurricularPractice,
                                                                                     @"InternationalExamination":overseaInternationalExamination,
                                                                                     @"IntentionStudyCountry":overseaIntentionStudyCountry,
                                                                                     @"IntentionToStudyAbroad":overseaIntentionToStudyAbroad,
                                                                                     @"TimeToGoAbroad":overseaTimeToGoAbroad,
                                                                                     @"Remarks":overseaRemarks,
                                                                                     @"CreateTime":@"2017-08-07T02:55:28.167Z",
                                                                                     @"IsState": @(0)
                                                                                     }
         
                                                                      onCompletion:^(id json) {
                                                                          
                                                                      } onFailure:^(id json) {
                                                                          
                                                                      }];
 
    }
    
    
}
@end
