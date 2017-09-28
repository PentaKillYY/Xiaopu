//
//  RedBagViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "RedBagViewController.h"
#import "CommonRedBagTableViewCell.h"
#import "SpecialRedBagTableViewCell.h"
#import "HMSegmentedControl.h"
#import "RedBagService.h"

@interface RedBagViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentSegIndex;

    DataItemArray* redbagArray;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;
@property(nonatomic,weak)IBOutlet HMSegmentedControl* segmentedControl;
@end

@implementation RedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的红包";
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    redbagArray = [DataItemArray new];
    
    [self setupSeg];
    

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self getRedBagRequest];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSeg{
    _segmentedControl.sectionTitles =@[@"可用红包", @"失效红包"];
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionIndicatorEdgeInsets =UIEdgeInsetsMake(0, -30, 0,-60);
    _segmentedControl.selectionIndicatorColor = MAINCOLOR;
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    [_segmentedControl setSelectedSegmentIndex:currentSegIndex];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return redbagArray.size;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 131;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataItem* item =[redbagArray getItem:indexPath.row];
    if ([item getInt:@"RedPacketType"]==0) {
        CommonRedBagTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommonRedBagTableViewCell" owner:self options:nil].firstObject;
        if (currentSegIndex ==0) {
            [cell setupred];
        }else{
            [cell setupgray];
        }
        [cell bingdingViewModel:[redbagArray getItem:indexPath.row]];
        return cell;
    }else{
        SpecialRedBagTableViewCell* cell = [[NSBundle mainBundle] loadNibNamed:@"SpecialRedBagTableViewCell" owner:self options:nil].firstObject;
        if (currentSegIndex ==0) {
            [cell setupred];
        }else{
            [cell setupgray];
        }
        [cell bingdingViewModel:[redbagArray getItem:indexPath.row]];
        return cell;
    }
    
}

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    [self.tableView.mj_header beginRefreshing];
}


-(void)getRedBagRequest{
    [redbagArray clear];
    [[RedBagService sharedRedBagService] getUserRedBagListWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"state":@(currentSegIndex)} onCompletion:^(id json) {
        DataResult* result = json;
        [redbagArray append:result.items];
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];

    } onFailure:^(id json) {
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
    }];
    
   }
@end
