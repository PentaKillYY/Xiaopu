//
//  PersonalChooseViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/17.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "PersonalChooseViewController.h"
#import "CustomAlertTableView.h"
#import "SchoolService.h"
#import "OrginizationService.h"

@interface PersonalChooseViewController ()<RowSelectDelegate,UIAlertViewDelegate>
{
    CustomAlertTableView* ct;
    DataResult*  typeResult;
    DataResult* courseTypeResult;
    NSInteger selectCourseIndex;
    DataItem* countryItem;
}
@property(nonatomic,weak)IBOutlet UIButton* searchButton;
@property(nonatomic,weak)IBOutlet UIButton* schoolButton;
@property(nonatomic,weak)IBOutlet UIButton* courseButton;
@end

@implementation PersonalChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自主选校";
    countryItem = [DataItem new];
    
    [self.searchButton.layer setCornerRadius:3.0];
    self.searchButton.backgroundColor  = MAINCOLOR;
    
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitle:@"确认快速筛选" forState:UIControlStateNormal];
    
    [self getCourseTypeList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PersonChooseToChinaSchool"])
    {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:PersonChooseChinaCourseType[selectCourseIndex] forKey:@"chinaType"];
    }else if ([segue.identifier isEqualToString:@"PersonChooseToOrg"]){
        id theSegue = segue.destinationViewController;
        if (selectCourseIndex == 2) {
            [theSegue setValue:[[courseTypeResult.items getItem:3] getString:@"Text"] forKey:@"orgType"];
        }else if (selectCourseIndex ==3){
            [theSegue setValue:[[courseTypeResult.items getItem:2] getString:@"Text"] forKey:@"orgType"];
        }else{
            [theSegue setValue:[[courseTypeResult.items getItem:selectCourseIndex] getString:@"Text"] forKey:@"orgType"];
        }
    }else if ([segue.identifier isEqualToString:@"PersonChooseToSchool"]){
        DataItem* item = [typeResult.items getItem:selectCourseIndex];
        
        id theSegue = segue.destinationViewController;
        [theSegue setValue:[item getString:@"value"] forKey:@"schoolTypeName"];
//        NSString* countryName = [NSString stringWithFormat:@"%d",selectCountryIndex];
        [theSegue setValue:[[countryItem getString:@"countryname"] substringToIndex:[countryItem getString:@"countryname"].length-2] forKey:@"schoolCountryName"];
    }
}

- (IBAction)schoolTypeAction:(id)sender{
    ct = [[CustomAlertTableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) rowCount:PersonChooseSchoolType.count title:@"请选择学校类型"];
    ct.delegate = self;

    [self.view addSubview:ct];
    
}


- (IBAction)courseTypeAction:(id)sender{
    if([self.schoolButton.titleLabel.text isEqualToString:@"选择学校类型"]){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"系统提示" message:@"请先选择学校类型，再选择对应课程" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"选择学校类型", nil];
        [alert show];
    }else{
        
        if ([self.schoolButton.titleLabel.text isEqualToString:@"教育机构"]) {
            ct = [[CustomAlertTableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) rowCount:OrginizationTypeAry.count title:@"请选择课程类型"];
            ct.cellTitleArray = OrginizationTypeAry;
            ct.delegate = self;
            [self.view addSubview:ct];
        }else if ([self.schoolButton.titleLabel.text isEqualToString:@"国内学校"]){
            ct = [[CustomAlertTableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) rowCount:PersonChooseChinaCourseType.count title:@"请选择课程类型"];
            ct.cellTitleArray = PersonChooseChinaCourseType;
            ct.delegate = self;
            [self.view addSubview:ct];
        }else{
            [self getSchoolTypeRequest];
        }
        
        

    }
}


-(IBAction)searchAction:(id)sender{
    
    if ([self.courseButton.titleLabel.text isEqualToString:@"选择课程品类"]) {
        [[AppCustomHud sharedEKZCustomHud] showTextHud:@"请选择课程品类"];
    }else{
        if ([self.schoolButton.titleLabel.text isEqualToString:@"教育机构"]) {
            [self performSegueWithIdentifier:@"PersonChooseToOrg" sender:self];
        }else if ([self.schoolButton.titleLabel.text isEqualToString:@"国内学校"]){
            [self performSegueWithIdentifier:@"PersonChooseToChinaSchool" sender:self];
        }else{
            
            [self performSegueWithIdentifier:@"PersonChooseToSchool" sender:self];
        }

    }
    
}


#pragma  mark - RowSelectDelegate
-(void)selectRow:(NSInteger)rowIndex{
    if ([ct.tableTitle isEqualToString:@"请选择学校类型"]) {
        [countryItem setString:PersonChooseSchoolType[rowIndex] forKey:@"countryname"];
        [self.schoolButton setTitle:PersonChooseSchoolType[rowIndex] forState:UIControlStateNormal];
    }else{
        selectCourseIndex = rowIndex;
        if ([self.schoolButton.titleLabel.text isEqualToString:@"教育机构"]) {
            [self.courseButton setTitle:OrginizationTypeAry[rowIndex] forState:UIControlStateNormal];
        }else if ([self.schoolButton.titleLabel.text isEqualToString:@"国内学校"]){
            [self.courseButton setTitle:PersonChooseChinaCourseType[rowIndex] forState:UIControlStateNormal];
        }else{
            NSMutableArray* typeName = [[NSMutableArray alloc] init];
            for (int i = 0; i<typeResult.items.size; i++) {
                DataItem* item = [typeResult.items getItem:i];
                [typeName addObject:[item getString:@"text"]];
            }
            [self.courseButton setTitle:typeName[rowIndex] forState:UIControlStateNormal];
        }
    }
    
    [ct dismiss];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex  == 1) {
        [self schoolTypeAction:self.schoolButton];
    }
}

#pragma mark - NetworkRequest
-(void)getSchoolTypeRequest{
    
    NSString* countryName = [self.schoolButton.titleLabel.text substringWithRange:NSMakeRange(0, self.schoolButton.titleLabel.text.length-2)];
    
    [[SchoolService sharedSchoolService] getSchoolTypeListWithParameters:@{@"countryName":countryName} onCompletion:^(id json) {
        typeResult = json;
        
        NSMutableArray* typeName = [[NSMutableArray alloc] init];
        for (int i = 0; i<typeResult.items.size; i++) {
            DataItem* item = [typeResult.items getItem:i];
            [typeName addObject:[item getString:@"text"]];
        }
        
        ct = [[CustomAlertTableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) rowCount:typeName.count title:@"请选择课程类型"];
        ct.cellTitleArray = [NSArray arrayWithArray:typeName] ;
        ct.delegate = self;
        [self.view addSubview:ct];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getCourseTypeList{
    [[OrginizationService sharedOrginizationService] getCoursetypeParameters:@{@"courseType":@"CourseType"} onCompletion:^(id json) {
        courseTypeResult = json;
        
    } onFailure:^(id json) {
        
    }];
}

@end
