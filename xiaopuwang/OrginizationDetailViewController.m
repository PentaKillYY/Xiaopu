//
//  OrginizationDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationDetailViewController.h"

#import "OrgDetailInfoTableViewCell.h"
#import "OrgDetailEvaluateTableViewCell.h"
#import "OrgDetailTagTableViewCell.h"
#import "OrgDetailAddressTableViewCell.h"
#import "OrgHouseRateTableViewCell.h"
#import "OrgProportionTableViewCell.h"
#import "OrgAlbumVideoTableViewCell.h"
#import "OrgClassTableViewCell.h"
#import "OrgTeacherTableViewCell.h"
#import "OrgStudentTableViewCell.h"
#import "OrgTitleClassTableViewCell.h"
#import "OrginizationService.h"
#import "MyService.h"
#import "UIActionSheet+Block.h"
#import "RedBagService.h"
#import <LGAlertView/LGAlertView.h>
#import "JZLocationConverter.h"
#import "OrgGroupCourseTableViewCell.h"

@interface OrginizationDetailViewController ()<UITableViewDataSource,UITableViewDelegate,LGAlertViewDelegate,AlbumVideoDelegate,OrgDetailCellDelegate,OrgTitleClassDelegate,OrgDetailAddressDelegate,UIActionSheetDelegate,OrgGroupCourseDelegate>{
    NSInteger currentSegIndex;
    
    DataResult* _detailInfoResult;
    DataResult* _groupCourseResult;
    DataResult* _albumRequest;
    DataResult* _videoRequest;
    DataResult* _classResult;
    DataResult* _teacherResult;
    DataResult* _studentResult;
    DataResult* _relyResult;
    DataResult* _appointStateResult;
    DataResult* _focusResult;
    DataResult* _userAdsResult;

    NSMutableArray* onlineMediaArray;
    NSMutableArray* videoArray;
    
    
    NSString* teacherType;
    NSString* studentType;
    
    NSString* videoType;
    
    NSInteger selectCourseIndex;
    
    UIVisualEffectView *effectview;
    UIButton* loginButton;
    
    NSInteger selectAlbumAndVideoIndex;
    
    NSInteger groupCourseCount;
    NSInteger teacherCount;
    NSInteger studentCount;
    NSInteger albumCount;
    NSInteger onlineMediaCount;
    NSInteger videoCount;
    NSInteger courseCount;
    UIButton* _rightButton;
    NSString* orderIndex;
    NSMutableArray* installmaps;
    NSString* groupCourseId;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;

@property(nonatomic,weak)IBOutlet UIButton* consultButton;
@property(nonatomic,weak)IBOutlet UIButton* dealOrderButton;
@property(nonatomic,weak)IBOutlet UIButton* payButton;

@end

@implementation OrginizationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"机构详情";
    self.view.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:233.0/255.0 alpha:1.0];
    installmaps = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgTeacherTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgTeacher"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgDetailAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgDetailAddress"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgDetailInfoTableViewCell" bundle:nil]forCellReuseIdentifier:@"OrgDetailInfo"];
    onlineMediaArray = [[NSMutableArray alloc] init];
    videoArray = [[NSMutableArray alloc] init];
    
    [self setupNav];
    [self setupBottomView];
    
    [self getOrgDetailInfoRequest];
    [self getGroupCourseByOrgRequest];
    [self gerOrgAlbumRequest];
    [self getVideoAlbumRequest];
    [self getTeacherListRequest];
    [self getStudentListRequest];
    [self getCourseListRequest];
    [self getRelyContentListRequest];
    [self judgeFocusOrgRequest];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loginUI];
}

-(void)setupNav{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightButton addTarget:self action:@selector(followOrginization:) forControlEvents:UIControlEventTouchUpInside];
    
    [_rightButton setImage:V_IMAGE(@"orgNotFocused") forState:0];
    [_rightButton setImage:V_IMAGE(@"orgFocused") forState:UIControlStateSelected];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightItem];

}


