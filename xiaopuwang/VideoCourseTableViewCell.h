//
//  VideoCourseTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol VideoCourseCellDelegate <NSObject>

-(void)selectVideoDelegate:(id)sender;

@end

@interface VideoCourseTableViewCell : BaseTableViewCell
@property(nonatomic,weak)IBOutlet UIButton* oneButton;
@property(nonatomic,weak)IBOutlet UIButton* twoButton;
@property(nonatomic,weak)IBOutlet UIButton* threeButton;
@property(nonatomic,weak)IBOutlet UIButton* fourButton;

@property(nonatomic,weak)IBOutlet UILabel* oneLabel;
@property(nonatomic,weak)IBOutlet UILabel* twoLabel;
@property(nonatomic,weak)IBOutlet UILabel* threeLabel;
@property(nonatomic,weak)IBOutlet UILabel* fourLabel;

@property(nonatomic,weak)IBOutlet UIImageView* oneBG;
@property(nonatomic,weak)IBOutlet UIImageView* twoBG;
@property(nonatomic,weak)IBOutlet UIImageView* threeBG;
@property(nonatomic,weak)IBOutlet UIImageView* fourBG;
@property(nonatomic,assign)id<VideoCourseCellDelegate>delegate;

-(IBAction)selectViedeoAction:(id)sender;

-(void)bingdingViewModel:(DataResult*)result;
@end


