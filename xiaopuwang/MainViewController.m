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
#import "UIButton+JKImagePosition.h"
#import "UIButton+JKMiddleAligning.h"
#import "MainService.h"
#import "MyService.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ServiceDelegate,AMapLocationManagerDelegate,PreferredTapDelegate>
{
    DataResult* advertisementResult;
    NSInteger currentOrgIndex;
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
    
    [self changeNavTitleView];
    [self loginRequest];
    
    [self getMainData];
 
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
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [_leftButton setTitle:@"无锡" forState:0];
    [_leftButton setImage:V_IMAGE(@"map") forState:0];
    [_leftButton jk_setImagePosition:2 spacing:0];
    
    NSString *content = _leftButton.titleLabel.text;
    UIFont *font = _leftButton.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, 44.0f);
    CGSize buttonSize = [content boundingRectWithSize:size
                                              options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{ NSFontAttributeName:font}
                                              context:nil].size;
    if (buttonSize.width < 44 ) {
        [_leftButton setFrame:CGRectMake(0, 0, 44, 44)];
    }else if (buttonSize.width  > 50 ){
        [_leftButton setFrame:CGRectMake(0, 0, 50, 44)];
    }else{
        [_leftButton setFrame:CGRectMake(0, 0, buttonSize.width, 44)];
    }

    [_leftButton setContentEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
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
    if([segue.identifier isEqualToString:@"MainToOrgDetail"])
    {
        id theSegue = segue.destinationViewController;
        
        NSMutableArray* array = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < advertisementResult.items.size; i++) {
            DataItem* item = [advertisementResult.items getItem:i];
            
            if ([item getInt:@"AdvType"] == 2) {
                [array addObject:item];
            }
        }
        DataItem* item = array[currentOrgIndex];
        [theSegue setValue:[item getString:@"UserId"] forKey:@"orgID"];
        
    }else if ([segue.identifier isEqualToString:@"MainToActivity"]){
        id theSegue = segue.destinationViewController;
        
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (int i = 0; i < advertisementResult.items.size; i++) {
            DataItem* item = [advertisementResult.items getItem:i];
            
            if ([item getInt:@"AdvType"] == 3) {
                [array addObject:item];
            }
        }
        [theSegue setValue:array forKey:@"activityArray"];
 
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MainCycleTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainCycleTableViewCell" owner:self options:nil].firstObject;
        cell.dataresult = advertisementResult;
        return cell;
    }else if (indexPath.section == 1){
        MainRollingTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainRollingTableViewCell" owner:self options:nil].firstObject;
        return cell;
    }else if (indexPath.section == 2){
        MainServiceTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainServiceTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 5){
        MainPreferedTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainPreferedTableViewCell" owner:self options:nil].firstObject;
        cell.atitleView.image = V_IMAGE(@"校谱优选");
        cell.dataResult = advertisementResult;
        cell.delegate = self;
        return cell;
    }else{
        MainActivityTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MainActivityTableViewCell" owner:self options:nil].firstObject;
        if (indexPath.section == 3) {
            cell.atitleImage.image = V_IMAGE(@"大额");
            cell.acontentImage.image = V_IMAGE(@"大额补贴");
        }else{
            cell.atitleImage.image = V_IMAGE(@"活动");
            cell.acontentImage.image = V_IMAGE(@"活动专区");
        }

        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return (Main_Screen_Width/750)*452;
    }else if (indexPath.section == 1){
        return 44;
    }else if (indexPath.section == 2){
        return ((Main_Screen_Width-20)/2 *216)/342 +10;
    }else if (indexPath.section == 5){
        return (Main_Screen_Width-14)/3+30+(Main_Screen_Width/320)*10;
    }else {
        if (indexPath.section == 3) {
           return ((Main_Screen_Width-16)/1473)*540+30+ (Main_Screen_Width/320)*10;
        }else{
            return ((Main_Screen_Width-16)/1920)*648+30+ (Main_Screen_Width/320)*10;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 ) {
        [self performSegueWithIdentifier:@"MainToSubTidy" sender:self];
    }else if (indexPath.section == 4){
        [self performSegueWithIdentifier:@"MainToActivity" sender:self];
    }
}

- (void)leftItemAction:(id)sender{
    
}

- (void)rightItemAction:(id)sender{

}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    [_searchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"MainSearch" sender:self];
}

#pragma mark - NetWorkRequest

-(void)getMainData{
    [[MainService sharedMainService] mainGetAdvertisementWithParameters:nil onCompletion:^(id json) {
        advertisementResult = json;
        
        [self.tableView reloadData];
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
    [[MyService sharedMyService] getTokenWithParameters:@{@"appKey":RONGCLOUDDISKEY,@"appSecret":RONGCLOUDDISSECRET,@"userId":[UserInfo sharedUserInfo].userID,@"name":[UserInfo sharedUserInfo].username,@"portraitUri":[UserInfo sharedUserInfo].headPicUrl} onCompletion:^(id json) {
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

#pragma mark - ServiceDelegate
-(void)pushToServicePage:(id)sender{
    UIButton* currentButton = (UIButton*)sender;
    
    if (currentButton.tag == 1) {
        [self performSegueWithIdentifier:@"MainToEducationPlan" sender:self];
    }else{
        [self performSegueWithIdentifier:@"MainToPersonalChoose" sender:self];
    }
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
        
//        RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:userId
//                                                         name:info.username
//                                                     portrait:info];
        
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
