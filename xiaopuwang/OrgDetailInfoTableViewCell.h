//
//  OrgDetailInfoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SDCycleScrollView.h"

@protocol OrgDetailCellDelegate <NSObject>

-(void)showMoreInfo:(id)sender;

@end

@interface OrgDetailInfoTableViewCell : BaseTableViewCell<SDCycleScrollViewDelegate>
@property(nonatomic,strong)IBOutlet SDCycleScrollView* cycleScrollView;
@property(nonatomic,weak)IBOutlet UIImageView* orgLogo;
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet UILabel* viewCount;
@property(nonatomic,weak)IBOutlet UILabel* focusCount;
@property(nonatomic,weak)IBOutlet UIButton* moreInfoButton;
@property(nonatomic,assign)id<OrgDetailCellDelegate>delegate;

-(IBAction)clickMoreInfoAction:(id)sender;
-(void)bingdingViewModel:(DataItem*)item;
-(void)bingdingImageModel:(DataItemArray*)itemArray;
@end

