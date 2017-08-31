//
//  CommunityUserViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityUserViewController.h"
#import "CommunityUserBanner.h"
#import "MyCommunityTableViewCell.h"
#import "MyReplyCOmmunityTableViewCell.h"
#import "HMSegmentedControl.h"
#import "CommunityService.h"
#import "CustomAlertTableView.h"

static NSString *communityIdentify = @"MyCommunityTableViewCell";
static NSString *replyIdentifier = @"MyReplyCOmmunityTableViewCell";

@interface CommunityUserViewController ()<UITableViewDelegate,UITableViewDataSource,CommunityUserBannerDelegate,RowSelectDelegate>
{
    NSInteger currentSegIndex;
    DataResult* praiseResult;
    DataResult* collectResult;
    
    NSInteger selectIndex;
    
    NSInteger communityCurrentIndex;
    NSInteger communityTotalCount;
    DataItemArray* userCommunityListArray;
    
    NSInteger replyCurrentIndex;
    NSInteger replyTotalCount;
    DataItemArray* replyListArray;
    
    CustomAlertTableView* ct;
    NSString* userIdentity;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation CommunityUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [self.tableView registerNib:[UINib nibWithNibName:communityIdentify bundle:nil] forCellReuseIdentifier:communityIdentify];
    [self.tableView registerNib:[UINib nibWithNibName:replyIdentifier bundle:nil]  forCellReuseIdentifier:replyIdentifier];
    
    userCommunityListArray = [DataItemArray new];
    replyListArray = [DataItemArray new];
    
    [self getPraiseNumberRequest];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        
        if (currentSegIndex == 0) {
            communityCurrentIndex = 1;
            [userCommunityListArray clear];
            [self getCommunityByUserIdRequest];
        }else{
            replyCurrentIndex = 1;
            [replyListArray clear];
            [self getReplyrequest];
        }
        
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        if (currentSegIndex == 0) {
            communityCurrentIndex ++;
            [self getCommunityByUserIdRequest];
        }else{
            replyCurrentIndex ++;
            [self getReplyrequest];
        }
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CommunityUserToDetail"])
    {
        id theSegue = segue.destinationViewController;
        
        if (currentSegIndex == 0) {
            DataItem* item =[userCommunityListArray getItem:selectIndex];
            
            [theSegue setValue:[item getString:@"Id"] forKey:@"communityId"];
        }else{
            DataItem* item =[replyListArray getItem:selectIndex];
            
            [theSegue setValue:[item getString:@"NoteId"] forKey:@"communityId"];
        }
        
    }
}

#pragma mark - UITableViewdatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else{
        if (currentSegIndex==0) {
            return userCommunityListArray.size;
        }else{
            return replyListArray.size;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       return Main_Screen_Width/750*400+45;
    }else{
        if (currentSegIndex==0) {
            return [tableView fd_heightForCellWithIdentifier:communityIdentify cacheByIndexPath:indexPath configuration:^(MyCommunityTableViewCell *cell) {
                
                [self configCell:cell IndexPath:indexPath];
                
            }];
        }else{
            return [tableView fd_heightForCellWithIdentifier:replyIdentifier cacheByIndexPath:indexPath configuration:^(MyReplyCOmmunityTableViewCell *cell) {
                
                [self configReplyCell:cell IndexPath:indexPath];
                
            }];
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        return 45;
    }else{
        return 0.01;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"主贴", @"回复"]];
        segmentedControl.frame = CGRectMake(0 , 0, Main_Screen_Width, 40);
        [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        
        segmentedControl.selectionIndicatorColor = MAINCOLOR;
        segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        
        [segmentedControl setSelectedSegmentIndex:currentSegIndex];
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 45)];
        headerView.backgroundColor = TEXTFIELD_BG_COLOR;
        
        [headerView addSubview:segmentedControl];
        return headerView;
    }else{
        return nil;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        CommunityUserBanner* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityUserBanner" owner:self options:nil].firstObject;
        if (praiseResult.message.length) {
            cell.praiseNumber.text =  praiseResult.message ;
        }else{
            cell.praiseNumber.text =  @"0";
        }
        cell.delegate = self;
        cell.collectNumber.text = [NSString stringWithFormat:@"%d",[collectResult.detailinfo getInt:@"TotalCount"]];
        
        return cell;
    }else{
        if (currentSegIndex ==0) {
            MyCommunityTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyCommunityTableViewCell" owner:self options:nil].firstObject;
            [self configCell:cell IndexPath:indexPath];
            return cell;
        }else{
            MyReplyCOmmunityTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyReplyCOmmunityTableViewCell" owner:self options:nil].firstObject;
            [self configReplyCell:cell IndexPath:indexPath];
            return cell;
        }
    }
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        selectIndex = indexPath.row;
        [self performSegueWithIdentifier:@"CommunityUserToDetail" sender:self];
    }
}

