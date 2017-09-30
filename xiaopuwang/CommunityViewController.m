//
//  CommunityViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/25.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityOneLineImageCell.h"
#import "CommunityService.h"
#import "HMSegmentedControl.h"
#import "FixAlertView.h"
#import "MyService.h"
#import "CommunityTypeCollectionViewCell.h"
static NSString *identify = @"CommunityOneLineImageCell";
static NSString *collectIdentify = @"CommunityTypeCollectionViewCell";

@interface CommunityViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSInteger currentIndex;
    NSInteger totalCount;
    NSInteger currentSegIndex;
    NSInteger selectIndex;
    DataItemArray* communityListArray;
    NSString* userName;
    
    DataResult* communityTypeResult;
    UIView* bgView;
    UIView* typeView;
    
    BOOL isTypeShow;
    
    UICollectionView* typeCollectionView;
    NSInteger selectTypeTag;
}
@property(nonatomic,weak)IBOutlet UITableView* tableView;

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"社区";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    UIBarButtonItem* leftitem = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityType") style:UIBarButtonItemStylePlain target:self action:@selector(selectCommunityType)];
    
    UIBarButtonItem* rightItm = [[UIBarButtonItem alloc] initWithImage:V_IMAGE(@"communityUser") style:UIBarButtonItemStylePlain target:self action:@selector(goToCommunityUserCenter)];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];

    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:leftitem rightBarButtonItem:rightItm];

    
    [self.navigationItem.rightBarButtonItem setTintColor:MAINCOLOR];
    [self.navigationItem.leftBarButtonItem setTintColor:MAINCOLOR];

    [self setupHeaderView];
    
    [self.tableView registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    
    communityListArray = [DataItemArray new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        
        currentIndex = 1;
        [communityListArray clear];
        [self getComunityListRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentIndex ++;
        [self getComunityListRequest];
        
    }];
    
    
    
    
//    UserInfo* info = [UserInfo sharedUserInfo];
//    if (info.userID.length) {
//        
//    }else{
//        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
//        [self presentViewController:login animated:YES completion:^{
//            
//        }];
//    }
//
    
    [self getCommunityTypeRequest];
}

-(void)setupHeaderView{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"最新", @"精华", @"活动"]];
    segmentedControl.frame = CGRectMake(0 , 0, Main_Screen_Width, 40);
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    segmentedControl.selectionIndicatorColor = MAINCOLOR;
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    [segmentedControl setSelectedSegmentIndex:currentSegIndex];
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 45)];
    headerView.backgroundColor = TEXTFIELD_BG_COLOR;
    
    [headerView addSubview:segmentedControl];
    
    [self.view addSubview:headerView];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserInfo sharedUserInfo].userID.length) {
        if ([UserInfo sharedUserInfo].username.length) {
            
        }else{
            [self showUserNickALertView];
        }
        [self.tableView.mj_header beginRefreshing];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CommunityToDetail"]) 
    {
        id theSegue = segue.destinationViewController;
        
        DataItem* item =[communityListArray getItem:selectIndex];
        
        [theSegue setValue:[item getString:@"Id"] forKey:@"communityId"];
    }
}

-(void)showUserNickALertView{
    FixAlertView *alert = [[FixAlertView alloc] initWithTitle:@"请输入昵称" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *txtName = [alert textFieldAtIndex:0];
    txtName.placeholder = @"4-30字符，支持中英文和数字";
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UITextField *txtName = [alertView textFieldAtIndex:0];
    if (txtName.text.length) {
        userName = txtName.text;
        [self updateInfoRequest];
    }
}

#pragma mark - UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return communityListArray.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(CommunityOneLineImageCell *cell) {
        
        [self configCell:cell IndexPath:indexPath];
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityOneLineImageCell* cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityOneLineImageCell" owner:self options:nil].firstObject;
    [self configCell:cell IndexPath:indexPath];
    return cell;
 
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfo* info = [UserInfo sharedUserInfo];
    if (info.userID.length) {
        selectIndex = indexPath.section;
        [self performSegueWithIdentifier:@"CommunityToDetail" sender:self];
    }else{
        UINavigationController* login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:login animated:YES completion:^{
            
        }];
    }
    
}

