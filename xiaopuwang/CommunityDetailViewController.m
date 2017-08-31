//
//  CommunityDetailViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityDetailViewController.h"
#import "CommunityDetailCell.h"
#import "CommunityReplyCell.h"
#import "CommunityService.h"
static NSString *identify = @"CommunityDetailCell";
static NSString *replyidentify = @"CommunityReplyCell";
@interface CommunityDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CommunityDetailCellDelegate>
{
    DataResult* detailResult;
    
    NSInteger currentIndex;
    NSInteger totalCount;
    NSInteger currentSegIndex;
    NSInteger selectIndex;
    DataItemArray* communityReplyListArray;
    BOOL isCollect;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation CommunityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"帖子全文";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollect") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                          initWithImage:V_IMAGE(@"arrow-back-blue") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftItem rightBarButtonItem:rightItm];
    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    [self.navigationItem.leftBarButtonItem setTintColor:MAINCOLOR];
    
    [self.tableView registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    [self.tableView registerNib:[UINib nibWithNibName:replyidentify bundle:nil] forCellReuseIdentifier:replyidentify];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    detailResult = [DataResult new];
    
    communityReplyListArray = [DataItemArray new];
    currentIndex = 1;
    
    [self getCommunityDetaiRequest];
    [self getCommunityReplyListRequest];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex ++;
        [self getCommunityReplyListRequest];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self userBrowseCommunityRequest];
}
#pragma mark - UITableViedatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return communityReplyListArray.size;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(CommunityDetailCell *cell) {
            
            [self configCell:cell IndexPath:indexPath];
            
        }];
 
    }else{
        return [tableView fd_heightForCellWithIdentifier:replyidentify cacheByIndexPath:indexPath configuration:^(CommunityReplyCell *cell) {
            
            [self configReplyCell:cell IndexPath:indexPath];
            
        }];
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CommunityDetailCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityDetailCell" owner:self options:nil].firstObject;
        cell.delegate = self;
        [self configCell:cell IndexPath:indexPath];
        return cell;
    }else{
        CommunityReplyCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityReplyCell" owner:self options:nil].firstObject;
        [self configReplyCell:cell IndexPath:indexPath];
        return cell;
    }
    
}

-(void)configCell:(CommunityDetailCell*)cell IndexPath:(NSIndexPath*)path{
    
    if ([detailResult.detailinfo getString:@"Id"].length) {
        [cell bingdingViewModel:detailResult.detailinfo];
        
        if ([[detailResult.detailinfo getString:@"UserId"] isEqualToString:[UserInfo sharedUserInfo].userID]) {
            cell.deleteCommunityHeight.constant = 27;
            cell.deleteCommunityButton.hidden = NO;
        }else{
            cell.deleteCommunityButton.hidden = YES;
            cell.deleteCommunityHeight.constant = 0;
        }
        
        if ([detailResult.detailinfo getString:@"ImageUrl"].length) {
            // img  九宫格图片，用collectionView做
            NSArray* imageArray = [[detailResult.detailinfo getString:@"ImageUrl"] componentsSeparatedByString:@","];
            
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
    
}

-(void)configReplyCell:(CommunityReplyCell*)cell IndexPath:(NSIndexPath*)path{
    DataItem* item = [communityReplyListArray getItem:path.row];
    
    [cell bingdingViewModel:item];
}

-(void)collectCommunity{
    isCollect = !isCollect;
    if (isCollect) {
//        [self deleteCollectCommunityRequest];
    }else{
        [self collectCommunityRequest];
    }
}

#pragma mark - CommunityDetailCellDelegate
-(void)deleteCommunityDelegate:(id)sender{
    [self deleteCommunityRequest];
}

-(void)praiseCommunityDelegate:(id)sender{
    [self userGoodCommunityRequest];
}

#pragma mark - NetWorkRequest
-(void)getCommunityDetaiRequest{
    
    [[CommunityService sharedCommunityService] getCommunityDetailWithParameters:@{@"id":self.communityId,@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        DataResult* result = json;
        [detailResult append:result];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        
        if ([detailResult.detailinfo getInt:@"IsCollection"]) {
            isCollect = YES;
            UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollected") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
            [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
            [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];

        }else{
            isCollect = NO;
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
            UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollect") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
            [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
            [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
        }
    } onFailure:^(id json) {
        
    }];
}

-(void)getCommunityReplyListRequest{
    [[CommunityService sharedCommunityService] getCommunityReplyListWithPage:currentIndex Size:10 Parameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        DataResult* result = json;
        
        [communityReplyListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        totalCount = [result.detailinfo getInt:@"TotalCount"];
        
        if (currentIndex*10 < totalCount) {
            [self.tableView.mj_footer endRefreshing];
            
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];

    } onFailure:^(id json) {
        
    }];
}

-(void)collectCommunityRequest{
    [[CommunityService sharedCommunityService] collectCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollected") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
        [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
        [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    } onFailure:^(id json) {
        
    }];
}

-(void)deleteCollectCommunityRequest{
    [[CommunityService sharedCommunityService] deleteCollectCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
        UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityCollect") style:UIBarButtonItemStylePlain target:self action:@selector(collectCommunity)];
         [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:rightItm];
        [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];

    } onFailure:^(id json) {
        
    }];
}

-(void)deleteCommunityRequest{
    [[CommunityService sharedCommunityService] deleteCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(id json) {
        
    }];
}

-(void)userBrowseCommunityRequest{
    [[CommunityService sharedCommunityService] userBrowseCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        
    } onFailure:^(id json) {
        
    }];

}

-(void)userGoodCommunityRequest{
    [[CommunityService sharedCommunityService] userGoodCommunityWithParameters:@{@"noteId":self.communityId} onCompletion:^(id json) {
        [self getCommunityDetaiRequest];
    } onFailure:^(id json) {
        
    }];
}
@end
