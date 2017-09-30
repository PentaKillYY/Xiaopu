//
//  GroupCourseDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseDetailViewController.h"
#import "GroupCourseDetailBannerCell.h"
#import "GroupCourseDetailPriceCell.h"
#import "GroupCourseDetailInfoCell.h"
#import "GroupCourseDetailExplainCell.h"
#import "HomeGroupCourseTableViewCell.h"
#import "GroupCourseDetailLikeTitleCell.h"

#import "GroupCourseService.h"
@interface GroupCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,GroupCourseDetailInfoDelegate,HomeGroupCourseDelegate,GroupCourseDetailPriceDelegate>{
    DataItemArray* groupCourseArray;
    NSInteger currentPage;
    NSString* courseType;
    DataResult* detailResult;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet UIButton* backButton;
@end

@implementation GroupCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.backButton.layer setCornerRadius:16];
    [self.backButton.layer setMasksToBounds:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupCourseDetailBannerCell" bundle:nil] forCellReuseIdentifier:@"GroupCourseDetailBannerCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupCourseDetailExplainCell" bundle:nil] forCellReuseIdentifier:@"GroupCourseDetailExplainCell"];
    
    groupCourseArray = [DataItemArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self getGroupCourseListRequest];
    [self gerGroupCourseDetailRequest];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GroupCoueseDetailToInfo"])
    {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"FightCourseIntroduction"] forKey:@"courseContent"];
    }else if([segue.identifier isEqualToString:@"GroupCourseDetailToOrgDetail"])     {
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"Organization_Application_ID"] forKey:@"orgID"];
    }else if ([segue.identifier isEqualToString:@"GroupCourseDetailToShare"]){
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"FightCourseId"] forKey:@"courseId"];
    }else if ([segue.identifier isEqualToString:@"GroupCourseDetailToPay"]){
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"FightCourseId"] forKey:@"courseId"];
    }else if ([segue.identifier isEqualToString:@"GroupCourseDetailToAdward"]){
        id theSegue = segue.destinationViewController;
        
        [theSegue setValue:[detailResult.detailinfo getString:@"FightCourseId"] forKey:@"courseId"];
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==4) {
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return [tableView fd_heightForCellWithIdentifier:@"GroupCourseDetailBannerCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            [self configCell:cell indexpath:indexPath];
        }];
    }else if (indexPath.section==1){
        return 130;
    }else if (indexPath.section==2){
        return 400;
    }else if (indexPath.section==3){
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        GroupCourseDetailBannerCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailBannerCell" owner:self options:nil].firstObject;
        [self configCell:cell indexpath:indexPath];
        return cell;
    }else if (indexPath.section==1){
        GroupCourseDetailPriceCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailPriceCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        [cell bingdingViewModel:detailResult.detailinfo];
        return cell;
    }else if (indexPath.section==2){
        GroupCourseDetailInfoCell* cell = [[NSBundle mainBundle] loadNibNamed:@"GroupCourseDetailInfoCell" owner:self options:nil].firstObject;
        [self configInfoCell:cell indexpath:indexPath];
        cell.delegate = self;
        return cell;
    }else if (indexPath.section==3){
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


-(void)configCell:(GroupCourseDetailBannerCell*)cell indexpath:(NSIndexPath*)indexPath{
    [cell bingdingViewModel:detailResult.detailinfo];
}

-(void)configInfoCell:(GroupCourseDetailInfoCell*)cell indexpath:(NSIndexPath*)indexpath{
    [cell bingdingViewModel:detailResult.detailinfo];
}

-(void)configExplainCell:(GroupCourseDetailExplainCell*)cell IndexPath:(NSIndexPath*)indexPath{
    [cell bingdingViewModel:detailResult.detailinfo];
}

#pragma mark - GroupCourseDetailInfoDelegate
-(void)groupCourseMoreInfoDelegate:(id)sender{
    [self performSegueWithIdentifier:@"GroupCoueseDetailToInfo" sender:self];
}

#pragma mark - HomeGroupCourseDelegate

-(void)groupCourseSelect:(NSInteger)index{
    DataItem* item = [groupCourseArray getItem:index];

    self.courseId = [item getString:@"FightCourseId"];
    [self gerGroupCourseDetailRequest];
}

#pragma mark - GroupCourseDetailPriceDelegate
-(void)goToCourseHandle:(BOOL)isOrigin{
    if ([UserInfo sharedUserInfo].userID) {
        if (isOrigin) {
            [self performSegueWithIdentifier:@"GroupCourseDetailToOrgDetail" sender:self];
        }else{
            if ([detailResult.detailinfo getInt:@"FightCourseState"]==0) {
                [[AppCustomHud sharedEKZCustomHud] showTextHud:GroupCourseNotStart];
            }else if ([detailResult.detailinfo getInt:@"FightCourseState"]==1){
                if ([detailResult.detailinfo getInt:@"UserState"]==0) {
                    [self performSegueWithIdentifier:@"GroupCourseDetailToPay" sender:self];
                    
                }else{
                    [self performSegueWithIdentifier:@"GroupCourseDetailToShare" sender:self];
                }
                
            }else if ([detailResult.detailinfo getInt:@"FightCourseState"]==2){
                [[AppCustomHud sharedEKZCustomHud]showTextHud:GroupCourseWaitingAdward];
            }else if ([detailResult.detailinfo getInt:@"FightCourseState"]){
                [self performSegueWithIdentifier:@"GroupCourseDetailToAdward" sender:self];
            }

        }
    }else{
        [self needLogin];
    }
    
}

#pragma mark - NetWorkrequest

-(void)getGroupCourseListRequest{
    [groupCourseArray clear];
    UserInfo* info = [UserInfo sharedUserInfo];
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    NSString* keyString = [NSString stringWithFormat:@"org_%d",[info.secondSelectIndex intValue]+1];
    NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
    courseType =[array[0] objectForKey:@"CourseType"];

    if ([UserInfo sharedUserInfo].userID.length) {
        [[GroupCourseService sharedGroupCourseService] groupCourseListWithPage:1 Size:10 Parameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"courseType":courseType} onCompletion:^(id json) {
            DataResult* result = json;
            [groupCourseArray append:[result.detailinfo getDataItemArray:@"list"]];
            
            [self.tableView reloadData];
            
        } onFailure:^(id json) {
            
        }];
    }else{
        [[GroupCourseService sharedGroupCourseService] groupCourseListWithPage:1 Size:10 Parameters:@{@"courseType":courseType} onCompletion:^(id json) {
            DataResult* result = json;
            [groupCourseArray append:[result.detailinfo getDataItemArray:@"list"]];
            
            [self.tableView reloadData];
            
        } onFailure:^(id json) {
            
        }];
    }
}

-(void)gerGroupCourseDetailRequest{
    if ([UserInfo sharedUserInfo].userID.length) {
        [[GroupCourseService sharedGroupCourseService] getGroupCourseDetailWithParameters:@{@"fightCourseId":self.courseId,@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
            
            detailResult = json;
            [self.tableView reloadData];
            
        } onFailure:^(id json) {
            
        }];
    }else{
        [[GroupCourseService sharedGroupCourseService] getGroupCourseDetailWithParameters:@{@"fightCourseId":self.courseId} onCompletion:^(id json) {
            
            detailResult = json;
            [self.tableView reloadData];
            
        } onFailure:^(id json) {
            
        }];
    }
    
}

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)needLogin{
    UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
    [self presentViewController:login animated:YES completion:^{
        
    }];
}
@end
