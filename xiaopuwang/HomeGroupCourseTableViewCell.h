//
//  HomeGroupCourseTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GroupCourseCollectionViewCell.h"
@protocol HomeGroupCourseDelegate <NSObject>

-(void)groupCourseSelect:(NSInteger)index;

@end

@interface HomeGroupCourseTableViewCell : BaseTableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,weak)IBOutlet UICollectionView* collectionView;
@property (nonatomic,strong) DataItemArray *courseItemArray;
@property (nonatomic,assign)id<HomeGroupCourseDelegate>delegate;

-(void)bingdingViewModel:(DataItemArray*)courseArray;
@end