-(void)configCell:(MyCommunityTableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    DataItem* item = [userCommunityListArray getItem:indexPath.row];
    [cell bingdingViewModel:item];
}

-(void)configReplyCell:(MyReplyCOmmunityTableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{
    DataItem* item = [replyListArray getItem:indexPath.row];
    [cell bingdingViewModel:item];
}
#pragma mark - SegControlDelegate

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    if (currentSegIndex ==0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.tableView.mj_header beginRefreshing];
}

-(void)showUserIdentityDelegate{
    ct = [[CustomAlertTableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) rowCount:2 title:@"选择身份"];
    ct.delegate = self;
    
    [self.view addSubview:ct];
}

-(void)goToCollectDelegate{
    [self performSegueWithIdentifier:@"CommunityUserToCollect" sender:self];
}

-(void)selectRow:(NSInteger)rowIndex{
    if (rowIndex==0) {
        userIdentity = @"家长";
    }else{
        userIdentity = @"学生";
    }
    
    [ct dismiss];
    
    [self updateUserIdentityRequest];
}

#pragma mark - Networkrequest
-(void)getPraiseNumberRequest{
    [[CommunityService sharedCommunityService] getUserPraiseNumberWithParameters:nil onCompletion:^(id json) {
        praiseResult = json;
        [self getCommunityCollectRequest];
    } onFailure:^(id json) {
       
    }];
}

-(void)getCommunityCollectRequest{
    [[CommunityService sharedCommunityService] getUserCollectListWithPage:1 Size:10 Parameters:nil onCompletion:^(id json) {
        collectResult = json;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}

-(void)getCommunityByUserIdRequest{
    [[CommunityService sharedCommunityService] getCommunityByUserWithPage:communityCurrentIndex Size:10 Parameters:nil onCompletion:^(id json) {
        DataResult* result = json;
        [userCommunityListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        communityTotalCount = [result.detailinfo getInt:@"TotalCount"];
        
        [self.tableView.mj_header endRefreshing];
        
        
        if (communityCurrentIndex*10 < communityTotalCount) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];

    } onFailure:^(id json) {
        
    }];
}

-(void)getReplyrequest{
    [[CommunityService sharedCommunityService] getReplyByUserWithPage:replyCurrentIndex Size:10 Parameters:nil onCompletion:^(id json) {
        DataResult* result = json;
        [replyListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        replyTotalCount = [result.detailinfo getInt:@"TotalCount"];
        
        [self.tableView.mj_header endRefreshing];
        
        
        if (replyCurrentIndex*10 < replyTotalCount) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
    } onFailure:^(id json) {
        
    }];
}

-(void)updateUserIdentityRequest{
    [[CommunityService sharedCommunityService] updateUserIdentityWithParameters:@{@"identityName":userIdentity} onCompletion:^(id json) {
        
        UserInfo* info = [UserInfo sharedUserInfo];
        info.userIdentity =userIdentity;
        [info synchronize];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    } onFailure:^(id json) {
        
    }];
}
@end
