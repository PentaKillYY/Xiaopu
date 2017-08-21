//
//  OrginizationDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationDetailViewController.h"
#import "OrgInfoTableViewCell.h"
#import "OrgHouseRateTableViewCell.h"
#import "OrgProportionTableViewCell.h"
#import "OrgAlbumVideoTableViewCell.h"
#import "OrgMapTableViewCell.h"
#import "UIButton+JKImagePosition.h"
#import "UIButton+JKMiddleAligning.h"
#import "HMSegmentedControl.h"
#import "OrginizationService.h"
#import "StarRatingView.h"
#import "OrgClassTableViewCell.h"
#import "OrgTeacherTableViewCell.h"
#import "OrgStudentTableViewCell.h"
#import "OrgEvaluateTableViewCell.h"
#import "MyService.h"
#import <LGAlertView/LGAlertView.h>


@interface OrginizationDetailViewController ()<UITableViewDataSource,UITableViewDelegate,LGAlertViewDelegate>{
    NSInteger currentSegIndex;
    
    DataResult* _detailInfoResult;
    DataResult* _albumRequest;
    DataResult* _videoRequest;
    DataResult* _classResult;
    DataResult* _teacherResult;
    DataResult* _studentResult;
    DataResult* _relyResult;
    DataResult* _appointStateResult;
    DataResult* _focusResult;
    DataResult* _userAdsResult;
    
    NSMutableArray* teacher0Aray;
    NSMutableArray* teacher1Aray;
    NSMutableArray* teacher2Aray;
    NSMutableArray* teacher3Aray;
    
    NSMutableArray* stuent0Aray;
    NSMutableArray* stuent1Aray;
    NSMutableArray* stuent2Aray;
    NSMutableArray* stuent3Aray;
    
    NSString* teacherType;
    NSString* studentType;
    
    NSString* videoType;
    
    NSInteger selectCourseIndex;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet HMSegmentedControl *segmentedControl;
@property(nonatomic,weak)IBOutlet UIButton* followButton;
@property(nonatomic,weak)IBOutlet UILabel* followTitle;
@property(nonatomic,weak)IBOutlet UIButton* contactButton;

@property(nonatomic,weak)IBOutlet UIImageView* logoView;
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet StarRatingView* ratingView;

@property(nonatomic,weak)IBOutlet UIButton* contactTeacherBtn;
@property(nonatomic,weak)IBOutlet UIButton* askPriceBtn;
@property(nonatomic,weak)IBOutlet UIButton* payBtn;

@end

@implementation OrginizationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"机构详情";
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:233.0/255.0 alpha:1.0];
   
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgTeacherTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgTeacher"];
    
    
    [self setupBottomView];
    [self setupInfoSeg];
    
    [self getOrgDetailInfoRequest];
    [self gerOrgAlbumRequest];
    [self getVideoAlbumRequest];
    
    [self getAppointStateRequest];
    [self judgeFocusOrgRequest];
    [self getUserAdscriptionRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DetailToContent"])
    {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[_detailInfoResult.detailinfo getString:@"Introduction"] forKey:@"orgContent"];
    }else if ([segue.identifier isEqualToString:@"DetailToPhotoBrowser"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:_albumRequest forKey:@"AlbumResult"];
    }else if ([segue.identifier isEqualToString:@"DetailToVideo"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.orgID forKey:@"orgID"];
        [theSegue setValue:videoType forKey:@"videoType"];
    }else if ([segue.identifier isEqualToString:@"DetailToMoreCourse"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.orgID forKey:@"orgID"];
    }else if ([segue.identifier isEqualToString:@"DetailToMoreTeacher"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.orgID forKey:@"orgID"];
        [theSegue setValue:teacherType forKey:@"teacherType"];
    }else if ([segue.identifier isEqualToString:@"DetailToMoreStudent"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.orgID forKey:@"orgID"];
        [theSegue setValue:studentType forKey:@"studentType"];
    }else if ([segue.identifier isEqualToString:@"DetailToMoreEvaluate"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.orgID forKey:@"orgID"];
    }else if([segue.identifier isEqualToString:@"DetailToCourseDetail"])
    {
        id theSegue = segue.destinationViewController;
        DLog(@"%@",[[[_classResult.detailinfo getDataItemArray:@"list"] getItem:selectCourseIndex] getString:@"Organization_Course_ID"]);
        [theSegue setValue: [[[_classResult.detailinfo getDataItemArray:@"list"] getItem:selectCourseIndex] getString:@"Organization_Course_ID"] forKey:@"courseId"];
    }
}