-(void)loginUI{
    if ([UserInfo sharedUserInfo].userID.length) {
        [self getAppointStateRequest];
        [self judgeFocusOrgRequest];
        [self getUserAdscriptionRequest];
        if (effectview) {
            [effectview removeFromSuperview];
            [loginButton removeFromSuperview];
        }
        
    }else{
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        
        
        effectview.frame = CGRectMake(0, 229, self.tableView.frame.size.width,self.tableView.frame.size.height);
        
        [self.tableView addSubview:effectview];
        
        loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setTitle:@"登录后查看" forState:0];
        [loginButton setFrame:CGRectMake(Main_Screen_Width/2-40, 229+80, 80, 80)];
        [loginButton setBackgroundColor:[UIColor clearColor]];
        loginButton.titleLabel.font = [UIFont systemFontOfSize:13];
        loginButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter ;
        [loginButton setTitleColor:MAINCOLOR forState:0];
        [loginButton addTarget:self action:@selector(needLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:loginButton];
    }
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
    }else if ([segue.identifier isEqualToString:@"DetailToMoreStudent"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.orgID forKey:@"orgID"];
    }else if ([segue.identifier isEqualToString:@"DetailToMoreEvaluate"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:self.orgID forKey:@"orgID"];
    }else if([segue.identifier isEqualToString:@"DetailToCourseDetail"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue: [[[_classResult.detailinfo getDataItemArray:@"list"] getItem:selectCourseIndex] getString:@"Organization_Course_ID"] forKey:@"courseId"];
    }else if ([segue.identifier isEqualToString:@"DetailToVideoPlayer" ]){
        id theSegue = segue.destinationViewController;

        
        if (selectAlbumAndVideoIndex<20) {
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            DataItemArray* itemArray = [_videoRequest.detailinfo getDataItemArray:@"videoList"];
            for (int i = 0; i < itemArray.size; i++) {
                DataItem* item = [itemArray getItem:i];
                if ([item getInt:@"VideoType"] == 0) {
                    [array addObject:item];
                }
            }

          [theSegue setValue:array[selectAlbumAndVideoIndex-10] forKey:@"currenrItem"];
        }else{
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            DataItemArray* itemArray = [_videoRequest.detailinfo getDataItemArray:@"videoList"];
            for (int i = 0; i < itemArray.size; i++) {
                DataItem* item = [itemArray getItem:i];
                if ([item getInt:@"VideoType"] == 1) {
                    [array addObject:item];
                }
            }
            
            [theSegue setValue:array[selectAlbumAndVideoIndex-20] forKey:@"currenrItem"];
        }
        
        
    }else if ([segue.identifier isEqualToString:@"DetailToMyOrder"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:orderIndex forKey:@"defaultIndex"];
    }else if ([segue.identifier isEqualToString:@"DetailToGroupCourseDetail"]){
        id theSegue = segue.destinationViewController;
        [theSegue setValue:groupCourseId forKey:@"courseId"];
    }
}

-(void)pushToMoreCourse{
    [self performSegueWithIdentifier:@"DetailToMoreCourse" sender:self];
}

-(void)pushToMoreEvaluate{
    [self performSegueWithIdentifier:@"DetailToMoreEvaluate" sender:self];
}

#pragma mark - SetUpUI

-(void)setupBottomView{
    self.dealOrderButton.userInteractionEnabled = NO;
}

-(IBAction)chatOrg:(id)sender{
    if (_appointStateResult.statusCode == 1) {
        if ([_userAdsResult.message isEqualToString:@"1"]) {
            
            //下单得红包
            [self redBagByContactRequest];
            
            //融云即时聊天
            [self contactByRongcloud];
        }

    }else{
        UserInfo* info = [UserInfo sharedUserInfo];
        
        if (info.userID.length) {
            UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 240, 100)];
            [textView.layer setBorderWidth:0.5];
            [textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            
            [[[LGAlertView alloc] initWithViewAndTitle:@"在线咨询学校官方老师"
                                               message:nil
                                                 style:LGAlertViewStyleAlert
                                                  view:textView
                                          buttonTitles:@[@"提交"]
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                              delegate:self] showAnimated:YES completionHandler:nil];
        }else{
            [self needLogin];
            
        }

    }
    
    
}

