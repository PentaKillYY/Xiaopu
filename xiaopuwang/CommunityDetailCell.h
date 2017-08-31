//
//  CommunityDetailCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CommunityOneLineImageCell.h"

@protocol CommunityDetailCellDelegate <NSObject>

-(void)deleteCommunityDelegate:(id)sender;
-(void)praiseCommunityDelegate:(id)sender;

@end

@interface CommunityDetailCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* userLogo;
@property(nonatomic,weak)IBOutlet UILabel* userName;
@property(nonatomic,weak)IBOutlet UILabel* communityTime;
@property(nonatomic,weak)IBOutlet UILabel* userType;
@property(nonatomic,weak)IBOutlet UILabel* communityTitle;
@property(nonatomic,weak)IBOutlet UILabel* communityContent;
@property(nonatomic,weak)IBOutlet UICollectionView *imageCollectionView;
@property(weak, nonatomic)IBOutlet NSLayoutConstraint *colletionViewHeight;
@property(weak, nonatomic)IBOutlet NSLayoutConstraint *deleteCommunityHeight;
@property(nonatomic,weak)IBOutlet UILabel* praiseNumber;
@property(nonatomic,weak)IBOutlet UILabel* replyNumber;
@property(nonatomic,weak)IBOutlet UILabel* viewNumber;
@property(nonatomic,strong) NSMutableArray *imageDatas;
@property(nonatomic,weak)IBOutlet UILabel* address;
@property(nonatomic,weak)IBOutlet UIButton* deleteCommunityButton;
@property(nonatomic,assign)id<CommunityDetailCellDelegate>delegate;
@property(nonatomic,weak)IBOutlet UIButton* praiseButton;

-(void)bingdingViewModel:(DataItem*)item;
-(IBAction)deleteCommunityAction:(id)sender;
-(IBAction)praiseCommunityAction:(id)sender;
@end


