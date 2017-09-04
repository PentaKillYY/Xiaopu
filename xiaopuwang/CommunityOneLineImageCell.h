//
//  CommunityTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/25.
//  Copyright © 2017年 ings. All rights reserved.
//


#import "BaseTableViewCell.h"
#import "CommentImageCollectionViewCell.h"
@interface CommunityOneLineImageCell : BaseTableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak)IBOutlet UIImageView* userLogo;
@property(nonatomic,weak)IBOutlet UILabel* userName;
@property(nonatomic,weak)IBOutlet UILabel* communityTime;
@property(nonatomic,weak)IBOutlet UILabel* userType;
@property(nonatomic,weak)IBOutlet UILabel* communityTitle;
@property(nonatomic,weak)IBOutlet UILabel* communityContent;
@property(nonatomic,weak)IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colletionViewHeight;
@property(nonatomic,weak)IBOutlet UILabel* praiseNumber;
@property(nonatomic,weak)IBOutlet UILabel* replyNumber;
@property(nonatomic,weak)IBOutlet UILabel* viewNumber;
@property (nonatomic,strong) NSMutableArray *imageDatas;

-(void)bingdingViewModel:(DataItem*)item;
@end
