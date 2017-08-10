//
//  MyFollowViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyFollowViewController.h"
#import "MyService.h"
#import "OrginizationService.h"
#import "SchoolService.h"
#import "HMSegmentedControl.h"
#import "MyFollowOrgCell.h"
#import "MyFollowSchoolCell.h"

@interface MyFollowViewController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate>
{
    NSInteger currentSegIndex;
    DataResult* orgResult;
    DataResult* schoolResult;
    NSInteger selectOrgIndex;
    NSInteger selectSchoolIndex;
}

@property(nonatomic,weak)IBOutlet UITableView* tableView;
@end

@implementation MyFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的关注";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyFollowOrgCell" bundle:nil] forCellReuseIdentifier:@"MyFollowOrgCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyFollowSchoolCell" bundle:nil] forCellReuseIdentifier:@"MyFollowSchoolCell"];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];

    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:nil];

    [self setupSegControl];
    
    [self getUserFocusOrgRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSegControl{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"机 构", @"学 校"]];
    segmentedControl.frame = CGRectMake(0 , 64, Main_Screen_Width, 40);
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    segmentedControl.selectionIndicatorColor = MAINCOLOR;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    [segmentedControl setSelectedSegmentIndex:currentSegIndex];
    
    [self.view addSubview:segmentedControl];
}

#pragma mark - SegChange
-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    if (currentSegIndex == 0) {
        [self getUserFocusOrgRequest];
    }else{
        [self getUserFocusSchoolRequest];
    }
    
}

#pragma mark - UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (currentSegIndex == 0) {
        return orgResult.items.size;
    }else{
        return schoolResult.items.size;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 0) {
        return  [tableView fd_heightForCellWithIdentifier:@"MyFollowOrgCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configOrgCell:cell indexpath:indexPath];
        }];
    }else{
        return  [tableView fd_heightForCellWithIdentifier:@"MyFollowSchoolCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            [self configSchoolCell:cell indexpath:indexPath];
        }];
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentSegIndex == 0) {
        MyFollowOrgCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyFollowOrgCell" owner:self options:nil].firstObject;
        cell.rightButtons = [self createRightButtons:1];
        [self configOrgCell:cell indexpath:indexPath];
        cell.delegate = self;
        cell.tag = indexPath.row;
        return cell;
    }else{
        MyFollowSchoolCell* cell = [[NSBundle mainBundle] loadNibNamed:@"MyFollowSchoolCell" owner:self options:nil].firstObject;
        [self configSchoolCell:cell indexpath:indexPath];
        cell.rightButtons = [self createRightButtons:1];
        cell.delegate = self;
        cell.tag = indexPath.row;
        return cell;
    }
    
}

-(void)configOrgCell:(MyFollowOrgCell*)cell indexpath:(NSIndexPath*)indexpath{
    
    [cell bingdinViewModel:[orgResult.items getItem:indexpath.row]];
}

-(void)configSchoolCell:(MyFollowSchoolCell*)cell indexpath:(NSIndexPath*)indexpath{
    [cell.schoolClassView removeAllTags];
    DataItem* item =[schoolResult getItem:indexpath.row];
    
    [cell bingdingViewModel:item];
    
    [@[[item getString:@"CollegeNature"], [item getString:@"CollegeType"]] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:text];
        tag.textColor = [UIColor grayColor];
        tag.cornerRadius = 3;
        tag.fontSize = 12;
        tag.borderColor = [UIColor grayColor];
        tag.borderWidth = 0.5;
        tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
        [cell.schoolClassView addTag:tag];
    }];
    cell.schoolClassView.preferredMaxLayoutWidth = Main_Screen_Width-104;
    
    cell.schoolClassView.padding = UIEdgeInsetsMake(5, 0, 5, 0);
    cell.schoolClassView.interitemSpacing = 5;
    cell.schoolClassView.lineSpacing = 5;
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[1] = {@"取消关注"};
    UIColor * colors[1] = {MAINCOLOR};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            
            BOOL autoHide = i != 0;
            return autoHide; //Don't autohide in delete button to improve delete expansion animation
        }];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [result addObject:button];
    }
    return result;
}

#pragma mark - NetWorkRequest
-(void)getUserFocusOrgRequest{
    [[MyService sharedMyService] getUserFocusOrgWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        orgResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)getUserFocusSchoolRequest{
    [[MyService sharedMyService] getUserFocusSchoolWithParameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
        schoolResult = json;
        [self.tableView reloadData];
    } onFailure:^(id json) {
        
    }];
}

-(void)delFocusOrgRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    [[OrginizationService sharedOrginizationService] delfocusOrgWithOrgID:[[orgResult.items getItem:selectOrgIndex] getString:@"Organization_ID"] Userid:info.userID onCompletion:^(id json) {
        [self getUserFocusOrgRequest];
    } onFailure:^(id json) {
        
    }];
}

-(void)delFollowSchoolRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[SchoolService sharedSchoolService] delFollowSchoolWithParameters:@{@"schoolId":[[schoolResult.items getItem:selectSchoolIndex] getString:@"School_Application_ID"],@"userId":info.userID} onCompletion:^(id json) {
        
        [self getUserFocusSchoolRequest];
    } onFailure:^(id json) {
        
    }];
}

#pragma mark - MGSwipeTableCellDelegate
-(BOOL) swipeTableCell:(nonnull MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    if (currentSegIndex == 0) {
        selectOrgIndex = cell.tag;
        [self delFocusOrgRequest];
    }else{
        selectSchoolIndex = cell.tag;
        [self delFollowSchoolRequest];
    }
    
    return YES;
}
@end