-(void)pushToMoreCourse{
    [self performSegueWithIdentifier:@"DetailToMoreCourse" sender:self];
}


-(void)pushToMoreTeacher:(id)sender{
    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    teacherType = [NSString stringWithFormat:@"%ld",(long)tap.view.tag];
    [self performSegueWithIdentifier:@"DetailToMoreTeacher" sender:self];
}

-(void)pushToMoreStudent:(id)sender{
    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    studentType = [NSString stringWithFormat:@"%ld",(long)tap.view.tag];
    [self performSegueWithIdentifier:@"DetailToMoreStudent" sender:self];
}

-(void)pushToMoreEvaluate{
    [self performSegueWithIdentifier:@"DetailToMoreEvaluate" sender:self];
}

#pragma mark - SetUpUI

-(void)setupInfoView{
    [self.logoView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",IMAGE_URL,[_detailInfoResult.detailinfo getString:@"Logo"]] ] placeholderImage:nil];
    
    self.orgName.text = [_detailInfoResult.detailinfo getString:@"OrganizationName"];
    
    StarRatingViewConfiguration *conf = [[StarRatingViewConfiguration alloc] init];
    conf.rateEnabled = NO;
    conf.starWidth = 15.0f;
    conf.fullImage = @"fullstar.png";
    conf.halfImage = @"halfstar.png";
    conf.emptyImage = @"emptystar.png";
    
    _ratingView.configuration = conf;
    [_ratingView setStarConfiguration];
    
    [_ratingView setRating:4.5 completion:^{
        NSLog(@"rate done");
    }];

}

-(void)setupBottomView{
    
    [self.contactTeacherBtn setBackgroundColor:MAINCOLOR];
    [self.contactTeacherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contactTeacherBtn.layer setCornerRadius:3.0];
    [self.contactTeacherBtn.layer setMasksToBounds:YES];
    
    [self.askPriceBtn setBackgroundColor:MAINCOLOR];
    [self.askPriceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.askPriceBtn.layer setCornerRadius:3.0];
    [self.askPriceBtn.layer setMasksToBounds:YES];
    
    [self.payBtn setBackgroundColor:MAINCOLOR];
    [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payBtn.layer setCornerRadius:3.0];
    [self.payBtn.layer setMasksToBounds:YES];
    
    [self.contactButton setBackgroundColor:MAINCOLOR];
    [self.contactButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contactButton.layer setCornerRadius:3.0];
    [self.contactButton.layer setMasksToBounds:YES];
    
    [self.followButton setImage:V_IMAGE(@"unfollowed") forState:0];
    [self.followButton setImage:V_IMAGE(@"followed") forState:UIControlStateSelected];
    
    [self.followButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    
    self.followTitle.text = @"关注";
}

-(void)setupInfoSeg{
    self.segmentedControl.sectionTitles = @[@"简介", @"课程", @"老师", @"学生",@"评价"];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    self.segmentedControl.selectionIndicatorColor = MAINCOLOR;
    self.segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    [self.segmentedControl setSelectedSegmentIndex:currentSegIndex];
}


-(void)changeAppointState{
    if (_appointStateResult.statusCode == 1) {
        self.contactButton.hidden = YES;
        self.contactTeacherBtn.hidden = NO;
        self.payBtn.hidden = NO;
        self.askPriceBtn.hidden = NO;
    }else{
        self.contactButton.hidden = NO;
        self.contactTeacherBtn.hidden = YES;
        self.payBtn.hidden = YES;
        self.askPriceBtn.hidden = YES;
    }
}

-(IBAction)rongcloudChat:(id)sender{
    if ([_userAdsResult.message isEqualToString:@"1"]) {
        //新建一个聊天会话View Controller对象,建议这样初始化
        RCConversationViewController *chat = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:[_detailInfoResult.detailinfo getString:@"User_ID"]];
        
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
        chat.conversationType = ConversationType_PRIVATE;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
        chat.targetId = [_detailInfoResult.detailinfo getString:@"User_ID"];
        
        //设置聊天会话界面要显示的标题
        chat.title = [_detailInfoResult.detailinfo getString:@"OrganizationName"];
        
        RCUserInfo* rcinfo = [[RCUserInfo alloc] initWithUserId:[_detailInfoResult.detailinfo getString:@"User_ID"] name:[_detailInfoResult.detailinfo getString:@"OrganizationName"] portrait:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[_detailInfoResult.detailinfo getString:@"Logo"]] ];
        [[RCIM sharedRCIM] refreshUserInfoCache:rcinfo withUserId:[_detailInfoResult.detailinfo getString:@"User_ID"]];
        
        //显示聊天会话界面
        [self.navigationController pushViewController:chat animated:YES];
    }
}

