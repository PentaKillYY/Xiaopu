//
//  OrgGroupCourseTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/10/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupCourseCollectionViewCell.h"
@protocol OrgGroupCourseDelegate <NSObject>

-(void)orgGroupCourseToDetailDelegate:(NSInteger)itemIndex;

@end

@interface OrgGroupCourseTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,weak)IBOutlet UICollectionView* grouppCourseCollectionView;
@property(nonatomic,strong)DataResult* courseResult;
@property(nonatomic,assign)id<OrgGroupCourseDelegate>delegate;

-(void)bingdingViewModel:(DataResult*)result;

@end

