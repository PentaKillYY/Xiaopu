//
//  HomeGroupCourseTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GroupCourseCollectionViewCell.h"
@interface HomeGroupCourseTableViewCell : BaseTableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,weak)IBOutlet UICollectionView* collectionView;
@property (nonatomic,strong) NSMutableArray *courseDatas;

@end
