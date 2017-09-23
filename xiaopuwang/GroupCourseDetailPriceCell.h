//
//  GroupCourseDetailPriceCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol GroupCourseDetailPriceDelegate <NSObject>

-(void)goToCourseHandle:(BOOL)isOrigin;

@end

@interface GroupCourseDetailPriceCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIView* originPriceView;
@property(nonatomic,weak)IBOutlet UIView* groupPriceView;
@property(nonatomic,weak)IBOutlet UIButton* courseButton;
@property(nonatomic,weak)IBOutlet UILabel* originPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel* groupPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel* originPriceTitle;
@property(nonatomic,weak)IBOutlet UILabel* groupPriceTitle;
@property(nonatomic,weak)IBOutlet UIButton* originPriceButton;
@property(nonatomic,weak)IBOutlet UIButton* groupPriceButton;
@property(nonatomic,weak)IBOutlet UIImageView* originBGImage;
@property(nonatomic,weak)IBOutlet UIImageView* groupBGImage;
@property(nonatomic,strong)DataItem* courseitem;

@property(nonatomic)BOOL isOriginPrice;

@property(nonatomic,assign)id<GroupCourseDetailPriceDelegate>delegate;

-(IBAction)originButtonClicked:(id)sender;
-(IBAction)groupButtonClicked:(id)sender;

-(IBAction)courseAction:(id)sender;

-(void)bingdingViewModel:(DataItem*)detailItem;
@end

