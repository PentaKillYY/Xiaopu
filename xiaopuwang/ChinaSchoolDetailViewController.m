//
//  ChinaSchoolDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ChinaSchoolDetailViewController.h"
#import "SchoolService.h"
#import "SchoolDetailTableViewCell.h"
#import "SchoolIntroduceTableViewCell.h"
#import "SchoolBasicInfoTableViewCell.h"
#import "SchoolGradeTableViewCell.h"
#import "SchoolAdvantageTableViewCell.h"
#import "SchoolCourseTitleTableViewCell.h"
#import "SchoolCourseTableViewCell.h"
#import "ChinaTeacherAndSrudentCell.h"
@interface ChinaSchoolDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DataResult* detailResult;
    NSMutableArray* courseArray ;
    DataResult* professionalResult;
    DataResult* teacherAndStudentResult;
    NSMutableArray* studentArray;
    NSMutableArray* schoolFellowArray;
    NSMutableArray* teacherArray;
    
    NSInteger currentCourseIndex;
    NSString* titleName;
    
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet UIButton* chatButton;
@end

@implementation ChinaSchoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"中国学校详情";
    
    courseArray = [NSMutableArray new];
    studentArray = [NSMutableArray new];
    schoolFellowArray = [NSMutableArray new];
    teacherArray = [NSMutableArray new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolDetailTableViewCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolBasicInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolBasicInfoTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolAdvantageTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolAdvantageTableViewCell"];
    
    [self setupChatUI];
    
    [self getSchoolDetailRequest];
    
    if (!detailResult) {
        self.tableView.hidden = YES;
    }
}

-(void)setupChatUI{
    [self.chatButton.layer setCornerRadius:3.0];
    [self.chatButton.layer setMasksToBounds:YES];
}

-(IBAction)chatWithTeacher:(id)sender{
    //新建一个聊天会话View Controller对象,建议这样初始化
    RCConversationViewController *chat = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:SchoolRongCloudId];
    
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = ChinaSchoolRongCloudId;
    
    //设置聊天会话界面要显示的标题
    chat.title = @"中国学校顾问";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ChinaDetaiToIntro"])
    {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"SchoolIntroduce"] forKey:@"intro"];
    }else if ([segue.identifier isEqualToString:@"ChinaDetailToCourseDetail"]){
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[professionalResult.items getItem:currentCourseIndex-1]  forKey:@"courseItem"];
        
    }else if ([segue.identifier isEqualToString:@"ChinaDetailToTeacherAndStudent"]){
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:self.schoolID  forKey:@"schoolID"];
        
        [theSegue setValue:titleName forKey:@"titlename"];
        
        
    }
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 5) {
        if (professionalResult) {
            return professionalResult.items.size+1;
        }else{
            return 1;
        }

    }else if(section == 6){
        
        return studentArray.count >3 ? 4:1+studentArray.count;
    }else if(section == 7){
        return schoolFellowArray.count>3 ? 4:schoolFellowArray.count+1;
    }else if (section == 8){
        return 1+teacherArray.count>3 ? 4:1+teacherArray.count;
    }else{
        return 1;
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
        
    }else if (indexPath.section == 6 || indexPath.section == 7 || indexPath.section == 8){
        if (indexPath.row !=0) {
            return 80;
        }else{
            return 44;
        }
    }else{
        return 44;
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SchoolDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolDetailTableViewCell" owner:self options:nil].firstObject;
        
        [self configCell:cell indexpath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        SchoolIntroduceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolIntroduceTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:detailResult.detailinfo];
        return cell;
    }else if (indexPath.section == 2){
        SchoolBasicInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolBasicInfoTableViewCell" owner:self options:nil].firstObject;
        [self configBasicInfoCell:cell indexpath:indexPath];
        return cell;
    }else if (indexPath.section == 3){
        SchoolGradeTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolGradeTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:detailResult.detailinfo];
        return cell;
    }else if (indexPath.section == 4){
        SchoolAdvantageTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolAdvantageTableViewCell" owner:self options:nil].firstObject;
        [self configSchoolAdvantageCourseCell:cell indexpath:indexPath];
        return cell;
    }else if (indexPath.section == 5){
        if(indexPath.row == 0){
            SchoolCourseTitleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseTitleTableViewCell" owner:self options:nil].firstObject;
            cell.courseTitleLabel.text = @"开设课程";
            return cell;
        }else{
            
            SchoolCourseTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseTableViewCell" owner:self options:nil].firstObject;
            
            [cell bingdingViewModel:[professionalResult.items getItem:indexPath.row-1]];
            return cell;

        }
    }else{
        if (indexPath.row == 0) {
            SchoolCourseTitleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseTitleTableViewCell" owner:self options:nil].firstObject;
            if (indexPath.section == 6) {
                cell.courseTitleLabel.text = @"优秀学生";
            }else if(indexPath.section == 7){
                cell.courseTitleLabel.text = @"杰出校友";
            }else{
                cell.courseTitleLabel.text = @"优秀老师";
            }
            cell.indicatorLabel.hidden = NO;
            return cell;
        }else{
        
        ChinaTeacherAndSrudentCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ChinaTeacherAndSrudentCell" owner:self options:nil].firstObject;
            if (indexPath.section == 6 ) {
                [cell bingdingViewModel:studentArray[indexPath.row-1]];
  
            }else if (indexPath.section == 7){
                [cell bingdingViewModel:schoolFellowArray[indexPath.row-1]];

            }else{
                [cell bingdingViewModel:teacherArray[indexPath.row-1]];

            }
        return cell;
        }
    }
}