-(IBAction)userBargain:(id)sender{
    
    double distance = [self calculateWithX:[_detailInfoResult.detailinfo getDouble:@"X"] Y:[_detailInfoResult.detailinfo getDouble:@"Y"]];
    if (distance < 0.3) {
        [self getUserBargainRequest];
    }else{
        [[AppCustomHud sharedEKZCustomHud] showTextHud:BarginDistanceOutside];
    }
    
}

-(IBAction)chatOrg:(id)sender{
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 240, 100)];
    [textView.layer setBorderWidth:0.5];
    [textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
  [[[LGAlertView alloc] initWithViewAndTitle:@"咨询信息"
                                       message:nil
                                         style:LGAlertViewStyleAlert
                                          view:textView
                                  buttonTitles:@[@"确认"]
                             cancelButtonTitle:@"取消"
                        destructiveButtonTitle:nil
                                      delegate:self] showAnimated:YES completionHandler:nil];
    
    
}

-(IBAction)userAppointOrg:(id)sender{

}


-(IBAction)followOrginization:(id)sender{
    UIButton* currentButton = (UIButton*)sender;
    
    currentButton.selected = !currentButton.selected;
    if (currentButton.selected) {
        [self focusOrgRequest];
        
    }else{
        [self delFocusOrgRequest];
    }
}