-(void)configCell:(CommunityOneLineImageCell*)cell IndexPath:(NSIndexPath*)path{
    DataItem* item = [communityListArray getItem:path.section];
    [cell bingdingViewModel:item];
    
    
    if ([item getString:@"ImageUrl"].length) {
        // img  九宫格图片，用collectionView做
        NSArray* imageArray = [[item getString:@"ImageUrl"] componentsSeparatedByString:@","];

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

#pragma mark - SegmentControlChangeValue

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    if (currentSegIndex == 0) {
        [self.tableView.mj_header beginRefreshing];
    }else if (currentSegIndex ==1){
        [self.tableView.mj_header beginRefreshing];
    }else{
        [communityListArray clear];
        [self.tableView reloadData];
    }
    
}

-(void)selectCommunityType{
    if (isTypeShow) {
        [self dismissTagView];
    }else{
        [self showTagView];
    }
}

-(void)goToCommunityUserCenter{
    [self performSegueWithIdentifier:@"CommunityToUser" sender:self];
}


#pragma mark - NetWorkRequest

-(void)getComunityListRequest{
    NSInteger isEssence ;
    
    if (currentSegIndex == 0) {
        isEssence = 0;
    }else{
        isEssence = 1;
    }
    NSString* communityTypeId;
    
    if (selectTypeTag==0) {
        communityTypeId = @"";
    }else{
        communityTypeId = [[communityTypeResult.items getItem:selectTypeTag-1] getString:@"Id"];
    }
    
    NSDictionary* parameter;
    if ([UserInfo sharedUserInfo].userID.length) {
        parameter = @{@"communityTypeId":communityTypeId,@"isEssence":@(isEssence),@"userId":[UserInfo sharedUserInfo].userID};
    }else{
        parameter =@{@"communityTypeId":communityTypeId,@"isEssence":@(isEssence)};
    }
    
    [[CommunityService sharedCommunityService] getCommunityListWithPage:currentIndex Size:10 Parameters:parameter onCompletion:^(id json) {
        DataResult* result = json;
        
        [communityListArray append:[result.detailinfo getDataItemArray:@"list"]];
        
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

-(void)updateInfoRequest{
    UserInfo* info = [UserInfo sharedUserInfo];
    
    [[MyService sharedMyService] updateUserInfoWithParameters:
        @{
        @"UserId":info.userID,
        @"UserName":userName,
        @"UserNickName":userName,
        } onCompletion:^(id json) {
                                                                    
        UserInfo* info = [UserInfo sharedUserInfo];
        info.username = userName;
        [info synchronize];
    } onFailure:^(id json) {
                                                                    
    }];
}

-(void)getCommunityTypeRequest{
    [[CommunityService sharedCommunityService] getCommunityTypeWithParameters:nil onCompletion:^(id json) {
        communityTypeResult = json;
    } onFailure:^(id json) {
        
    }];
}

-(void)showTagView{
    NSInteger lineNumber = (communityTypeResult.items.size+1)%3 ? (communityTypeResult.items.size+1)/3 +1 : (communityTypeResult.items.size+1)/3;
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    bgView.backgroundColor = [UIColor colorWithRed:135/255 green:135/255 blue:135/255 alpha:0.7];
    [self.view addSubview:bgView];
    
    
    typeView = [[UIView alloc] initWithFrame:CGRectMake(0, -44*(lineNumber+1), Main_Screen_Width, 44*(lineNumber+1))];
    typeView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:typeView];
    
    UILabel* typeTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, Main_Screen_Width-16, 44)];
    typeTitle.text = @"感兴趣的内容";
    typeTitle.font = [UIFont systemFontOfSize:14.0];
    typeTitle.textColor = [UIColor blackColor];
    [typeView addSubview:typeTitle];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];

    typeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, Main_Screen_Width, 44*(lineNumber)) collectionViewLayout:layout];
    typeCollectionView.dataSource = self;
    typeCollectionView.delegate = self;
    typeCollectionView.backgroundColor = [UIColor whiteColor];
    [typeCollectionView registerNib:[UINib nibWithNibName:collectIdentify bundle:nil] forCellWithReuseIdentifier:collectIdentify];

    [typeView addSubview:typeCollectionView];
    
    [UIView animateWithDuration:0.3 animations:^{
        typeView.center = CGPointMake(Main_Screen_Width/2, 64+44*(lineNumber+1)/2);
    } completion:^(BOOL finished) {
        isTypeShow = YES;
    }];
}

-(void)dismissTagView{
    NSInteger lineNumber = (communityTypeResult.items.size+1)%3 ? (communityTypeResult.items.size+1)/3 +1 : (communityTypeResult.items.size+1)/3;

    [UIView animateWithDuration:0.3 animations:^{
        typeView.center = CGPointMake(Main_Screen_Width/2, -44*(lineNumber+1)/2);
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        isTypeShow = NO;
    }];

}

-(IBAction)postCommunityAction:(id)sender{
    [self performSegueWithIdentifier:@"CommunityToPost" sender:self];
}

#pragma mark - colletionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return communityTypeResult.items.size+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectIdentify forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.typeTag.text = @"不限";
    }else{
        cell.typeTag.text = [[communityTypeResult.items getItem:indexPath.row-1] getString:@"TypeName"];
    }
    
    if (indexPath.row == selectTypeTag) {
        [cell.typeTag.layer setCornerRadius:5.0];
        [cell.typeTag.layer setBorderColor:MAINCOLOR.CGColor];
        [cell.typeTag setTextColor:MAINCOLOR];
        [cell.typeTag.layer setBorderWidth:0.5];
        [cell.typeTag.layer setMasksToBounds:YES];
    }else{
        [cell.typeTag.layer setCornerRadius:5.0];
        [cell.typeTag.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [cell.typeTag.layer setBorderWidth:0.5];
        [cell.typeTag.layer setMasksToBounds:YES];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = SCREEN_WIDTH  - 2;
    return CGSizeMake(width / 3, 43);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    selectTypeTag = indexPath.row;
    [self dismissTagView];
    
    if (currentSegIndex==0 || currentSegIndex ==1) {
        [self.tableView.mj_header beginRefreshing];
    }
}
@end