-(IBAction)userAppointOrg:(id)sender{
    
    UIButton* button = (UIButton*)sender;
    if (button.tag ==1) {
        orderIndex =@"0";
        if (_appointStateResult.statusCode == 1) {
             [self performSegueWithIdentifier:@"DetailToMyOrder" sender:self];
        }else{
            [[AppCustomHud sharedEKZCustomHud] showTextHud:@"你还未咨询该机构"];
        }
    }else{
        orderIndex =@"2";
        [self performSegueWithIdentifier:@"DetailToMyOrder" sender:self];
    }
}


-(void)contactByRongcloud{
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

-(void)followOrginization:(id)sender{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length) {
        UIButton* currentButton = (UIButton*)sender;
        
        currentButton.selected = !currentButton.selected;
        if (currentButton.selected) {
            [self focusOrgRequest];
            
        }else{
            [self delFocusOrgRequest];
        }
 
    }else{
        [self needLogin];
    }
}

#pragma mark - LGAlertViewDelegate
- (void)alertView:(nonnull LGAlertView *)alertView clickedButtonAtIndex:(NSUInteger)index title:(nullable NSString *)title{
    UITextView* textView = (UITextView*)alertView.innerView;
    [self appointOrgRequest:textView.text];
}

#pragma mark - AlbumVideoDelegate
-(void)albumClickDelegate:(id)sender{
    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    selectAlbumAndVideoIndex = tap.view.tag;
    
    if (tap.view.tag < 10) {
                
    }else if (tap.view.tag <20){
        [self performSegueWithIdentifier:@"DetailToVideoPlayer" sender:self];
    }else{
        [self performSegueWithIdentifier:@"DetailToVideoPlayer" sender:self];
    }
}


#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 13;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) {
        if ([_detailInfoResult.detailinfo getInt:@"SchoolScale"]==0 && [_detailInfoResult.detailinfo getInt:@"ReadPeople"]==0 &&
            [_detailInfoResult.detailinfo getInt:@"WillReadPeople"]==0) {
            return 0;
        }else{
            return 1;
        }
    }else if (section == 5){
        if ([_detailInfoResult.detailinfo getString:@"CoursePeople"].length) {
            return 1;
        }else{
            return 0;
        }
    }
    
    else if (section<6) {
        return 1;
    }else if (section==6){
        if (groupCourseCount) {
           return 1;
        }else{
            return 0;
        }
        
    }
    else if (section==7){
        if (teacherCount) {
            return 1;
        }else{
            return 0;
        }
    }else if (section==8){
        if (studentCount) {
            return 1;
        }else{
            return 0;
        }
    }else if (section==9){
        if (albumCount) {
            return 1;
        }else{
            return 0;
        }
    }else if (section==10){
        if (onlineMediaCount) {
            return 1;
        }else{
            return 0;
        }
    }else if (section==11){
        if (videoCount) {
            return 1;
        }else{
            return 0;
        }
    }else {
        if (courseCount) {
            return  [_classResult.detailinfo getDataItemArray:@"list"].size>3?3:[_classResult.detailinfo getDataItemArray:@"list"].size;
        }else{
            return 0;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
       
        return [tableView fd_heightForCellWithIdentifier:@"OrgDetailInfo" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configInfoCell:cell IndexPath:indexPath];
        }];
    }else if (indexPath.section<3) {
        return 44;
    }else if (indexPath.section == 3){
        return [tableView fd_heightForCellWithIdentifier:@"OrgDetailAddress" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configAddressCell:cell IndexPath:indexPath];
        }];
    }else if (indexPath.section==4){
        return 218;
    }else if (indexPath.section==5){
        return 220;
    }else if (indexPath.section==6){
        if (_groupCourseResult.items.size>2) {
            return (153+(Main_Screen_Width)/2)*2+29;
        }else if (_groupCourseResult.items.size>0){
            return (153+(Main_Screen_Width)/2)*1+29;
        }else{
            return 0;
        }
        
    }else if (indexPath.section ==7){
        return  [tableView fd_heightForCellWithIdentifier:@"OrgTeacher" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configCell:cell indexpath:indexPath];
        }];
    }else if (indexPath.section ==8){
        return 118;
    }else if (indexPath.section ==9){
        return (Main_Screen_Width-14)/3+43;
    }else if (indexPath.section ==10){
        return (Main_Screen_Width-14)/3+43;
    }else if (indexPath.section ==11){
        return (Main_Screen_Width-14)/3+43;
    }else {
        if (indexPath.row ==0) {
            return 108;
        }
        return 80;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }else if (section==4){
        if ([_detailInfoResult.detailinfo getInt:@"SchoolScale"]==0 && [_detailInfoResult.detailinfo getInt:@"ReadPeople"]==0 &&
            [_detailInfoResult.detailinfo getInt:@"WillReadPeople"]==0){
            return 0.01;
        }else{
            return 5;
        }
    }else if (section==5){
        if ([_detailInfoResult.detailinfo getString:@"CoursePeople"].length){
            return 5;
        }else{
            return 0.01;
        }
    }else if (section==6){
        if (groupCourseCount) {
            return 5;
        }else{
            return 0.01;
        }
    }else if (section ==7){
        if (teacherCount) {
            return 5;
        }else{
            return 0.01;
        }
    }else if (section ==8){
        if (studentCount) {
            return 5;
        }else{
            return 0.01;
        }
    }else if (section ==9){
        if (albumCount) {
            return 5;
        }else{
            return 0.01;
        }
    }else if (section ==10){
        if (onlineMediaCount) {
            return 5;
        }else{
            return 0.01;
        }
    }else if (section ==11){
        if (videoCount) {
            return 5;
        }else{
            return 0.01;
        }
    }else if (section==12){
        if (courseCount){
            return 5;
        }else{
            return 0.01;
        }
    }
    
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrgDetailInfoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgDetailInfoTableViewCell" owner:self options:nil].firstObject;
        [self configInfoCell:cell IndexPath:indexPath];
