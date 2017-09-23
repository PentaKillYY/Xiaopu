//
//  GroupCourseShareViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseShareViewController.h"
#import "GroupCourseDetailTableViewCell.h"
#import "GroupCourseShareTableViewCell.h"
#import "HomeGroupCourseTableViewCell.h"
#import "GroupCourseDetailLikeTitleCell.h"
#import "GroupCourseDetailExplainCell.h"
#import "GroupCourseService.h"

@interface GroupCourseShareViewController ()<UITableViewDelegate,UITableViewDataSource,HomeGroupCourseDelegate,GroupCourseShareDelegate>{
    DataItemArray* groupCourseArray;
    NSInteger currentPage;
    NSString* courseType;
    DataResult* detailResult;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation GroupCourseShareViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupCourseDetailExplainCell" bundle:nil] forCellReuseIdentifier:@"GroupCourseDetailExplainCell"];
    
    groupCourseArray = [DataItemArray new];
    
    [self getGroupCourseListRequest];
    [self gerGroupCourseDetailRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GroupCourseShareToOrgDetail"])     {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"Organization_Application_ID"] forKey:@"orgID"];
    }else if([segue.identifier isEqualToString:@"GroupCourseShareToDetail"])     {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"FightCourseId"] forKey:@"courseId"];
    }
}


#pragma mark - UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==3) {
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 108;
    }else if (indexPath.section==1){
        return 102;
    }else if (indexPath.section ==2){
        return [tableView fd_heightForCellWithIdentifier:@"GroupCourseDetailExplainCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configExplainCell:cell IndexPath:indexPath];
        }];

    }else{
        if (indexPath.row ==0) {
            return 44;
        }else{
            return 118+(Main_Screen_Width)/2;
        }
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        GroupCourseDetailTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailTableViewCell" owner:self options:nil].firstObject;
        [cell bingdingViewModel:detailResult.detailinfo];
        return cell;
    }else if(indexPath.section ==1){
        GroupCourseShareTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseShareTableViewCell" owner:self options:nil].firstObject;
        cell.delegate = self; 
        [cell bingdingViewModel:detailResult.detailinfo];
        return cell;
    }else if (indexPath.section==2){
        GroupCourseDetailExplainCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailExplainCell" owner:self options:nil].firstObject;
        [self configExplainCell:cell IndexPath:indexPath];
        
        return cell;
    }else{
        if (indexPath.row==0) {
            GroupCourseDetailLikeTitleCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailLikeTitleCell" owner:self options:nil].firstObject;
            return cell;
        }else{
            HomeGroupCourseTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"HomeGroupCourseTableViewCell" owner:self options:nil].firstObject;
            cell.delegate = self;
            [cell bingdingViewModel:groupCourseArray];
            return cell;
            
        }
    }
}

-(void)configExplainCell:(GroupCourseDetailExplainCell*)cell IndexPath:(NSIndexPath*)indexPath{
    [cell bingdingViewModel:detailResult.detailinfo];
}

#pragma mark - HomeGroupCourseDelegate

-(void)groupCourseSelect:(NSInteger)index{
    DataItem* item = [groupCourseArray getItem:index];
    
    self.courseId = [item getString:@"FightCourseId"];
    [self performSegueWithIdentifier:@"GroupCourseShareToDetail" sender:self];
}

#pragma mark - GroupCourseShareDelegate

-(void)contactOrgDelegate:(id)sender{
    [self performSegueWithIdentifier:@"GroupCourseDetailToOrgDetail" sender:self];
}

-(void)shareOrgDelegate:(id)sender{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareWebPageToPlatformType:platformType];
        
    }];
}

#pragma mark - NetWorkrequest

-(void)getGroupCourseListRequest{
    
    UserInfo* info = [UserInfo sharedUserInfo];
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    NSString* keyString = [NSString stringWithFormat:@"org_%d",[info.secondSelectIndex intValue]+1];
    NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
    courseType =[array[0] objectForKey:@"CourseType"];
    
    [[GroupCourseService sharedGroupCourseService] groupCourseListWithPage:1 Size:10 Parameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"courseType":courseType} onCompletion:^(id json) {
        DataResult* result = json;
        [groupCourseArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        [self.tableView reloadData];
        
    } onFailure:^(id json) {
        
    }];
    
}

-(void)gerGroupCourseDetailRequest{
    [[GroupCourseService sharedGroupCourseService] getGroupCourseDetailWithParameters:@{@"fightCourseId":self.courseId,@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        
        detailResult = json;
        [self.tableView reloadData];
        
    } onFailure:^(id json) {
        
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    UserInfo* info = [UserInfo sharedUserInfo];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:ShareDetailTitle descr:nil thumImage:[UIImage imageNamed:@"ShareLogo"]];
    
    shareObject.webpageUrl =[NSString stringWithFormat:@"http://www.admin.ings.org.cn/UserRegister/GetCoupon?userId=%@&couponId=",info.userID];
    
    
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


-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