#pragma mark - LGAlertViewDelegate
- (void)alertView:(nonnull LGAlertView *)alertView clickedButtonAtIndex:(NSUInteger)index title:(nullable NSString *)title{
    UITextView* textView = (UITextView*)alertView.innerView;
    [self appointOrgRequest:textView.text];
    DLog(@"lgalertview%@",textView.text);
    
    
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (currentSegIndex == 0) {
        return 7;
    }else if (currentSegIndex == 1){
        return [_classResult.detailinfo getDataItemArray:@"list"].size >5 ? 5:[_classResult.detailinfo getDataItemArray:@"list"].size;
    }else if (currentSegIndex == 2 || currentSegIndex == 3){
        return 4;
    }else{
        return [_relyResult.detailinfo getDataItemArray:@"replyList"].size >5 ? 5:[_relyResult.detailinfo getDataItemArray:@"replyList"].size;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (currentSegIndex == 0) {
        if (section == 0 || section == 1 || section == 6) {
            if (_detailInfoResult) {
                
                return 1;
            }else{
                return 0;
            }
        }else if (section == 2){
            if ([_detailInfoResult.detailinfo getString:@"CoursePeople"].length>0) {
                return 1;
            }else{
                return 0;
            }
        }else if (section == 3){
            if (_albumRequest.items.size) {
                return 1;
            }else{
                return 0;
            }
        }else if (section == 4){
            DataItemArray* itemArray = [_videoRequest.detailinfo getDataItemArray:@"videoList"];
            NSInteger number = 0;
            for (int i = 0; i < itemArray.size; i++) {
                DataItem* item = [itemArray getItem:i];
                if ([item getInt:@"VideoType"] == 0) {
                    number++;
                }
            }
            
            if (number > 0) {
                return 1;
            }else{
                return 0;
            }
        }else{
            
            
            DataItemArray* itemArray = [_videoRequest.detailinfo getDataItemArray:@"videoList"];
            NSInteger number = 0;
            for (int i = 0; i < itemArray.size; i++) {
                DataItem* item = [itemArray getItem:i];
                if ([item getInt:@"VideoType"] == 1) {
                    number++;
                }
            }
            
            if (number > 0) {
                return 1;
            }else{
                return 0;
            }
            
        }

    }else if (currentSegIndex == 2){
        if (section == 0) {
            return teacher0Aray.count>4?4:teacher0Aray.count;
        }else if (section ==1){
            return teacher1Aray.count>4?4:teacher1Aray.count;
        }else if (section == 2){
            return teacher2Aray.count>4?4:teacher2Aray.count;
        }else if (section == 3){
            return teacher3Aray.count>4?4:teacher3Aray.count;
        }else{
            return 0;
        }
    }
    else if (currentSegIndex == 3){
        if (section == 0) {
            return stuent0Aray.count>4?4:stuent0Aray.count;
        }else if (section ==1){
            return stuent1Aray.count>4?4:stuent1Aray.count;
        }else if (section == 2){
            return stuent2Aray.count>4?4:stuent2Aray.count;
        }else if (section == 3){
            return stuent3Aray.count>4?4:stuent3Aray.count;
        }else{
            return 0;
        }
        
    } else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (currentSegIndex == 3) {
        if (section == 0) {
          return  stuent0Aray.count >0 ? 44 :0.1;
        }else if (section == 1){
            return  stuent1Aray.count >0 ? 44 :0.1;
        }else if (section == 2){
            return  stuent2Aray.count >0 ? 44 :0.1;
        }else {
            return  stuent3Aray.count >0 ? 44 :0.1;
        }
        
    }else if (currentSegIndex == 2){
        if (section == 0) {
            return  teacher0Aray.count >0 ? 44 :0.1;
        }else if (section == 1){
            return  teacher1Aray.count >0 ? 44 :0.1;
        }else if (section == 2){
            return  teacher2Aray.count >0 ? 44 :0.1;
        }else {
            return  teacher3Aray.count >0 ? 44 :0.1;
        }

    }else{
        if (section == 0) {
            return 5;
        }else{
            if (currentSegIndex == 0) {
                return 4;
            }else{
                return 0.1;
            }
            
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (currentSegIndex == 0) {
        if (section == 6) {
            return 5;
        }
        return 1;
    }else{
        if (currentSegIndex == 1) {
            NSInteger maxSection = [_classResult.detailinfo getDataItemArray:@"list"].size >5 ? 5:[_classResult.detailinfo getDataItemArray:@"list"].size;
            
            if (section+1 == maxSection) {
                return 44;
            }else{
                return 0.1;
            }

        }else if (currentSegIndex == 2){
            if (section == 0) {
                return teacher0Aray.count >4 ? 44:0;
            }else if (section == 1){
                return teacher1Aray.count >4 ? 44:0;
            }else if (section == 2){
                return teacher2Aray.count >4 ? 44:0;
            }else{
                return teacher3Aray.count >4 ? 44:0;
            }
            
        }else if (currentSegIndex == 3){
            
            if (section == 0) {
                return stuent0Aray.count >4 ? 44:0;
            }else if (section == 1){
                return stuent1Aray.count >4 ? 44:0;
            }else if (section == 2){
                return stuent2Aray.count >4 ? 44:0;
            }else{
                return stuent3Aray.count >4 ? 44:0;
            }
            
        }else{
            NSInteger maxSection = [_relyResult.detailinfo getDataItemArray:@"replyList"].size >5 ? 5:[_relyResult.detailinfo getDataItemArray:@"replyList"].size;
            
            if (section+1 == maxSection) {
                return 44;
            }else{
                return 0.1;
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 0) {
        
        //简介 seg=0
        if (indexPath.section == 0) {
            return 90;
        }else if (indexPath.section == 1){
            return 218;
        }else if (indexPath.section == 2){
            return 220;
        }else if (indexPath.section == 6){
            return 230.0;
        }else{
            return (Main_Screen_Width-14)/3+43;
        }
        
    }else if (currentSegIndex == 2){
        return  [tableView fd_heightForCellWithIdentifier:@"OrgTeacher" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configCell:cell indexpath:indexPath];
        }];
    }else{
        return 80;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 0) {
        if (indexPath.section == 0) {
            OrgInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgInfoTableViewCell" owner:self options:nil].firstObject;
            [cell bingdingViewModel:_detailInfoResult.detailinfo];
            return cell;
        }else if (indexPath.section == 1){
            OrgHouseRateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgHouseRateTableViewCell" owner:self options:nil].firstObject;
            [cell bingdingViewModel:_detailInfoResult.detailinfo];
            return cell;
        }else if (indexPath.section == 2){
            OrgProportionTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgProportionTableViewCell" owner:self options:nil].firstObject;
            [cell bingdingViewModel:_detailInfoResult.detailinfo];
            return cell;
        }else if (indexPath.section == 6){
            OrgMapTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgMapTableViewCell" owner:self options:nil].firstObject;
            [cell bingdingViewModel:_detailInfoResult.detailinfo];
            return cell;
        }else{
            OrgAlbumVideoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgAlbumVideoTableViewCell" owner:self options:nil].firstObject;
            if (indexPath.section == 3) {
                cell.orgTitle.text = @"相册";
                [cell setupUI:_albumRequest Type:0];
            }else if (indexPath.section == 4){
                cell.orgTitle.text = @"学校视频";
                [cell setupUI:_videoRequest Type:1];
            }else{
                cell.orgTitle.text = @"在线试听";
                [cell setupUI:_videoRequest Type:2];
            }
            
            return cell;
        }

    }else if (currentSegIndex == 1){
        OrgClassTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgClassTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingVieModel:[[_classResult.detailinfo getDataItemArray:@"list"] getItem:indexPath.section]];
        return cell;
    }else if (currentSegIndex == 2){
        OrgTeacherTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgTeacherTableViewCell" owner:self options:nil].firstObject;
        [self configCell:cell indexpath:indexPath];
        
        if (indexPath.section == 0) {
            [cell bingdingViewModel:teacher0Aray[indexPath.row]];
        }else if (indexPath.section == 1){
            [cell bingdingViewModel:teacher1Aray[indexPath.row]];
        }else if (indexPath.section == 2){
            [cell bingdingViewModel:teacher2Aray[indexPath.row]];
        }else{
            [cell bingdingViewModel:teacher3Aray[indexPath.row]];
        }
        return cell;
    }else if (currentSegIndex == 3){
        OrgStudentTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgStudentTableViewCell" owner:self options:nil].firstObject;
        if (indexPath.section == 0) {
            [cell bingdingViewModel:stuent0Aray[indexPath.row]];
        }else if (indexPath.section == 1){
            [cell bingdingViewModel:stuent1Aray[indexPath.row]];
        }else if (indexPath.section == 2){
            [cell bingdingViewModel:stuent2Aray[indexPath.row]];
        }else{
            [cell bingdingViewModel:stuent3Aray[indexPath.row]];
        }
        return cell;
    }else{
        OrgEvaluateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgEvaluateTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:[[_relyResult.detailinfo getDataItemArray:@"replyList"] getItem:indexPath.section]];
        return cell;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (currentSegIndex == 2) {
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel* logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 5, 21)];
        logoLabel.backgroundColor = MAINCOLOR;
        [headerView addSubview:logoLabel];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 8, 200, 21)];
        titleLabel.text = OrgTeacherTitle[section];
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        titleLabel.textColor = [UIColor blackColor];
        [headerView addSubview:titleLabel];
        
        if (section == 0) {
            return teacher0Aray.count > 0 ? headerView :nil;
            
        }else if (section == 1){
            return teacher1Aray.count > 0 ? headerView :nil;
        }else if (section == 2){
            return teacher2Aray.count > 0 ? headerView :nil;
        }else{
            return teacher3Aray.count > 0 ? headerView :nil;
        }
        
    }else if (currentSegIndex == 3) {
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel* logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 5, 21)];
        logoLabel.backgroundColor = MAINCOLOR;
        [headerView addSubview:logoLabel];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(21, 8, 200, 21)];
        titleLabel.text = OrgStudentTitle[section];
        titleLabel.font = [UIFont systemFontOfSize:13.0];
        titleLabel.textColor = [UIColor blackColor];
        [headerView addSubview:titleLabel];
        
        if (section == 0) {
            return stuent0Aray.count > 0 ? headerView :nil;
            
        }else if (section == 1){
            return stuent1Aray.count > 0 ? headerView :nil;
        }else if (section == 2){
            return stuent2Aray.count > 0 ? headerView :nil;
        }else{
            return stuent3Aray.count > 0 ? headerView :nil;
        }
        
    }else{
        return nil;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (currentSegIndex == 0) {
        return nil;
    }else{
        
        if (currentSegIndex == 1) {
            NSInteger maxSection = [_classResult.detailinfo getDataItemArray:@"list"].size >5 ? 5:[_classResult.detailinfo getDataItemArray:@"list"].size;
            if (section+1 == maxSection && maxSection == 5) {
                UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                seeMoreFooter.text = @"查看更多";
                seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                seeMoreFooter.backgroundColor = [UIColor whiteColor];
                seeMoreFooter.userInteractionEnabled = YES;
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreCourse)];
                
                [seeMoreFooter addGestureRecognizer:tap];
                
                return seeMoreFooter;
            }else{
                return nil;
            }
        }else if(currentSegIndex == 2){
            if (section == 0) {
                if (teacher0Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreTeacher:)];
                    
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }else if (section == 1){
                if (teacher1Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreTeacher:)];
                    
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }else if (section == 2){
                if (teacher2Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreTeacher:)];
                    
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }else{
                if (teacher3Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreTeacher:)];
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }

            
        }else if (currentSegIndex ==3){
            if (section == 0) {
                if (stuent0Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreStudent:)];
                    
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }else if (section == 1){
                if (stuent1Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreStudent:)];
                    
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }else if (section == 2){
                if (stuent2Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreStudent:)];
                    
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }else{
                if (stuent3Aray.count > 4) {
                    UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                    seeMoreFooter.text = @"查看更多";
                    seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                    seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                    seeMoreFooter.backgroundColor = [UIColor whiteColor];
                    seeMoreFooter.userInteractionEnabled = YES;
                    seeMoreFooter.tag = section+1;
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreStudent:)];
                    
                    [seeMoreFooter addGestureRecognizer:tap];
                    return seeMoreFooter;
                }else{
                    return nil;
                }
            }
        }else{
            NSInteger maxSection = [_relyResult.detailinfo getDataItemArray:@"replyList"].size >5 ? 5:[_relyResult.detailinfo getDataItemArray:@"replyList"].size;
            if (section+1 == maxSection && maxSection == 5) {
                UILabel* seeMoreFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
                seeMoreFooter.text = @"查看更多";
                seeMoreFooter.font = [UIFont systemFontOfSize:13.0];
                seeMoreFooter.textAlignment = NSTextAlignmentCenter;
                seeMoreFooter.backgroundColor = [UIColor whiteColor];
                seeMoreFooter.userInteractionEnabled = YES;
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMoreEvaluate)];
                
                [seeMoreFooter addGestureRecognizer:tap];
                return seeMoreFooter;
            }else{
                return nil;
            }
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 0) {
        if (indexPath.section == 0) {
            [self performSegueWithIdentifier:@"DetailToContent" sender:self];
        }else if (indexPath.section == 3){
            [self performSegueWithIdentifier:@"DetailToPhotoBrowser" sender:self];
        }else if(indexPath.section == 4){
            videoType = @"0";
            [self performSegueWithIdentifier:@"DetailToVideo" sender:self];
        }else if(indexPath.section == 5){
            videoType = @"1";
            [self performSegueWithIdentifier:@"DetailToVideo" sender:self];
        }
    }else if (currentSegIndex == 1){
        selectCourseIndex = indexPath.section;
        [self performSegueWithIdentifier:@"DetailToCourseDetail" sender:self];
    }
}