//        [cell bingdingImageModel:_albumRequest.items];
        
        cell.delegate = self;
        return cell;
    }else if (indexPath.section ==1){
        OrgDetailEvaluateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgDetailEvaluateTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_relyResult];
        return cell;
    }else if (indexPath.section==2){
        OrgDetailTagTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgDetailTagTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_detailInfoResult.detailinfo];
        return cell;
    }else if (indexPath.section==3){
        OrgDetailAddressTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgDetailAddressTableViewCell" owner:self options:nil].firstObject;
        [self configAddressCell:cell IndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section==4){
        OrgHouseRateTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgHouseRateTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_detailInfoResult.detailinfo];
        return cell;
    }else if (indexPath.section==5){
        OrgProportionTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgProportionTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:_detailInfoResult.detailinfo];
        return cell;
    }else if (indexPath.section==6){
        OrgGroupCourseTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgGroupCourseTableViewCell" owner:self options:nil].firstObject;
        if (groupCourseCount) {
            [cell bingdingViewModel:_groupCourseResult];
        }
        cell.delegate = self;
        return cell;

    }else if (indexPath.section==7){
        OrgTeacherTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgTeacherTableViewCell" owner:self options:nil].firstObject;
        if (teacherCount) {
            [self configCell:cell indexpath:indexPath];
            [cell bingdingViewModel:[[_teacherResult.detailinfo getDataItemArray:@"teacherList"] getItem:0]];
        }
        return cell;
        
    }else if (indexPath.section==8){
        OrgStudentTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgStudentTableViewCell" owner:self options:nil].firstObject;
        if (studentCount) {
            [cell bingdingViewModel:[[_studentResult.detailinfo getDataItemArray:@"studentList"] getItem:0]];
        }
        
        return cell;
    }else if (indexPath.section==9){
        OrgAlbumVideoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgAlbumVideoTableViewCell" owner:self options:nil].firstObject;
        if (albumCount) {
            cell.orgTitle.text = @"相册";
            [cell setupUI:_albumRequest Type:0];
        }
        cell.delegate = self;

        return cell;
    }else if (indexPath.section==10){
        OrgAlbumVideoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgAlbumVideoTableViewCell" owner:self options:nil].firstObject;
        if (onlineMediaCount) {
            cell.orgTitle.text = @"学校视频";
            [cell setupUI:_videoRequest Type:1];
        }
        cell.delegate = self;

        return cell;
    }else if (indexPath.section==11){
        OrgAlbumVideoTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgAlbumVideoTableViewCell" owner:self options:nil].firstObject;
        if (videoCount) {
            cell.orgTitle.text = @"在线试听";
            [cell setupUI:_videoRequest Type:2];
        }
        cell.delegate = self;

        return cell;
    }else{
        if (courseCount==0) {
            OrgClassTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgClassTableViewCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            if (indexPath.row ==0) {
               OrgTitleClassTableViewCell * cell = [[NSBundle mainBundle] loadNibNamed:@"OrgTitleClassTableViewCell" owner:self options:nil].firstObject;
                [cell bingdingVieModel:[[_classResult.detailinfo getDataItemArray:@"list"] getItem:indexPath.row]];
                cell.delegate=self;
                return cell;

            }else{
                OrgClassTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgClassTableViewCell" owner:self options:nil].firstObject;
                [cell bingdingVieModel:[[_classResult.detailinfo getDataItemArray:@"list"] getItem:indexPath.row]];
                return cell;

            }
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        [self performSegueWithIdentifier:@"DetailToMoreEvaluate" sender:self];
    }else if (indexPath.section==7){
        [self performSegueWithIdentifier:@"DetailToMoreTeacher" sender:self];
    }else if (indexPath.section==8){
        [self performSegueWithIdentifier:@"DetailToMoreStudent" sender:self];
    }else if (indexPath.section==9){
        [self performSegueWithIdentifier:@"DetailToPhotoBrowser" sender:self];
    }else if (indexPath.section==10){
        videoType = @"0";
        [self performSegueWithIdentifier:@"DetailToVideo" sender:self];
    }else if (indexPath.section==11){
        videoType = @"1";
        [self performSegueWithIdentifier:@"DetailToVideo" sender:self];
    }else if (indexPath.section==12){
        selectCourseIndex = indexPath.row;
        [self performSegueWithIdentifier:@"DetailToCourseDetail" sender:self];
    }
}

