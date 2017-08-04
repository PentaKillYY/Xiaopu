//
//  SchoolCourseDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolCourseDetailViewController.h"
#import "SChoolCourseAcceptGradeCell.h"
#import "SchoolCourseTestCell.h"
#import "SchoolCourseOtherCell.h"
#import "SchoolIntroduceTableViewCell.h"
#import "SchoolCourseTitleTableViewCell.h"
#import "SchoolService.h"
@interface SchoolCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,TTGTagCollectionViewDataSource,TTGTagCollectionViewDelegate>
{
    NSArray* testArray;
    NSMutableArray* gradeArray;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property (strong, nonatomic) NSMutableArray <UIView *> *tagViews;
@end

@implementation SchoolCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程介绍";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SChoolCourseAcceptGradeCell" bundle:nil] forCellReuseIdentifier:@"SChoolCourseAcceptGradeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SchoolIntroduceTableViewCell" bundle:nil] forCellReuseIdentifier:@"SchoolIntroduceTableViewCell"];
    
    testArray =  [[self.courseItem getString:@"InternationalTestType"] componentsSeparatedByString:@"|"];
    
    gradeArray = [NSMutableArray new];
    
    _tagViews = [NSMutableArray new];

    for (NSString* string in [[self.courseItem getString:@"AcceptGrade"] componentsSeparatedByString:@","]) {
        [self getAcceptedGradeRequest:string];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1+testArray.count;
    }else{
        
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"SChoolCourseAcceptGradeCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configAcceptGradeCell:cell IndexPath:indexPath];
        }];
    }else if (indexPath.section == 5) {
        return [tableView fd_heightForCellWithIdentifier:@"SchoolIntroduceTableViewCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configIntroduceCell:cell IndexPath:indexPath];
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
        SChoolCourseAcceptGradeCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SChoolCourseAcceptGradeCell" owner:self options:nil].firstObject;
        [self configAcceptGradeCell:cell IndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            SchoolCourseTitleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseTitleTableViewCell" owner:self options:nil].firstObject;
            cell.courseTitleLabel.text = @"考试要求";
            return cell;
        }else{
            SchoolCourseTestCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseTestCell" owner:self options:nil].firstObject;
            NSString* test = testArray[indexPath.row -1];
            
            NSRange range = [test rangeOfString:@":"];
            NSString* testTitle ;
            
            
            NSString* testScore ;
            
            if (range.length == 0) {
                testTitle = test;
                 testScore = @"无";
            }else{
                testTitle =  [test substringToIndex:range.location];
                testScore = [test substringFromIndex:range.location+1];
            }
            
            [cell bindingViewModelWithTitle:testTitle Score:testScore];
            return cell;
        }
    }else if (indexPath.section == 5){
        SchoolIntroduceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolIntroduceTableViewCell" owner:self options:nil].firstObject;
        cell.indicatorLabel.hidden = YES;
        cell.schoolDetail.text = @"课程介绍";
        [self configIntroduceCell:cell IndexPath:indexPath];
        return cell;

    }else{
        SchoolCourseOtherCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SchoolCourseOtherCell" owner:self options:nil].firstObject;
        
        if (indexPath.section == 2) {
            cell.otherTitle.text = @"均分要求:";
            cell.otherContent.text = [self.courseItem getString:@"MinimumAverage"];
        }else if (indexPath.section ==3){
            cell.otherTitle.text = @"学制:";
            cell.otherContent.text = [self.courseItem getString:@"LengthOfSchooling"];
        }else{
            cell.otherTitle.text = @"学费:";
           cell.otherContent.text = [self.courseItem getString:@"Tuition"];
        }
        return cell;
    }
}

-(void)configIntroduceCell:(SchoolIntroduceTableViewCell*)cell IndexPath:(NSIndexPath*)indexpath{
    cell.schoolIntro.preferredMaxLayoutWidth = Main_Screen_Width-24;
    [cell bingdingViewModel:self.courseItem];
}

-(void)configAcceptGradeCell:(SChoolCourseAcceptGradeCell*)cell IndexPath:(NSIndexPath*)indexpath{
    
    
    cell.tagCollectionView.preferredMaxLayoutWidth = Main_Screen_Width-24;

    cell.tagCollectionView.delegate = self;
    cell.tagCollectionView.dataSource = self;
    

    if (self.tagViews.count == 0) {
        for (NSString* string in gradeArray) {
            [self.tagViews addObject:[self newButtonWithTitle:string fontSize:12.0f backgroundColor:[UIColor whiteColor]]];
        }

    }

    [cell.tagCollectionView reload];
}

- (UIButton *)newButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize backgroundColor:(UIColor *)backgroudColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setImage:V_IMAGE(@"CourseGrade") forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = backgroudColor;
    [button sizeToFit];
    
    [self expandSizeForView:button extraWidth:12 extraHeight:8];
    
    return button;
}

- (void)expandSizeForView:(UIView *)view extraWidth:(CGFloat)extraWidth extraHeight:(CGFloat)extraHeight {
    CGRect frame = view.frame;
    frame.size.width += extraWidth;
    frame.size.height += extraHeight;
    view.frame = frame;
}

#pragma mark - TTGTagCollectionViewDataSource

- (NSUInteger)numberOfTagsInTagCollectionView:(TTGTagCollectionView *)tagCollectionView {
    return _tagViews.count;
}

- (UIView *)tagCollectionView:(TTGTagCollectionView *)tagCollectionView tagViewForIndex:(NSUInteger)index {
    return _tagViews[index];
}

- (CGSize)tagCollectionView:(TTGTagCollectionView *)tagCollectionView sizeForTagAtIndex:(NSUInteger)index {
    return _tagViews[index].frame.size;
}

#pragma mark - NetworkRequest
-(void)getAcceptedGradeRequest:(NSString*)grade{
    [[SchoolService sharedSchoolService] getSchoolAcceptedGradeWithParameters:@{@"AcceptGrade":grade} onCompletion:^(id json) {
        DataResult* result = json;
        
        [gradeArray addObject: [[result.items getItem:0] getString:@"Text"]];
        
        if (gradeArray.count == [[self.courseItem getString:@"AcceptGrade"] componentsSeparatedByString:@","].count) {
            [self.tableView reloadData];
        }
        
    } onFailure:^(id json) {
        
    }];
}
@end