- (void)configCell:(OrgTeacherTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    DataItem * item = [[_teacherResult.detailinfo getDataItemArray:@"teacherList"] getItem:indexpath.section];
    
    [cell.teacherTagView removeAllTags];
    
    cell.teacherTagView.preferredMaxLayoutWidth = Main_Screen_Width-94;
    
    cell.teacherTagView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
    cell.teacherTagView.lineSpacing = 5;
    cell.teacherTagView.interitemSpacing = 5;
    cell.teacherTagView.singleLine = NO;
    
    
    NSArray* array =  [NSArray arrayWithArray:[[item getString:@"TeachingTips"] componentsSeparatedByString:@","]] ;
    
    [array enumerateObjectsUsingBlock:^(NSString* text, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SKTag *tag = [[SKTag alloc] initWithText:text];
        
        tag.font = [UIFont systemFontOfSize:12];
        tag.textColor = [UIColor lightGrayColor];
        tag.bgColor =[UIColor whiteColor];
        tag.borderColor = [UIColor lightGrayColor];
        tag.borderWidth = 1.0;
        tag.cornerRadius = 3;
        tag.enable = YES;
        tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
        [cell.teacherTagView addTag:tag];
    }];

}

#pragma mark - SegChange
-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    if (currentSegIndex == 0) {
        [self getOrgDetailInfoRequest];
        [self gerOrgAlbumRequest];
        [self getVideoAlbumRequest];
    }else if (currentSegIndex == 1){
        [self getCourseListRequest];
    }else if (currentSegIndex == 2){
        [self getTeacherListRequest];
    }else if (currentSegIndex == 3){
        [self getStudentListRequest];
    }else if (currentSegIndex == 4){
        [self getRelyContentListRequest];
    }
}



