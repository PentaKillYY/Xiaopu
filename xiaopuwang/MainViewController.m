//
//  MainViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainViewController.h"
#import "MainCycleTableViewCell.h"
#import "MainRollingTableViewCell.h"
#import "MainServiceTableViewCell.h"
#import "MainActivityTableViewCell.h"
#import "MainPreferedTableViewCell.h"
#import "VideoCourseTableViewCell.h"
#import "LocalSelectTableViewCell.h"
#import "UIButton+JKImagePosition.h"
#import "UIButton+JKMiddleAligning.h"
#import "MainService.h"
#import "MyService.h"
#import "LocalSelectOrgCell.h"
#import "LocalSelectSchoolCell.h"
#import "LocalSelectTeacherCell.h"
#import "OrginizationTableViewCell.h"
#import "MainTypeTableViewCell.h"
#import "ThityBackOrgTitleTableViewCell.h"
#import "HomeGroupCourseTitleCell.h"
#import "HomeGroupCourseTableViewCell.h"
#import "OrginizationService.h"
#import "SchoolService.h"
#import "GroupCourseService.h"
#import "CommunityOneLineImageCell.h"
#import "CommunityService.h"
#import "MainCommunityTitleTableViewCell.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ServiceDelegate,AMapLocationManagerDelegate,PreferredTapDelegate,VideoCourseCellDelegate,LocalSelectDelegate,MainTypeDelegate,HomeGroupCourseDelegate,MainCycleDelegate>
{
    DataResult* advertisementResult;
    DataResult* videoCourseResult;
    DataResult* teacherResult;
    DataResult* localOrgResult;
    DataResult* localInterSchoolResult;
    DataResult* localChinaSchoolResult;
    
    NSInteger currentOrgIndex;
    NSInteger selectVideoIndex;
    NSInteger selectLocalIndex;
    
    NSInteger currentSelectTeacherIndex;
    NSInteger currentSelectOrgIndex;
    NSInteger currentSelectSchoolIndex;
    NSInteger currentSelectChinaSchoolIndex;
    NSInteger selectCommunityIndex;
    
    NSString* chinaSchoolType;
    NSString* schoolType;
    NSString* orgType;
    NSString* orgKind;
    
    NSMutableDictionary* tagDic;
    DataItemArray* orgListArray;
    DataItemArray* groupCourseArray;
    DataItemArray* communityListArray;

    NSInteger currentGroupCourseIndex;
    NSInteger current30DayIndex;
    NSInteger currentServiceIndex;
}

@property (nonatomic,weak)IBOutlet UITableView* tableView;
@property (nonatomic,strong) UISearchBar* searchBar;
@property (nonatomic,strong) UIButton* rightButton;
@property (nonatomic,strong) UIButton* leftButton;