- (void)configCell:(OrgTeacherTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    DataItem * item = [[_teacherResult.detailinfo getDataItemArray:@"teacherList"] getItem:0];
    
    [cell.teacherTagView removeAllTags];
    
    cell.teacherTagView.preferredMaxLayoutWidth = Main_Screen_Width-94;
    
    cell.teacherTagView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
    cell.teacherTagView.lineSpacing = 5;
    cell.teacherTagView.interitemSpacing = 5;
    cell.teacherTagView.singleLine = NO;
    
    
    NSArray* array =  [NSArray arrayWithArray:[[item getString:@"TeachingTips"] componentsSeparatedByString:@","]] ;
    if (array.count) {
        cell.teacherTagView.hidden = NO;
    }else{
        cell.teacherTagView.hidden = YES;
    }
    
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

-(void)configAddressCell:(OrgDetailAddressTableViewCell*)cell IndexPath:(NSIndexPath*)path{
    cell.addressLabel.preferredMaxLayoutWidth = Main_Screen_Width-95;
    cell.addressLabel.numberOfLines = 0;
    [cell bingdingViewModel:_detailInfoResult.detailinfo];
}

-(void)configInfoCell:(OrgDetailInfoTableViewCell*)cell IndexPath:(NSIndexPath*)path{
    cell.orgName.preferredMaxLayoutWidth = Main_Screen_Width-104;
    cell.orgName.numberOfLines = 0;
    [cell bingdingViewModel:_detailInfoResult.detailinfo];
}

#pragma mark - DetailDelegate
-(void)showMoreInfo:(id)sender{
    [self performSegueWithIdentifier:@"DetailToContent" sender:self];
}

#pragma mark - OrgDetailAddressDelegate
-(void)navToAddress:(id)sender{
    CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){[_detailInfoResult.detailinfo getDouble:@"Y"], [_detailInfoResult.detailinfo getDouble:@"X"]};
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"选择地图导航" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:[self getInstalledMapAppWithEndLocation:startPt]];
    sheet.delegate = self;
    [sheet showInView:self.view];
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self navAppleMap];
    }else {
        NSDictionary *dic = installmaps[buttonIndex];
        NSString *urlString = dic[@"url"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

//苹果地图
- (void)navAppleMap
{
    CLLocationCoordinate2D gps = (CLLocationCoordinate2D){[_detailInfoResult.detailinfo getDouble:@"Y"], [_detailInfoResult.detailinfo getDouble:@"X"]};
    
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:gps addressDictionary:nil]];
    NSArray *items = @[currentLoc,toLocation];
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

#pragma mark - 导航方法
- (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation
{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:@"苹果地图"];
    [installmaps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        CLLocationCoordinate2D baiduLocation = [JZLocationConverter gcj02ToBd09: endLocation];
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving&src=webapp.navi.ings.xiaopuwang",[info.userLatitude doubleValue],[info.userLongitude doubleValue] ,baiduLocation.latitude,baiduLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        
        baiduMapDic[@"url"] = urlString;
        [maps addObject:@"百度地图"];
        [installmaps addObject:baiduMapDic];

    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"xiaopuwang",@"xiaopuwang",endLocation.latitude,endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:@"高德地图"];
        [installmaps addObject:gaodeMapDic];

    }
    
    return maps;
}