#pragma mark - NetWorkRequest

-(void)getOrgDetailInfoRequest{
    [[OrginizationService sharedOrginizationService] getOrgDetailInfoParameters:@{@"orgApplication_ID":self.orgID} onCompletion:^(id json) {
        _detailInfoResult = json;
        
        [self setupInfoView];
        
        [self.tableView reloadData];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)gerOrgAlbumRequest{
    [[OrginizationService sharedOrginizationService] getAlbumWithParameters:@{@"orgId":self.orgID} onCompletion:^(id json) {
        _albumRequest = json;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getVideoAlbumRequest{
    [[OrginizationService sharedOrginizationService] getVideoWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(100)} onCompletion:^(id json) {
        _videoRequest = json;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getCourseListRequest{
    [[OrginizationService sharedOrginizationService] getOrgCourseListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(10)} onCompletion:^(id json) {
        _classResult = json;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getTeacherListRequest{
    [[OrginizationService sharedOrginizationService] getCourseTeacherListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(20)} onCompletion:^(id json) {
        
        teacher0Aray = [[NSMutableArray alloc] init];
        teacher1Aray = [[NSMutableArray alloc] init];
        teacher2Aray = [[NSMutableArray alloc] init];
        teacher3Aray = [[NSMutableArray alloc] init];

        
        _teacherResult = json;
        DataItemArray* itemArray =  [_teacherResult.detailinfo getDataItemArray:@"teacherList"];

        for (int i = 0 ; i < itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            if ([item getInt:@"TeacherType"] == 1) {
                [teacher0Aray addObject:item];
            }else if ([item getInt:@"TeacherType"] == 2){
                [teacher1Aray addObject:item];
            }else if ([item getInt:@"TeacherType"] == 3){
                [teacher2Aray addObject:item];
            }else if ([item getInt:@"TeacherType"] == 4){
                [teacher3Aray addObject:item];
            }
        }

        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getStudentListRequest{
    [[OrginizationService sharedOrginizationService] getStudentListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(20)} onCompletion:^(id json) {
        _studentResult = json;
        
        stuent0Aray = [[NSMutableArray alloc] init];
        stuent1Aray = [[NSMutableArray alloc] init];
        stuent2Aray = [[NSMutableArray alloc] init];
        stuent3Aray = [[NSMutableArray alloc] init];
        
        
        DataItemArray* itemArray =  [_studentResult.detailinfo getDataItemArray:@"studentList"];
     
        
        for (int i = 0 ; i < itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            if ([item getInt:@"StudentType"] == 1) {
                [stuent0Aray addObject:item];
            }else if ([item getInt:@"StudentType"] == 2){
                [stuent1Aray addObject:item];
            }else if ([item getInt:@"StudentType"] == 3){
                [stuent2Aray addObject:item];
            }else if ([item getInt:@"StudentType"] == 4){
                [stuent3Aray addObject:item];
            }
        }

        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getRelyContentListRequest{
    [[OrginizationService sharedOrginizationService] getOrgRelyContentListWithParameters:@{@"orgId":self.orgID,@"pageIndex":@(1),@"pageSize":@(10),@"replyflag":@"全部"} onCompletion:^(id json) {
        _relyResult = json;
        
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];

}

-(void)getAppointStateRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[OrginizationService sharedOrginizationService] getUserAppointMentStateWithParameters:@{@"orgApplication_ID":self.orgID,@"userId":info.userID} onCompletion:^(id json) {
        _appointStateResult = json;
        [self changeAppointState];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)judgeFocusOrgRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[OrginizationService sharedOrginizationService] judgeFocusOrgWithParameters:@{@"organizationId":self.orgID,@"userId":info.userID} onCompletion:^(id json) {
        _focusResult = json;
        if (_focusResult.statusCode == 0) {
            self.followTitle.text = @"关注";
            self.followButton.selected = NO;
        }else{
            self.followTitle.text = @"已关注";
            self.followButton.selected = YES;
        }
    } onFailure:^(id json) {
        
    }];
}

-(void)focusOrgRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[OrginizationService sharedOrginizationService] focusOrgWithOrgID:self.orgID Userid:info.userID onCompletion:^(id json) {
        self.followTitle.text = @"已关注";
    } onFailure:^(id json) {
        
    }];
}

-(void)delFocusOrgRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[OrginizationService sharedOrginizationService] delfocusOrgWithOrgID:self.orgID Userid:info.userID onCompletion:^(id json) {
        self.followTitle.text = @"关注";
    } onFailure:^(id json) {
        
    }];

}

-(void)getUserBargainRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[MyService sharedMyService] getUserBargainWithParameters:@{@"userId":info.userID,@"orgId":self.orgID,@"userMobile":info.telphone,@"name":info.username} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];
}


-(void)appointOrgRequest:(NSString*)acontent{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[OrginizationService sharedOrginizationService] appointOrgWithParameters:@{@"orgApplicationID":self.orgID,@"userId":info.userID,@"peopleContent":acontent} onCompletion:^(id json) {
        [self getAppointStateRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)getUserAdscriptionRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[MyService sharedMyService] GetUserAdscriptionWithParameters:@{@"orgId":self.orgID,@"userId":info.userID} onCompletion:^(id json) {
        _userAdsResult = json;
    } onFailure:^(id json) {
        
    }];
}

-(double)calculateWithX:(double)x Y:(double)y{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[info.userLatitude floatValue] longitude:[info.userLongitude floatValue]];
    CLLocation *orgLocation = [[CLLocation alloc] initWithLatitude:fabs(y) longitude:fabs(x)];
    double distance = [currentLocation distanceFromLocation:orgLocation]/1000.0;
    return distance;
}

@end