#pragma mark - UItableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"ChinaDetaiToIntro" sender:self];
        
    }else if (indexPath.section == 5){
        if (indexPath.row == 0) {
            currentCourseIndex = indexPath.row;
            [self performSegueWithIdentifier:@"ChinaDetailToCourseDetail" sender:self];
        }

    }else if (indexPath.section == 6 || indexPath.section ==7 || indexPath.section == 8){
        
        if (indexPath.row == 0) {
            if (studentArray.count > 0 && indexPath.section == 6) {
                SchoolCourseTitleTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                
                titleName = cell.courseTitleLabel.text;
                [self performSegueWithIdentifier:@"ChinaDetailToTeacherAndStudent" sender:self];
            }else if (schoolFellowArray.count > 0 && indexPath.section == 7){
                SchoolCourseTitleTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                
                titleName = cell.courseTitleLabel.text;
                [self performSegueWithIdentifier:@"ChinaDetailToTeacherAndStudent" sender:self];
            }else if (teacherArray.count > 0 && indexPath.section == 8){
                SchoolCourseTitleTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                
                titleName = cell.courseTitleLabel.text;
                [self performSegueWithIdentifier:@"ChinaDetailToTeacherAndStudent" sender:self];
            }
            
            

        }
        
    }
}

- (void)configCell:(SchoolDetailTableViewCell *)cell indexpath:(NSIndexPath *)indexpath {

    [cell.orgClassView removeAllTags];
    
    
    if (detailResult) {
        DataItem* item = detailResult.detailinfo;
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
    
    [cell bingdngViewModel:detailResult.detailinfo];
    
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
#pragma mark - NetWorkRequest

-(void)getSchoolDetailRequest{
    [[SchoolService sharedSchoolService] getChinaSchoolDetailWithParameters:@{@"schoolID":self.schoolID} onCompletion:^(id json) {
        detailResult = json;
        
        
        NSArray* array = [[detailResult.detailinfo getString:@"ProfessionalCourse"] componentsSeparatedByString:@","];
        for (int i =0; i < array.count; i++) {
            [self getSchoolCourseRequest:array[i]];
        }
        
        [self getSchoolProfessionalRequest];

        [self getSchoolTeacherAndStudent];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolCourseRequest:(NSString*)courseid{
    [[SchoolService sharedSchoolService] getSchoolCourseWithParameters:@{@"ProfessionalCourse":courseid} onCompletion:^(id json) {
        DataResult* result = json;
        
        [courseArray addObject:[[result.items getItem:0] getString:@"Text"]];
        
        if (courseArray.count == [[detailResult.detailinfo getString:@"ProfessionalCourse"] componentsSeparatedByString:@","].count) {
            

            NSMutableIndexSet *idxSet = [[NSMutableIndexSet alloc] init];

            [idxSet addIndexesInRange:NSMakeRange(0, 5)];
            
            [self.tableView reloadSections:idxSet withRowAnimation:UITableViewRowAnimationNone];

            self.tableView.hidden = NO;
        }
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolProfessionalRequest{
    [[SchoolService sharedSchoolService] getChinaSchoolCourseWithParameters:@{@"schoolId":self.schoolID} onCompletion:^(id json) {
        professionalResult = json;
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
    
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolTeacherAndStudent{
    [[SchoolService sharedSchoolService] getChinaSchoolTeacherAndStudentWithParameters:@{@"schoolId":self.schoolID} onCompletion:^(id json) {
        teacherAndStudentResult = json;
        
        for (int i = 0; i< teacherAndStudentResult.items.size; i++) {
          DataItem* item=  [teacherAndStudentResult.items getItem:i];
            int type = [item getInt:@"Type"];
            if (type == 1) {
                [studentArray addObject:item];
            }else if (type == 2){
                [schoolFellowArray addObject:item];
            }else{
                [teacherArray addObject:item];
            }
        }
        
        NSMutableIndexSet *idxSet = [[NSMutableIndexSet alloc] init];
        
        [idxSet addIndexesInRange:NSMakeRange(6, 3)];
        
        [self.tableView reloadSections:idxSet withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}
@end
