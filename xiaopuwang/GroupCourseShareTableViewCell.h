//
//  GroupCourseShareTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupCourseSignedPeopleCollectionViewCell.h"
@protocol GroupCourseShareDelegate <NSObject>

-(void)contactOrgDelegate:(id)sender;
-(void)shareOrgDelegate:(id)sender;

@end

@interface GroupCourseShareTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak)IBOutlet UIButton*contactBotton;
@property(nonatomic,weak)IBOutlet UIButton* shareButton;
@property(nonatomic,weak)IBOutlet UILabel* remainPeopleLabel;
@property(nonatomic,weak)IBOutlet UILabel* signdPeopleLabel;
@property(nonatomic,weak)IBOutlet UICollectionView* peopleCollectionView;
@property(nonatomic,assign)id<GroupCourseShareDelegate>delegate;

-(void)bingdingViewModel:(DataItem*)item;
-(IBAction)contactOrgAction:(id)sender;
-(IBAction)shareOrgAction:(id)sender;
@end