@property (nonatomic,strong) AMapLocationManager* locationManager;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    orgListArray = [DataItemArray new];
    groupCourseArray = [DataItemArray new];
    communityListArray = [DataItemArray new];
    
    tagDic = [[NSMutableDictionary alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LocalSelectOrgCell" bundle:nil] forCellReuseIdentifier:@"LocalSelectOrgCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrginizationTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommunityOneLineImageCell" bundle:nil] forCellReuseIdentifier:@"CommunityOneLineImageCell"];

    
    [self changeNavTitleView];
    [self loginRequest];
    
    [self getMainData];
    
    [self getThirtyBackCourseList];
    [self getGroupCourseListRequest];
    [self getComunityListRequest];
    [self getCourseVideoListRequest];
    [self getTeaherListRequest];
    
    [self configLocationManager];
    [self startSerialLocation];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}


+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)changeNavTitleView{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    if ([info.firstSelectIndex intValue]) {
        [_leftButton setTitle:[NSString stringWithFormat:@"无锡 %@",HomeSelectTitle[[info.firstSelectIndex intValue]]] forState:0];
    }else{
        [_leftButton setTitle:[NSString stringWithFormat:@"无锡 %@",HomeSelectSecondTitle[[info.secondSelectIndex intValue]]] forState:0];
    }
    
    [_leftButton setImage:V_IMAGE(@"whiteDown") forState:0];
    [_leftButton jk_setImagePosition:1 spacing:8];
    [_leftButton setFrame:CGRectMake(0, 0, 100, 44)];
    [_leftButton addTarget:self action:@selector(goToSelect) forControlEvents:UIControlEventTouchUpInside];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-88, 44)];
    UIImage* clearImg = [MainViewController imageWithColor:[UIColor clearColor] andHeight:44.0f];
    [_searchBar setBackgroundImage:clearImg];
    _searchBar.placeholder = @"机构、学校、课程名称";
    [_searchBar setBackgroundColor:[UIColor clearColor]];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(0, 0, 44, 44)];
    [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_rightButton addTarget:self action:@selector(goToWeb) forControlEvents:UIControlEventTouchUpInside];
    if ([[UserInfo sharedUserInfo].isReadIntro isEqualToString:@"read"]) {
        [_rightButton setImage:V_IMAGE(@"IntroRead") forState:0];
    }else{
        [_rightButton setImage:V_IMAGE(@"IntroUnread") forState:0];
    }
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;

    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftItem];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightItem];
    
    self.navigationItem.titleView = _searchBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainToEducationPlan"]) {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:[NSString stringWithFormat:@"%ld",(long)currentServiceIndex] forKey:@"currentSelectIndex"];
        
    }else if([segue.identifier isEqualToString:@"MainToOrgDetail"])
    {
        id theSegue = segue.destinationViewController;
        
        if (selectLocalIndex ==0) {
            DataItem* item = [[teacherResult.detailinfo getDataItemArray:@"teacherList"] getItem:currentSelectTeacherIndex-1];
            [theSegue setValue:[item getString:@"Organization_Application_ID"] forKey:@"orgID"];
        }else{
            DataItem* item = [[localOrgResult.detailinfo getDataItemArray:@"orglist"] getItem:currentSelectOrgIndex-1];
            [theSegue setValue:[item getString:@"Organization_Application_ID"] forKey:@"orgID"];
        }
        
        
    }else if ([segue.identifier isEqualToString:@"MainToSchoolDetail"]){
        id theSegue = segue.destinationViewController;
        DataItem* item = [[localInterSchoolResult.detailinfo getDataItemArray:@"list"] getItem:currentSelectSchoolIndex-1];
        [theSegue setValue:[item getString:@"School_BasicInfo_ID"] forKey:@"basicID"];
        [theSegue setValue:[item getString:@"School_Application_ID"] forKey:@"applicationID"];
    }else if ([segue.identifier isEqualToString:@"MainToChinaSchoolDetail"]){
        id theSegue = segue.destinationViewController;
        
        DataItem* item = [[localChinaSchoolResult.detailinfo getDataItemArray:@"ChinaSchoolList"] getItem:currentSelectChinaSchoolIndex-1];
        
        [theSegue setValue:[item getString:@"Id"] forKey:@"schoolID"];
    }else if([segue.identifier isEqualToString:@"MainToVideoPlayer"])
    {
        id theSegue = segue.destinationViewController;
        DataItem* item = [videoCourseResult.items getItem:selectVideoIndex];
        
        [theSegue setValue:item forKey:@"currenrItem"];
    }else if ([segue.identifier isEqualToString:@"MainToOrgList"]){
        segue.destinationViewController.hidesBottomBarWhenPushed = YES;
        id theSegue = segue.destinationViewController;
        [theSegue setValue:orgType forKey:@"orgType"];
        [theSegue setValue:orgKind forKey:@"orgKind"];
    }
    else if ([segue.identifier isEqualToString:@"MainToSchoolList"] ){
        segue.destinationViewController.hidesBottomBarWhenPushed = YES;
        id theSegue = segue.destinationViewController;
        [theSegue  setValue:schoolType forKey:@"schoolCountryName"];
    }else if ([segue.identifier isEqualToString:@"MainToChinaSchoolList"]){
        segue.destinationViewController.hidesBottomBarWhenPushed = YES;
        id theSegue = segue.destinationViewController;
        [theSegue  setValue:chinaSchoolType forKey:@"chinaType"];
        
    }
    
    else if ([segue.identifier isEqualToString:@"MainTo30DayOrg"]){
        segue.destinationViewController.hidesBottomBarWhenPushed = YES;
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"1" forKey:@"is30Day"];
    }else if([segue.identifier isEqualToString:@"MainToGroupCourseDetail"])
    {
        id theSegue = segue.destinationViewController;
        DataItem* item = [groupCourseArray getItem:currentGroupCourseIndex];
        
        [theSegue setValue:[item getString:@"FightCourseId"] forKey:@"courseId"];
    }else if ([segue.identifier isEqualToString:@"MainTo30DayOrgDetail"]){
        id theSegue = segue.destinationViewController;

        DataItem* item = [orgListArray getItem:current30DayIndex-1];

        [theSegue setValue:[item getString:@"Organization_Application_ID"] forKey:@"orgID"];
    }if([segue.identifier isEqualToString:@"MainToCommunityDetail"])
    {
        id theSegue = segue.destinationViewController;
        
        DataItem* item =[communityListArray getItem:selectCommunityIndex];
        
        [theSegue setValue:[item getString:@"Id"] forKey:@"communityId"];
    }

}

