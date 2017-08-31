//
//  CommunityCollectViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/29.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityCollectViewController.h"
#import "CommunityService.h"
#import "CommunityCollectTableViewCell.h"
static NSString* identifier = @"CommunityCollectTableViewCell";

@interface CommunityCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentIndex;
    NSInteger totalCount;
    DataItemArray* collectListArray;
    BOOL isEditing;
    NSInteger selectIndex;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation CommunityCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收藏";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTableView)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                 initWithImage:V_IMAGE(@"arrow-back-blue") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftItem rightBarButtonItem:rightItm];
    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    [self.navigationItem.leftBarButtonItem setTintColor:MAINCOLOR];

    [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    
    collectListArray = [DataItemArray new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        
        currentIndex = 1;
        [collectListArray clear];
        [self getCollectListRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex ++;
        [self getCollectListRequest];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editTableView{
    isEditing = !isEditing;
    [self.tableView setEditing:isEditing animated:YES];
}

#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return collectListArray.size;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(CommunityCollectTableViewCell *cell) {
        
        [self configCell:cell IndexPath:indexPath];
        
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityCollectTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityCollectTableViewCell" owner:self options:nil].firstObject;
    
    [self configCell:cell IndexPath:indexPath];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        selectIndex = indexPath.row;
        
        [self userCollectionDelete];
    }
}


-(void)configCell:(CommunityCollectTableViewCell*)cell IndexPath:(NSIndexPath*)path{
    [cell bingdingViewModel:[collectListArray getItem:path.row]];
}

-(void)getCollectListRequest{
    [[CommunityService sharedCommunityService] getUserCollectListWithPage:currentIndex Size:10 Parameters:nil onCompletion:^(id json) {
        DataResult* result= json;
        [collectListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
        totalCount = [result.detailinfo getInt:@"TotalCount"];
        
        [self.tableView.mj_header endRefreshing];
        
        
        if (currentIndex*10 < totalCount) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];

    } onFailure:^(id json) {
        
    }];

}

-(void)userCollectionDelete{
    
    [[CommunityService sharedCommunityService] userCollectionDeleteWithParameters:@{@"noteId":[[collectListArray getItem:selectIndex] getString:@"Id"]} onCompletion:^(id json) {
        //修改数据源，在刷新 tableView
        [collectListArray removeByIndex:selectIndex];
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
        
    } onFailure:^(id json) {
        
    }];
}
@end
