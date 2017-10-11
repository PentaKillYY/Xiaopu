//
//  GroupCourseDetailInfoCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol GroupCourseDetailInfoDelegate <NSObject>

-(void)groupCourseMoreInfoDelegate:(id)sender;
-(void)groupCourseToOrgDelegate:(id)sender;
@end

@interface GroupCourseDetailInfoCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIImageView* orgLogo;
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet UILabel* courseInfo;
@property(nonatomic,assign)id<GroupCourseDetailInfoDelegate>delegate;

-(void)bingdingViewModel:(DataItem*)detailItem;

-(IBAction)seeMoreInfoAction:(id)sender;
-(IBAction)goToOrgAction:(id)sender;
@end