-(void)goToSelect{
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AppDelegate*delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UINavigationController* nav = [mainStoryboard instantiateViewControllerWithIdentifier:@"SelectNav"];
    delegate.window.rootViewController = nav;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        if (orgListArray.size) {
            if (orgListArray.size ==1) {
                return 2;
            }else{
                return 3;
            }
        }else{
            return 0;
        }
    }else if (section ==4){
        if (groupCourseArray.size) {
            return 2;
        }else{
            return 0;
        }
    }else if (section ==5){
        if (communityListArray.size) {
            return communityListArray.size+1;
        }else{
            return 0;
        }
    }else if (section == 7) {
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MainCycleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainCycleTableViewCell" owner:self options:nil].firstObject;
        cell.dataresult = advertisementResult;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section ==1){
        MainTypeTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainTypeTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        [cell setupUI];
        return cell;
    }
    else if (indexPath.section == 2){
        MainServiceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainServiceTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section==3){
        if (indexPath.row==0) {
            ThityBackOrgTitleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"ThityBackOrgTitleTableViewCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            OrginizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrgCell" forIndexPath:indexPath];
            
            [self configCell:cell indexpath:indexPath];
            
            return cell;
        }
    }else if(indexPath.section ==4){
        if (indexPath.row==0) {
            HomeGroupCourseTitleCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HomeGroupCourseTitleCell" owner:self options:nil].firstObject;
            
            return cell;
        }else{
            HomeGroupCourseTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HomeGroupCourseTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            [cell bingdingViewModel:groupCourseArray];
            return cell;

        }
        
    }else if (indexPath.section==5){
        if (indexPath.row==0) {
            MainCommunityTitleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainCommunityTitleTableViewCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            CommunityOneLineImageCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityOneLineImageCell" owner:self options:nil].firstObject;
            [self configCommunityCell:cell IndexPath:indexPath];
            return cell;
        }
        
        
    }else if (indexPath.section == 6){
        VideoCourseTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"VideoCourseTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        [cell bingdingViewModel:videoCourseResult];
        return cell;
        
    }else{
        if (indexPath.row ==0) {
            LocalSelectTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"LocalSelectTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            
            if (selectLocalIndex == 0) {
                cell.teacherButton.backgroundColor = [UIColor colorWithHexString:@"#c8c9ca"];
                cell.orgButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.interSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.chinaSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                
            }else if (selectLocalIndex == 1){
                cell.teacherButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.orgButton.backgroundColor = [UIColor colorWithHexString:@"#c8c9ca"];
                cell.interSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.chinaSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
            }else if (selectLocalIndex == 2){
                cell.teacherButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.orgButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.interSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#c8c9ca"];
                cell.chinaSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
            }else{
                cell.teacherButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.orgButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.interSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
                cell.chinaSchoolButton.backgroundColor = [UIColor colorWithHexString:@"#c8c9ca"];
            }

            return cell;
        }else{
            if (selectLocalIndex == 0) {
                LocalSelectTeacherCell* cell = [[NSBundle mainBundle] loadNibNamed:@"LocalSelectTeacherCell" owner:self options:nil].firstObject;
                [cell bingdingViewModel:[[teacherResult.detailinfo getDataItemArray:@"teacherList"] getItem:indexPath.row-1]];
                return cell;
            }else if (selectLocalIndex == 1){
                LocalSelectOrgCell* cell = [[NSBundle mainBundle] loadNibNamed:@"LocalSelectOrgCell" owner:self options:nil].firstObject;
                [self configOrgCell:cell indexpath:indexPath];
                return cell;
            }else{
                LocalSelectSchoolCell* cell = [[NSBundle mainBundle] loadNibNamed:@"LocalSelectSchoolCell" owner:self options:nil].firstObject;
                if (selectLocalIndex ==3) {
                    DataItem* item = [[localInterSchoolResult.detailinfo getDataItemArray:@"list"] getItem:indexPath.row-1];
                    [cell bingdingViewModel:item];
                }else{
                    DataItem* item = [[localChinaSchoolResult.detailinfo getDataItemArray:@"ChinaSchoolList"] getItem:indexPath.row-1];
                    [cell bingdingViewModel:item];
                
                }
                return cell;
            }
        }
        
    }
}

