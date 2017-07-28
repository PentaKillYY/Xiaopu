//
//  OrgMoreCourseViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgMoreCourseViewController.h"
#import "OrginizationService.h"
#import "OrgClassTableViewCell.h"

@interface OrgMoreCourseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger currentIndex;
    NSInteger selectIndex;
    NSMutableArray* dataSourceArray;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrgMoreCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    dataSourceArray = [[NSMutableArray alloc] init];
    
    self.title = @"所有课程";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex = 1;
        [dataSourceArray removeAllObjects];
        [self getCourseClassRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex +=1;
        
        [self getCourseClassRequest];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"CourseToDetail"])
    {
        id theSegue = segue.destinationViewController;
        DataItem* item = dataSourceArray[selectIndex];
        
        [theSegue setValue:[item getString:@"Organization_Course_ID"] forKey:@"courseId"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrgClassTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"OrgClassTableViewCell" owner:self options:nil].firstObject;
    [cell bingdingVieModel:dataSourceArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectIndex = indexPath.row;
    [self performSegueWithIdentifier:@"CourseToDetail" sender:self];
}

- (void)getCourseClassRequest{
    [[OrginizationService sharedOrginizationService] getOrgCourseListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(currentIndex),@"pageSize":@(10)} onCompletion:^(id json) {
        DataResult* result = json;
        [dataSourceArray addObjectsFromArray:[[result.detailinfo getDataItemArray:@"list"] toArray]];
        
        [self.tableView.mj_header endRefreshing];
        if (currentIndex*10 < [result.detailinfo getInt:@"TotalCount"]) {
            [self.tableView.mj_footer endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}
@end
