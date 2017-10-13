//
//  GroupCoursePayTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/10/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol GroupCoursePayDelegate <NSObject>

-(void)payType:(id)sender;

@end

@interface GroupCoursePayTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* aliPayButton;
@property(nonatomic,weak)IBOutlet UIButton* weixinPayButton;
@property(nonatomic,assign)id<GroupCoursePayDelegate>delegate;
-(IBAction)payTypeChange:(id)sender;

@end