- (void)configCell:(OrginizationTableViewCell *)cell indexpath:(NSIndexPath *)indexpath {
    
    if (orgListArray.size) {
        DataItem* item = [orgListArray getItem:indexpath.row-1];
        
        [cell bingdingViewModel:item] ;
        
        [cell.orgClassView removeAllTags];
        
        cell.orgClassView.preferredMaxLayoutWidth = Main_Screen_Width-121;
        
        cell.orgClassView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
        cell.orgClassView.lineSpacing = 5;
        cell.orgClassView.interitemSpacing = 5;
        cell.orgClassView.singleLine = NO;
        
        
        DataItemArray* itemArray =   [[DataItemArray alloc] init];
        [itemArray append:[tagDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexpath.row]]];
        NSArray* array =  [NSArray arrayWithArray:[itemArray toArray]] ;
        [array enumerateObjectsUsingBlock:^(DataItem* item, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SKTag *tag = [[SKTag alloc] initWithText:[item getString:@"CourseClassType"]];
            
            tag.font = [UIFont systemFontOfSize:12];
            tag.textColor = [UIColor lightGrayColor];
            tag.bgColor =[UIColor whiteColor];
            tag.borderColor = [UIColor lightGrayColor];
            tag.borderWidth = 1.0;
            tag.cornerRadius = 3;
            tag.enable = YES;
            tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
            [cell.orgClassView addTag:tag];
        }];

    }
}


- (void)configOrgCell:(LocalSelectOrgCell *)cell indexpath:(NSIndexPath *)indexpath{
    [cell bingdingViewModel:[[localOrgResult.detailinfo getDataItemArray:@"orglist"] getItem:indexpath.row-1]];
}

