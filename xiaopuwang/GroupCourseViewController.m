//
//  GroupCourseViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseViewController.h"

#import "GroupCourseCollectionViewCell.h"
#import "GroupCourseBannerCollectionViewCell.h"
#import "JHHeaderReusableView.h"
#import "JHHeaderFlowLayout.h"
#import "GroupCourseService.h"

static NSString *identifyCollection = @"GroupCourseCollectionViewCell";
static NSString *bannerIdentifier = @"GroupCourseBannerCollectionViewCell";
static NSString *const kHeaderID = @"JHHeaderReusableView";


@interface GroupCourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JHHeaderDelegate>
{
    DataItemArray* groupCourseArray;
    NSInteger currentPage;
    NSInteger totalCount;
    NSString* courseType;
    NSInteger selectItemIndex;
}

@property(nonatomic,weak)IBOutlet UICollectionView* collectionView;
@end

@implementation GroupCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"拼课";
    
    
    groupCourseArray = [DataItemArray new];
    
    JHHeaderFlowLayout *cvLayout = [[JHHeaderFlowLayout alloc] init];

    [_collectionView registerNib:[UINib nibWithNibName:identifyCollection bundle:nil] forCellWithReuseIdentifier:identifyCollection];
    [_collectionView registerNib:[UINib nibWithNibName:bannerIdentifier bundle:nil] forCellWithReuseIdentifier:bannerIdentifier];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JHHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderID];
    cvLayout.headerReferenceSize = CGSizeMake(Main_Screen_Width, 52);

    _collectionView.collectionViewLayout = cvLayout;
    
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentPage +=1;
        
        [self getGroupCourseListRequest];
        
    }];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        currentPage = 1;
        [groupCourseArray clear];
        [self getGroupCourseListRequest];
    }];

    [self.collectionView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GroupCourseToDetail"])     {
        id theSegue = segue.destinationViewController;
        DataItem* item = [groupCourseArray getItem:selectItemIndex];
        
        [theSegue setValue:[item getString:@"FightCourseId"] forKey:@"courseId"];
    }
}


#pragma mark - colletionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return groupCourseArray.size;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        GroupCourseBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerIdentifier forIndexPath:indexPath];
        
        return cell;
    }else{
        GroupCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyCollection forIndexPath:indexPath];
        DataItem* item = [groupCourseArray getItem:indexPath.row];
        [cell bingdingViewModel:item];

        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(Main_Screen_Width, Main_Screen_Width/750*275);
    }else{
      return CGSizeMake((SCREEN_WIDTH-24)/2, 110+(Main_Screen_Width)/2);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    if (section==1) {
        return CGSizeMake(Main_Screen_Width, 52);
    }
    return CGSizeZero;
    
}

#pragma mark - 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头部视图
    if (kind == UICollectionElementKindSectionHeader) {
        JHHeaderReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderID forIndexPath:indexPath];
        headerRV.delegate = self;
        return headerRV;
        
    }else
    {
        return nil;
    }
    
}

#pragma mark - UICollectionDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        selectItemIndex = indexPath.row;
       [self performSegueWithIdentifier:@"GroupCourseToDetail" sender:self];
    }
    
}

#pragma mark - JHHeaderDelegate

-(void)changeHeaderSeg:(NSInteger)valueIndex{
    courseType = OrginizationTypeSelectFilter[valueIndex];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - Networkrequest

-(void)getGroupCourseListRequest{
    
    if (courseType.length>0) {
        
    }else{
        UserInfo* info = [UserInfo sharedUserInfo];
        NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"typeIcon" ofType:@"json"];
        NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
        NSMutableDictionary *typeDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        
        NSString* keyString = [NSString stringWithFormat:@"org_%d",[info.secondSelectIndex intValue]+1];
        NSArray* array = [NSArray arrayWithArray:[typeDic objectForKey:keyString]];
        courseType =[array[0] objectForKey:@"CourseType"];
    }
    
    
    if ([UserInfo sharedUserInfo].userID.length) {
        [[GroupCourseService sharedGroupCourseService] groupCourseListWithPage:currentPage Size:10 Parameters:@{@"userId":[UserInfo sharedUserInfo].userID,@"courseType":courseType} onCompletion:^(id json) {
            DataResult* result = json;
            [groupCourseArray append:[result.detailinfo getDataItemArray:@"list"]];
            totalCount =[result.detailinfo getInt:@"TotalCount"];
            
            if (currentPage* 10 < totalCount) {
                [self.collectionView.mj_footer endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
            
        } onFailure:^(id json) {
            [self.collectionView.mj_header endRefreshing];
            
            if (currentPage* 10 < totalCount) {
                [self.collectionView.mj_footer endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
             [self.collectionView reloadData];
        }];
    }else{
        [[GroupCourseService sharedGroupCourseService] groupCourseListWithPage:currentPage Size:10 Parameters:@{@"courseType":courseType} onCompletion:^(id json) {
            DataResult* result = json;
            [groupCourseArray append:[result.detailinfo getDataItemArray:@"list"]];
            totalCount =[result.detailinfo getInt:@"TotalCount"];
            
            if (currentPage* 10 < totalCount) {
                [self.collectionView.mj_footer endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
            
        } onFailure:^(id json) {
            [self.collectionView.mj_header endRefreshing];
            
            if (currentPage* 10 < totalCount) {
                [self.collectionView.mj_footer endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.collectionView reloadData];
        }];

    }
    
}

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
