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
-(void)groupCoursePlayVideoDelegate:(id)sender;

@end

@interface GroupCourseDetailInfoCell : BaseTableViewCell<UIWebViewDelegate>
@property(nonatomic,weak)IBOutlet UIImageView* orgLogo;
@property(nonatomic,weak)IBOutlet UILabel* orgName;
@property(nonatomic,weak)IBOutlet UIWebView* webView;
@property(nonatomic,weak)IBOutlet UIButton* playVideoButton;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* sepHeight;
@property(nonatomic,weak)IBOutlet NSLayoutConstraint* videoHeight;
@property(nonatomic,assign)id<GroupCourseDetailInfoDelegate>delegate;
@property(nonatomic,weak)IBOutlet UIImageView* playImg;

-(void)bingdingViewModel:(DataItem*)detailItem;

-(IBAction)goToOrgAction:(id)sender;
-(IBAction)playVideoAction:(id)sender;

@end