-(void)configCommunityCell:(CommunityOneLineImageCell*)cell IndexPath:(NSIndexPath*)path{
    DataItem* item = [communityListArray getItem:path.row-1];
    [cell bingdingViewModel:item];
    
    
    if ([item getString:@"ImageUrl"].length) {
        // img  九宫格图片，用collectionView做
        NSArray* imageArray = [[item getString:@"ImageUrl"] componentsSeparatedByString:@","];
        
        cell.imageDatas = [[NSMutableArray alloc] initWithArray:imageArray];
    }else{
        cell.imageDatas = [[NSMutableArray alloc] initWithArray:@[]];;
    }
    
    
    [cell.imageCollectionView reloadData];
    
    CGFloat width = SCREEN_WIDTH - 64 - 20;
    // 没图片就高度为0 （约束是可以拖出来的哦哦）
    if ([NSArray isEmpty:cell.imageDatas])
    {
        cell.colletionViewHeight.constant = 0;
    }
    else
    {
        cell.colletionViewHeight.constant = ((cell.imageDatas.count - 1) / 3 + 1) * (width / 3) + (cell.imageDatas.count - 1) / 3 * 15;
    }
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return (Main_Screen_Width/750)*452;
    }else if (indexPath.section ==1){
        UserInfo* info = [UserInfo sharedUserInfo];
        
        NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
        NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
        NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        if ([info.firstSelectIndex intValue] == 1) {
            return 155.0*(Main_Screen_Width/320);
        }else if ([info.firstSelectIndex intValue] == 2){
            return 155.0*(Main_Screen_Width/320);
        }else{
            NSString* keyString = [NSString stringWithFormat:@"org_%d",[info.secondSelectIndex intValue]+1];
            NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
            if (array.count>5) {
               return 155.0*(Main_Screen_Width/320);
            }else{
                return 155.0*(Main_Screen_Width/320)/2;
            }
        }
        
    }else if (indexPath.section == 2){
        return 170;
    }else if (indexPath.section ==3){
        if (indexPath.row==0) {
            return 44;
        }else{
            return  [tableView fd_heightForCellWithIdentifier:@"OrgCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                [self configCell:cell indexpath:indexPath];
            }];
        }
    }else if (indexPath.section ==4){
        if (indexPath.row ==0) {
            return 44;
        }else{
            return 153+(Main_Screen_Width)/2;
        }
    }else if (indexPath.section == 5){
        if (indexPath.row==0) {
            return 44;
        }else{
            return [tableView fd_heightForCellWithIdentifier:@"CommunityOneLineImageCell" cacheByIndexPath:indexPath configuration:^(CommunityOneLineImageCell *cell) {
                
                [self configCommunityCell:cell IndexPath:indexPath];
                
            }];
        }
        
    }else if (indexPath.section ==6){
        return 290*(Main_Screen_Width/320);
    }else {
        if (indexPath.row ==0) {
            return 90;
        }else{
            if (selectLocalIndex == 1) {
                return  [tableView fd_heightForCellWithIdentifier:@"LocalSelectOrgCell" cacheByIndexPath:indexPath configuration:^(id cell) {
                    [self configOrgCell:cell indexpath:indexPath];
                }];
            }
            return 100;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==3) {
        if (orgListArray.size) {
            return 8;
        }else{
            return 0.01;
        }
    }else{
        return 8;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==3) {
        if (indexPath.row ==0) {
            [self performSegueWithIdentifier:@"MainTo30DayOrg" sender:self];
        }else{
            current30DayIndex = indexPath.row;
            [self performSegueWithIdentifier:@"MainTo30DayOrgDetail" sender:self];
        }
    }else if (indexPath.section==4 && indexPath.row ==0){
        [self performSegueWithIdentifier:@"MainToGroupCourse" sender:self];
    }else if (indexPath.section==5 ){
        if (indexPath.row ==0) {
            self.tabBarController.selectedIndex = 3;
        }else{
            
            
            UserInfo* info = [UserInfo sharedUserInfo];
            if (info.userID.length) {
                selectCommunityIndex = indexPath.row-1;
                [self performSegueWithIdentifier:@"MainToCommunityDetail" sender:self];
            }else{
                UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
                [self presentViewController:login animated:YES completion:^{
                    
                }];
            }
 
        }
    }else if (indexPath.section == 7 && indexPath.row !=0){
        if (selectLocalIndex == 0) {
            currentSelectTeacherIndex   = indexPath.row;
            if (teacherResult) {
                [self performSegueWithIdentifier:@"MainToOrgDetail" sender:self];
            }
        }else if (selectLocalIndex == 1){
            currentSelectOrgIndex = indexPath.row;
            if (localOrgResult) {
                [self performSegueWithIdentifier:@"MainToOrgDetail" sender:self];
            }
        }else if (selectLocalIndex == 3){
            currentSelectSchoolIndex = indexPath.row;
            if (localInterSchoolResult) {
                [self performSegueWithIdentifier:@"MainToSchoolDetail" sender:self];
            }
        }else{
            currentSelectChinaSchoolIndex = indexPath.row;
            if (localChinaSchoolResult) {
                [self performSegueWithIdentifier:@"MainToChinaSchoolDetail" sender:self];
            }
        }

    }
}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    [_searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"MainSearch" sender:self];
}

#pragma mark - MainCycleDelegate

-(void)clickImageWithIndex:(DataItem*)item{
    if ([item getInt:@"AdvAttribute"]==1) {
        if ([[item getString:@"AdvUrl"] isEqualToString:@"1"]) {
            [self performSegueWithIdentifier:@"MainTo30DayOrg" sender:self];
        }else if ([[item getString:@"AdvUrl"] isEqualToString:@"2"]){
            currentServiceIndex = 0;
            [self performSegueWithIdentifier:@"MainToEducationPlan" sender:self];
        }else if ([[item getString:@"AdvUrl"] isEqualToString:@"3"]){
            [self performSegueWithIdentifier:@"MainToGroupCourse" sender:self];
        }else{
            currentServiceIndex = 2;
            [self performSegueWithIdentifier:@"MainToEducationPlan" sender:self];
        }
    }else if([item getInt:@"AdvAttribute"]==2){
        NSString *url=[item getString:@"AdvUrl"];
        NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encodedUrl]];

    }
    
    
}

#pragma mark - HomeGroupCourseDelegate

-(void)groupCourseSelect:(NSInteger)index{
    currentGroupCourseIndex = index;
    [self performSegueWithIdentifier:@"MainToGroupCourseDetail" sender:self];
}

