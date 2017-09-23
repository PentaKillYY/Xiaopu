//
//  GroupCourseDetailExplainCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GroupCourseDetailExplainCell : BaseTableViewCell

@property(nonatomic,weak)IBOutlet UIImageView* oneStepImage;
@property(nonatomic,weak)IBOutlet UIImageView* twoStepImage;
@property(nonatomic,weak)IBOutlet UIImageView* threeStepImage;
@property(nonatomic,weak)IBOutlet UILabel* explainLabel;

-(void)bingdingViewModel:(DataItem*)detailItem;
@end
