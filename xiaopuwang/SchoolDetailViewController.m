//
//  SchoolDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolDetailViewController.h"
#import "SchoolDetailTableViewCell.h"
#import "SchoolIntroduceTableViewCell.h"
#import "SchoolBasicInfoTableViewCell.h"
#import "SchoolGradeTableViewCell.h"
#import "SchoolAdvantageTableViewCell.h"
#import "SchoolCourseTableViewCell.h"
#import "SchoolCourseTitleTableViewCell.h"

#import "SchoolService.h"
@interface SchoolDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    DataResult* detailResult;
    NSMutableArray* courseArray ;
    DataResult* professionalResult;
    NSInteger currentCourseIndex;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation SchoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学校详情";
    
    courseArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolDetailTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolBasicInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolBasicInfoTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolAdvantageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolAdvantageTableViewCell"];
    
    [self getSchoolDetailRequest];
    
    if (!detailResult) {
        self.tableView.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SchoolDetailToIntro"])
    {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[[detailResult.items getItem:0] getString:@"Introduction"] forKey:@"intro"];
    }else if ([segue.identifier isEqualToString:@"SchoolDetailToCourseDetail"]){
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[professionalResult.items getItem:currentCourseIndex-1]  forKey:@"courseItem"];
    }
}


#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (detailResult) {
        return 6;
    }else{
        return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (detailResult) {
        if (section == 5) {
            if (professionalResult) {
               return professionalResult.items.size+1;
            }else{
                return 0;
            }
        }else{
            return 1;
        }
    }else{
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"SchoolDetailTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configCell:cell indexpath:indexPath];
        }];

    }else if(indexPath.section == 1){
        return 130;
    }else if (indexPath.section == 2){
        return [tableView fd_heightForCellWithIdentifier:@"SchoolBasicInfoTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
             [self configBasicInfoCell:cell indexpath:indexPath];
        }];
    }else if(indexPath.section == 3){
        return 100.0;
    }else if (indexPath.section == 4){
        return [tableView fd_heightForCellWithIdentifier:@"SchoolAdvantageTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configSchoolAdvantageCourseCell:cell indexpath:indexPath];
        }];

    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SchoolDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolDetailTableViewCell" owner:self options:nil].firstObject;

        [self configCell:cell indexpath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        SchoolIntroduceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolIntroduceTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:[detailResult.items getItem:0]];
        return cell;
    }else if (indexPath.section == 2){
        SchoolBasicInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolBasicInfoTableViewCell" owner:self options:nil].firstObject;
        [self configBasicInfoCell:cell indexpath:indexPath];
        return cell;
    }else if (indexPath.section == 3){
        SchoolGradeTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolGradeTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:[detailResult.items getItem:0]];
        return cell;
    }else if (indexPath.section == 4){
        SchoolAdvantageTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolAdvantageTableViewCell" owner:self options:nil].firstObject;
        [self configSchoolAdvantageCourseCell:cell indexpath:indexPath];
        return cell;
    }else{
        if(indexPath.row == 0){
            SchoolCourseTitleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseTitleTableViewCell" owner:self options:nil].firstObject;
            return cell;
        }else{
        
            SchoolCourseTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseTableViewCell" owner:self options:nil].firstObject;
            
            [cell bingdingViewModel:[professionalResult.items getItem:indexPath.row-1]];
            return cell;
        }
    }
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
       [self performSegueWithIdentifier:@"SchoolDetailToIntro" sender:self];
    }if (indexPath.section == 5) {
        if (indexPath.row != 0) {
            currentCourseIndex = indexPath.row;
            [self performSegueWithIdentifier:@"SchoolDetailToCourseDetail" sender:self];
        }
    }
}

- (void)configCell:(SchoolDetailTableViewCell *)cell indexpath:(NSIndexPath *)indexpath {
    
    [cell.orgClassView removeAllTags];
    
    
    if (detailResult) {
        DataItem* item =[detailResult.items getItem:0];
        [cell bingdingViewModel:item];
        [@[[item getString:@"CollegeNature"], [item getString:@"CollegeType"]] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
            SKTag *tag = [SKTag tagWithText:text];
            tag.textColor = [UIColor grayColor];
            tag.cornerRadius = 3;
            tag.fontSize = 12;
            tag.borderColor = [UIColor grayColor];
            tag.borderWidth = 0.5;
            tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
            [cell.orgClassView addTag:tag];
        }];
        cell.orgClassView.preferredMaxLayoutWidth = Main_Screen_Width-94;
        
        cell.orgClassView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
        cell.orgClassView.interitemSpacing = 5;
        cell.orgClassView.lineSpacing = 5;
    }
}

- (void)configBasicInfoCell:(SchoolBasicInfoTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    cell.scoreLabel.preferredMaxLayoutWidth = 70;
    cell.applyStartLabel.preferredMaxLayoutWidth = 70;
    cell.applyEndLabel.preferredMaxLayoutWidth = 70;
    
    [cell bingdngViewModel:[detailResult.items getItem:0]];
    
}

- (void)configSchoolAdvantageCourseCell:(SchoolAdvantageTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    cell.schoolCourseView.preferredMaxLayoutWidth = Main_Screen_Width-29;
    [courseArray enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:text];
        tag.textColor = MAINCOLOR;
        tag.cornerRadius = 3;
        tag.fontSize = 12;
        tag.borderColor = MAINCOLOR;
        tag.borderWidth = 0.5;
        tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
        [cell.schoolCourseView addTag:tag];
    }];
    
    cell.schoolCourseView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
    cell.schoolCourseView.interitemSpacing = 5;
    cell.schoolCourseView.lineSpacing = 5;

    
}

#pragma mark - NetworkRequest
-(void)getSchoolDetailRequest{
    [[SchoolService sharedSchoolService] getSchoolDetailWithParameters:@{@"schoolIDs":self.basicID} onCompletion:^(id json) {
        detailResult = json;
       

        NSArray* array = [[[detailResult.items getItem:0] getString:@"ProfessionalCourse"] componentsSeparatedByString:@","];
        for (int i =0; i < array.count; i++) {
            [self getSchoolCourseRequest:array[i]];
        }
        
        [self getSchoolProfessionalRequest];
    } onFailure:^(id json) {
    
    }];
}

-(void)getSchoolCourseRequest:(NSString*)courseid{
    [[SchoolService sharedSchoolService] getSchoolCourseWithParameters:@{@"ProfessionalCourse":courseid} onCompletion:^(id json) {
        DataResult* result = json;
        
        [courseArray addObject:[[result.items getItem:0] getString:@"Text"]];
        
        if (courseArray.count == [[[detailResult.items getItem:0] getString:@"ProfessionalCourse"] componentsSeparatedByString:@","].count) {
             self.tableView.hidden = NO;
            [self.tableView reloadData];
        }
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolProfessionalRequest{
    [[SchoolService sharedSchoolService] getSChoolProfessionalListWithParameters:@{@"schoolId":[[detailResult.items getItem:0] getString:@"School_Application_ID"]} onCompletion:^(id json) {
        professionalResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}



@end
