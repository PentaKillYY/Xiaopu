//
//  OrgMoreTeacherViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgMoreTeacherViewController.h"
#import "OrginizationService.h"
#import "OrgMoreTeacherTableViewCell.h"

@interface OrgMoreTeacherViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentIndex;
    NSMutableArray* datasourceArray;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation OrgMoreTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部老师";
    
    datasourceArray = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrgMoreTeacherTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrgMoreTeacher"];

    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex = 1;
        [datasourceArray removeAllObjects];
        [self getTeacherListRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex +=1;
        
        [self getTeacherListRequest];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datasourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [tableView fd_heightForCellWithIdentifier:@"OrgMoreTeacher" cacheByIndexPath:indexPath configuration:^(id cell) {
        [self configCell:cell indexpath:indexPath];
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     OrgMoreTeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrgMoreTeacher" forIndexPath:indexPath];
   
    
    [self configCell:cell indexpath:indexPath];
    return cell;

}

- (void)configCell:(OrgMoreTeacherTableViewCell *)cell indexpath:(NSIndexPath *)indexpath{
    [cell.teacherTagView removeAllTags];
    
    DataItem * item = datasourceArray[indexpath.row];
    [cell bingdingViewModel:item];
    
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
        tag.enable = NO;
        tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
        [cell.teacherTagView addTag:tag];
    }];
    
}


-(void)getTeacherListRequest{
    [[OrginizationService sharedOrginizationService] getCourseTeacherListWithParameters:@{@"orgApplicationID":self.orgID,@"pageIndex":@(currentIndex),@"pageSize":@(10)} onCompletion:^(id json) {
        
        DataResult* result = json;
        DataItemArray* itemArray =  [result.detailinfo getDataItemArray:@"teacherList"];
        
        for (int i = 0 ; i < itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            [datasourceArray addObject:item];
        }
        
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
