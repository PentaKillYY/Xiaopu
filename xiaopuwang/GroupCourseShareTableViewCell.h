//
//  GroupCourseShareTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupCourseShareDelegate <NSObject>

-(void)contactOrgDelegate:(id)sender;
-(void)shareOrgDelegate:(id)sender;

@end

@interface GroupCourseShareTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIButton*contactBotton;
@property(nonatomic,weak)IBOutlet UIButton* shareButton;
@property(nonatomic,weak)IBOutlet UILabel* remainPeopleLabel;
@property(nonatomic,assign)id<GroupCourseShareDelegate>delegate;

-(void)bingdingViewModel:(DataItem*)item;
-(IBAction)contactOrgAction:(id)sender;
-(IBAction)shareOrgAction:(id)sender;
@end