#pragma mark - OrgGroupCourseDelegate
-(void)orgGroupCourseToDetailDelegate:(NSInteger)itemIndex{
    DataItem* item = [_groupCourseResult.items getItem:itemIndex];
    groupCourseId = [item getString:@"FightCourseId"];
    [self performSegueWithIdentifier:@"DetailToGroupCourseDetail" sender:self];
}

#pragma mark - ALbumDelegate
- (void)pictureBrowserDidShow:(SRPictureBrowser *)pictureBrowser {
    
    NSLog(@"%s", __func__);
}

- (void)pictureBrowserDidDismiss {
    
    NSLog(@"%s", __func__);
}

#pragma mark - OrgTitleClassDelegate
-(void)moreClassDelegate:(id)sender{
    [self performSegueWithIdentifier:@"DetailToMoreCourse" sender:self];
}

#pragma mark - NetWorkRequest

-(void)getOrgDetailInfoRequest{
    [[OrginizationService sharedOrginizationService] getOrgDetailInfoParameters:@{@"orgApplication_ID":self.orgID} onCompletion:^(id json) {
        _detailInfoResult = json;
        
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(0, 6)];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } onFailure:^(id json) {
        
    }];
}

-(void)getGroupCourseByOrgRequest{
    [[OrginizationService sharedOrginizationService] groupCourseByOrgWithParameters:@{@"orgId":self.orgID} onCompletion:^(id json) {
        _groupCourseResult = json;
        groupCourseCount = _groupCourseResult.items.size>0?1:0;
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:6];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } onFailure:^(id json) {
        
    }];
}

-(void)gerOrgAlbumRequest{
    [[OrginizationService sharedOrginizationService] getAlbumWithParameters:@{@"orgId":self.orgID} onCompletion:^(id json) {
        _albumRequest = json;
        albumCount = _albumRequest.items.size>0?1:0;
        NSMutableIndexSet *idxSet = [[NSMutableIndexSet alloc] init];
        [idxSet addIndex:0];
        [idxSet addIndex:9];
        [self.tableView reloadSections:idxSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getVideoAlbumRequest{
    [[OrginizationService sharedOrginizationService] getVideoWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(100)} onCompletion:^(id json) {
        _videoRequest = json;
        DataItemArray* itemArray = [_videoRequest.detailinfo getDataItemArray:@"videoList"];
        for (int i = 0; i < itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            if ([item getInt:@"VideoType"] == 0) {
                [onlineMediaArray addObject:item];
            }else{
                [videoArray addObject:item];
            }
        }
        onlineMediaCount = onlineMediaArray.count>0?1:0;
        videoCount = videoArray.count>0?1:0;
        
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(10, 2)];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } onFailure:^(id json) {
        
    }];
}

-(void)getCourseListRequest{
    [[OrginizationService sharedOrginizationService] getOrgCourseListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(10)} onCompletion:^(id json) {
        _classResult = json;
        courseCount = [_classResult.detailinfo getDataItemArray:@"list"].size>0?1:0;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:12];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } onFailure:^(id json) {
        
    }];
}

