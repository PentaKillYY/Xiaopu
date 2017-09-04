//
//  SchoolCourseTestCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolCourseTestCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel* courseTestTitle;
@property(nonatomic,weak)IBOutlet UILabel* courseTestScore;
-(void)bindingViewModelWithTitle:(NSString*)coursetitle Score:(NSString*)score;
@end
