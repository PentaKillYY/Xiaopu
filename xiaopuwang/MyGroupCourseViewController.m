//
//  MyGroupCourseViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyGroupCourseViewController.h"
#import "GroupCourseService.h"
#import "GroupCourseCollectionViewCell.h"

static NSString *identifyCollection = @"GroupCourseCollectionViewCell";
@interface MyGroupCourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    DataItemArray* groupCourseArray;
    NSInteger currentPage;
    NSInteger totalCount;
    NSInteger selectItemIndex;
}

@property(nonatomic,weak)IBOutlet UICollectionView* collectionView;

@end

@implementation MyGroupCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    groupCourseArray = [DataItemArray new];
    [_collectionView registerNib:[UINib nibWithNibName:identifyCollection bundle:nil] forCellWithReuseIdentifier:identifyCollection];

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

#pragma mark - colletionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return groupCourseArray.size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-24)/2, 110+(Main_Screen_Width)/2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    
    return UIEdgeInsetsMake(8, 8, 0, 8);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyCollection forIndexPath:indexPath];
    DataItem* item = [groupCourseArray getItem:indexPath.row];
    [cell bingdingViewModel:item];
    
    return cell;
    
}


#pragma mark - Networkrequest

-(void)getGroupCourseListRequest{
    [[GroupCourseService sharedGroupCourseService] getUserGroupCourseListWithPage:currentPage Size:10 Parameters:@{@"userId":[UserInfo sharedUserInfo].userID} onCompletion:^(id json) {
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

-(IBAction)clickBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