-(void)getTeacherListRequest{
    [[OrginizationService sharedOrginizationService] getCourseTeacherListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(20)} onCompletion:^(id json) {
        _teacherResult = json;
        teacherCount = [_teacherResult.detailinfo getDataItemArray:@"teacherList"].size>0?1:0;

        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:7];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } onFailure:^(id json) {
        
    }];
}

-(void)getStudentListRequest{
    [[OrginizationService sharedOrginizationService] getStudentListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(1),@"pageSize":@(20)} onCompletion:^(id json) {
        _studentResult = json;
        studentCount = [_studentResult.detailinfo getDataItemArray:@"studentList"].size>0?1:0;
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:8];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        

    } onFailure:^(id json) {
        
    }];
}

-(void)getRelyContentListRequest{
    [[OrginizationService sharedOrginizationService] getOrgRelyContentListWithParameters:@{@"orgId":self.orgID,@"pageIndex":@(1),@"pageSize":@(10),@"replyflag":@"全部"} onCompletion:^(id json) {
        _relyResult = json;
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } onFailure:^(id json) {
        
    }];

}

-(void)getAppointStateRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[OrginizationService sharedOrginizationService] getUserAppointMentStateWithParameters:@{@"orgApplication_ID":self.orgID,@"userId":info.userID} onCompletion:^(id json) {
        _appointStateResult = json;
        
        self.dealOrderButton.userInteractionEnabled = YES;
        [self.dealOrderButton setImage:V_IMAGE(@"DealAvailable") forState:UIControlStateNormal];
        [self.dealOrderButton setImage:V_IMAGE(@"DealAVailableClicked") forState:UIControlStateHighlighted];
        [self.tableView reloadData];
    } onFailure:^(id json) {
        _appointStateResult = json;
        self.dealOrderButton.userInteractionEnabled = YES;
        [self.tableView reloadData];
    }];
}

-(void)judgeFocusOrgRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length) {
        [[OrginizationService sharedOrginizationService] judgeFocusOrgWithParameters:@{@"organizationId":self.orgID,@"userId":info.userID} onCompletion:^(id json) {
            _focusResult = json;
            _rightButton.selected = YES;
        } onFailure:^(id json) {
            _focusResult = json;
            _rightButton.selected = NO;
        }];
    }
    
}

-(void)focusOrgRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[OrginizationService sharedOrginizationService] focusOrgWithOrgID:self.orgID Userid:info.userID onCompletion:^(id json) {
        _rightButton.selected = YES;
    } onFailure:^(id json) {
        
    }];
}

-(void)delFocusOrgRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[OrginizationService sharedOrginizationService] delfocusOrgWithOrgID:self.orgID Userid:info.userID onCompletion:^(id json) {
        _rightButton.selected = NO;
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
        [self sendAppointToOrgRequest];
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

-(void)sendAppointToOrgRequest{
    [[OrginizationService sharedOrginizationService] sendToOrgWithParameters:@{@"mobile":[_detailInfoResult.detailinfo getString:@"ContactMobile"],@"name":[_detailInfoResult.detailinfo getString:@"ContactPeople"]} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];
}

-(void)redBagByContactRequest{
    [[RedBagService sharedRedBagService] getRedBagByContactWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"organization_Application_ID":self.orgID} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];
}

-(double)calculateWithX:(double)x Y:(double)y{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    if (info.userLatitude && info.userLongitude) {
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[info.userLatitude floatValue] longitude:[info.userLongitude floatValue]];
        CLLocation *orgLocation = [[CLLocation alloc] initWithLatitude:fabs(y) longitude:fabs(x)];
        double distance = [currentLocation distanceFromLocation:orgLocation]/1000.0;
        return distance;
    }else{
        return 0.0;
    }
}

-(void)needLogin{
    UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
    [self presentViewController:login animated:YES completion:^{
        
    }];
}
@end