#pragma mark - MainTypeDelegate
-(void)selectMainTypeDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    NSString* imageName= [button.imageView.image accessibilityIdentifier];
    
    UserInfo* info = [UserInfo sharedUserInfo];
    if ([info.firstSelectIndex intValue] == 1) {
        if ([imageName isEqualToString:@"全部.png"]) {
            [self performSegueWithIdentifier:@"MainToMoreType" sender:self];
        }else{
            NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
            NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
            NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            
            NSString* keyString = @"org_9";
            NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];

            
            chinaSchoolType = [array[button.tag-120] objectForKey:@"CourseType"];
            
           [self performSegueWithIdentifier:@"MainToChinaSchoolList" sender:self];
        }
        
    }else if ([info.firstSelectIndex intValue] == 2){
        if ([imageName isEqualToString:@"全部.png"]) {
            [self performSegueWithIdentifier:@"MainToMoreType" sender:self];
        }else{
            NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
            NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
            NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            
            NSString* keyString = @"org_10";
            NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
            
            
            schoolType = [array[button.tag-120] objectForKey:@"CourseType"];
            

          [self performSegueWithIdentifier:@"MainToSchoolList" sender:self];
        }
    }else{
        if ([imageName isEqualToString:@"全部.png"]) {
            [self performSegueWithIdentifier:@"MainToMoreType" sender:self];
        }else{
            NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
            NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
            NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            
            NSString* keyString = [NSString stringWithFormat:@"org_%d",[info.secondSelectIndex intValue]+1];
            NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
            orgType =[array[button.tag-120] objectForKey:@"CourseType"];
            orgKind =[array[button.tag-120] objectForKey:@"CourseKind"];
            [self performSegueWithIdentifier:@"MainToOrgList" sender:self];
        }
        
    }
}

#pragma mark - VideoCourseCellDelegate
-(void)selectVideoDelegate:(id)sender{
//    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    UIButton* button = (UIButton*)sender;
    
    selectVideoIndex = button.tag;
    [self performSegueWithIdentifier:@"MainToVideoPlayer" sender:self];
}

#pragma mark - LocalSelectDelegate
-(void)localSelectChangeDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    selectLocalIndex = button.tag;
    if (selectLocalIndex ==0) {
        self.tableView.tableFooterView  = nil;
        [self getTeaherListRequest];
    }else if (selectLocalIndex ==1){
        UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton setTitle:@"查看更多" forState:0];
        [moreButton setFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
        [moreButton setTitleColor:[UIColor lightGrayColor] forState:0];
        moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [moreButton addTarget:self action:@selector(goToMoreOrg) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableFooterView  = moreButton;
         [self getCourseList];
       
    }else if (selectLocalIndex == 3){
        UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton setTitle:@"查看更多" forState:0];
        [moreButton setFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
        [moreButton setTitleColor:[UIColor lightGrayColor] forState:0];
        moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [moreButton addTarget:self action:@selector(goToMoreSchool) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableFooterView  = moreButton;
        [self getSchoolListRequest];

    }else{
        UIButton* moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton setTitle:@"查看更多" forState:0];
        [moreButton setFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
        [moreButton setTitleColor:[UIColor lightGrayColor] forState:0];
        moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [moreButton addTarget:self action:@selector(goToMoreChinaSchool) forControlEvents:UIControlEventTouchUpInside];
        self.tableView.tableFooterView  = moreButton;
        
        [self getChinaSchoolListRequest];
        
    }
}

#pragma mark - NetWorkRequest

-(void)getMainData{
    [[MainService sharedMainService] mainGetAdvertisementWithParameters:nil onCompletion:^(id json) {
        advertisementResult = json;
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)loginRequest{
    if ([UserInfo sharedUserInfo].telphone.length) {
        [[MainService sharedMainService] loginWithParameters:@{@"loginName":[UserInfo sharedUserInfo].telphone,@"password":[UserInfo sharedUserInfo].password} onCompletion:^(id json) {
            [self getUserBasicInfoRequest];
            [self getUserOnlyRequest];
        } onFailure:^(id json) {
            
        }];
    }
}

-(void)getUserBasicInfoRequest{
    [[MyService sharedMyService] getUserBasicInfoWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
               
        [self tokenRequest];
    
    } onFailure:^(id json) {
        
    }];
}

-(void)getUserOnlyRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[MyService sharedMyService] getUserOnlyWithParameters:@{@"userId":info.userID} onCompletion:^(id json) {
                
    } onFailure:^(id json) {
        
    }];
}


-(void)tokenRequest{
    [[MyService sharedMyService] getTokenWithParameters:@{@"appKey":RONGCLOUDDISKEY,@"appSecret":RONGCLOUDDISSECRET,@"userId":[UserInfo sharedUserInfo].userID,@"name":[UserInfo sharedUserInfo].telphone} onCompletion:^(id json) {
        [self uptdateTokenRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)uptdateTokenRequest{
    [[MyService sharedMyService] updateUserTokenWithParameters:@{@"token":[UserInfo sharedUserInfo].token} onCompletion:^(id json) {
        [self rongcloudConnect];
    } onFailure:^(id json) {
        
    }];
}

-(void)getCourseVideoListRequest{
    [[MainService sharedMainService] getVideoCourseListWithParameters:@{@"top":@(4)} onCompletion:^(id json) {
        
        videoCourseResult = json;
        NSIndexPath *imageIndexPath = [NSIndexPath indexPathForRow:0 inSection:6];

        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:imageIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)getTeaherListRequest{
    [[MainService sharedMainService] getTeacherListWithParameters:@{@"CourseType":@"",@"CourseKind":@"",@"City":@"",@"Field":@"",@"TeachingAge":@"",@"IsOversea":@"",@"TeacherSex":@""} onCompletion:^(id json) {
        teacherResult = json;
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:7] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)getCourseList{
    
    NSDictionary* parameters = @{@"Org_Application_Id":@"",@"CourseName":@"",@"CourseType":@"",@"CourseKind":@"",@"City":@"",@"Field":@"",@"CourseClassCharacteristic":@"",@"CourseClassType":@"",@"OrderType":@(0)};
    
    [[OrginizationService sharedOrginizationService] postGetOrginfoWithPage:1 Size:10 Parameters:parameters onCompletion:^(id json) {
        localOrgResult = json;
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:7] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)getSchoolListRequest{

    [[SchoolService sharedSchoolService] getSchoolListWithPage:1 Size:10 Parameters:@{@"ChineseName":@"",@"Country":@"",@"Province":@"",@"City":@"",@"CollegeNature":@"",@"CollegeType":@"",@"TestScore":@"",@"TuitionBudget":@"",@"MinimumAverage":@""} onCompletion:^(id json) {
        
        localInterSchoolResult = json;
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:7] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)getChinaSchoolListRequest{
    [[SchoolService sharedSchoolService] postChinaSchoolListWithPage:1 Size:10 Parameters:@{@"SchoolName":@"",@"Province":@"",@"City":@"",@"CollegeNature":@"",@"CollegeType":@"",@"Area":@"",@"X":@(0),@"Y":@(0)} onCompletion:^(id json) {
        localChinaSchoolResult = json;
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:7] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)getThirtyBackCourseList{
    NSDictionary* parameters = @{@"Org_Application_Id":@"",@"CourseName":@"",@"CourseType":@"",@"CourseKind":@"",@"City":@"",@"Field":@"",@"CourseClassCharacteristic":@"",@"CourseClassType":@"",@"OrderType":@(0),@"Is30Day":@(1)};
    
    [[OrginizationService sharedOrginizationService] postGetOrginfoWithPage:1 Size:2 Parameters:parameters onCompletion:^(id json) {
        
        
        DataResult* result = json;
        
        [orgListArray append:[result.detailinfo getDataItemArray:@"orglist"]];

        if (orgListArray.size) {
            [self.tableView beginUpdates];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            [indexPaths addObject:indexPath];
            for (int i =0; i< orgListArray.size; i++) {
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1+i inSection:3];
                [indexPaths addObject:indexPath1];
            }
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            
            for ( int i=0 ; i< orgListArray.size ; i++) {
                [self getCourseClassTypeWithindex:i];
            }
        }else{
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];

        }
        
    } onFailure:^(id json) {
        
    }];
}

- (void)getCourseClassTypeWithindex:(NSInteger)index {
    DataItem* item = [orgListArray getItem:index];
    
    [[OrginizationService sharedOrginizationService] getCourseClassTypeWithParameters:@{@"orgId":[item getString:@"Organization_Application_ID"]} onCompletion:^(id json) {
        DataResult* result = json;
        [tagDic setObject:result.items forKey:[NSString stringWithFormat:@"%ld",(long)index]];
        
        if ([tagDic allKeys].count == orgListArray.size) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    } onFailure:^(id json) {
        
    }];
}

-(void)getGroupCourseListRequest{
    NSString* courseType ;
    UserInfo* info = [UserInfo sharedUserInfo];
    if ([info.firstSelectIndex intValue]==0) {
        NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
        NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
        NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        
        NSString* keyString = [NSString stringWithFormat:@"org_%d",[info.secondSelectIndex intValue]+1];
        NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
        courseType =[array[0] objectForKey:@"CourseType"];
        
        if ([UserInfo sharedUserInfo].userID.length) {
            [[GroupCourseService sharedGroupCourseService] groupCourseListWithPage:1 Size:2 Parameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"courseType":courseType} onCompletion:^(id json) {
                DataResult* result = json;
                [groupCourseArray append:[result.detailinfo getDataItemArray:@"list"]];
                
                if (groupCourseArray.size) {
                    [self.tableView beginUpdates];

                    NSMutableArray *indexPaths = [NSMutableArray array];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
                    [indexPaths addObject:indexPath];
                    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:4];
                    [indexPaths addObject:indexPath1];
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                }else{
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
                }
                
            } onFailure:^(id json) {
                
            }];
        }else{
            [[GroupCourseService sharedGroupCourseService] groupCourseListWithPage:1 Size:2 Parameters:@{@"courseType":courseType} onCompletion:^(id json) {
                DataResult* result = json;
                [groupCourseArray append:[result.detailinfo getDataItemArray:@"list"]];
                
                if (groupCourseArray.size) {
                    [self.tableView beginUpdates];
                    
                    NSMutableArray *indexPaths = [NSMutableArray array];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
                    [indexPaths addObject:indexPath];
                    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:4];
                    [indexPaths addObject:indexPath1];
                    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                }else{
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
                }
            } onFailure:^(id json) {
                
            }];
        }
    }else{
        [groupCourseArray clear];
        
        [self.tableView beginUpdates];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
        [indexPaths addObject:indexPath];
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:4];
        [indexPaths addObject:indexPath1];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
    }
}

-(void)getComunityListRequest{
    NSDictionary* parameter;
    if ([UserInfo sharedUserInfo].userID.length) {
        parameter = @{@"communityTypeId":@"",@"isEssence":@(1),@"userId":[UserInfo sharedUserInfo].userID};
    }else{
        parameter =@{@"communityTypeId":@"",@"isEssence":@(1)};
    }
   
    [[CommunityService sharedCommunityService] getCommunityListWithPage:1 Size:2 Parameters:parameter onCompletion:^(id json) {
        DataResult* result = json;
        
        [communityListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        if (communityListArray.size){
            [self.tableView beginUpdates];
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5];
            [indexPaths addObject:indexPath];
            
            for (int i =0; i< communityListArray.size; i++) {
                NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:i+1 inSection:5];
                [indexPaths addObject:indexPath1];
            }
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            
        }else{
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    } onFailure:^(id json) {
        
    }];

    
}


#pragma mark - TableViewFooter
-(void)goToMoreOrg{
    orgType = @"";
    orgKind = @"";
    [self performSegueWithIdentifier:@"MainToOrgList" sender:self];
}

-(void)goToMoreSchool{
    schoolType = @"";
    [self performSegueWithIdentifier:@"MainToSchoolList" sender:self];
}

-(void)goToMoreChinaSchool{
    chinaSchoolType = @"";
    [self performSegueWithIdentifier:@"MainToChinaSchoolList" sender:self];
}

#pragma mark - ServiceDelegate
-(void)pushToServicePage:(id)sender{
    UIButton* currentButton = (UIButton*)sender;
    currentServiceIndex = currentButton.tag;
    [self performSegueWithIdentifier:@"MainToEducationPlan" sender:self];
}

#pragma mark - PreferredDelegate
-(void)preferredTap:(id)sender{
    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    currentOrgIndex = tap.view.tag;
    [self performSegueWithIdentifier:@"MainToOrgDetail" sender:self];
}

#pragma AmapLocation
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
}

- (void)startSerialLocation
{
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)stopSerialLocation
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //定位结果
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
   
    
    UserInfo* info = [UserInfo sharedUserInfo];
    info.userLongitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    info.userLatitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    
    [info synchronize];
    
    [self stopSerialLocation];
}

#pragma mark RongCloudConnect
-(void)rongcloudConnect{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[RCIM sharedRCIM] connectWithToken:info.token  success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

-(void)goToWeb{
    [self performSegueWithIdentifier:@"MainToGuide" sender:self];
}



@end
