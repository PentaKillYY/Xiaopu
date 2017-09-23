//
//  GroupCourseDetailPriceCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseDetailPriceCell.h"

@implementation GroupCourseDetailPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.originPriceView.layer setBorderColor:GroupCourseDarkGray.CGColor];
    [self.originPriceView.layer setCornerRadius:5.0];
    [self.originPriceView.layer setBorderWidth:0.5];
    [self.originPriceView.layer setMasksToBounds:YES];
    
    [self.groupPriceView.layer setBorderColor:GroupCourseRed.CGColor];
    [self.groupPriceView.layer setCornerRadius:5.0];
    [self.groupPriceView.layer setBorderWidth:0.5];
    [self.groupPriceView.layer setMasksToBounds:YES];
    
    [self.courseButton setBackgroundColor:GroupCourseRed];
    [self.courseButton.layer setCornerRadius:5.0];
    [self.courseButton.layer setMasksToBounds:YES];
    
    self.originPriceLabel.textColor =GroupCourseDarkGray;
    self.groupPriceLabel.textColor =GroupCourseRed;
    
    _courseitem = [DataItem new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)originButtonClicked:(id)sender{
    self.originBGImage.image = V_IMAGE(@"groupPrice");
    self.groupBGImage.image = V_IMAGE(@"originPrice");
    [self.originPriceView.layer setBorderColor:GroupCourseRed.CGColor];
    [self.groupPriceView.layer setBorderColor:GroupCourseDarkGray.CGColor];
    self.originPriceLabel.textColor =GroupCourseRed;
    self.groupPriceLabel.textColor =GroupCourseDarkGray;
    self.isOriginPrice = YES;
    
    [self.courseButton setTitle:@"原价报课" forState:0];
}

-(IBAction)groupButtonClicked:(id)sender{
    self.originBGImage.image = V_IMAGE(@"originPrice");
    self.groupBGImage.image = V_IMAGE(@"groupPrice");
    
    [self.groupPriceView.layer setBorderColor:GroupCourseRed.CGColor];
    [self.originPriceView.layer setBorderColor:GroupCourseDarkGray.CGColor];
    self.originPriceLabel.textColor =GroupCourseDarkGray;
    self.groupPriceLabel.textColor =GroupCourseRed;
    self.isOriginPrice = NO;
    if ([_courseitem getInt:@"FightCourseState"]==0) {
        [self.courseButton setTitle:@"拼课未开始" forState:0];
    }else if ([_courseitem getInt:@"FightCourseState"]==1){
        if ([_courseitem getInt:@"UserState"]==0) {
            [self.courseButton setTitle:@"一键拼课" forState:0];
        }else{
            [self.courseButton setTitle:@"邀请好友来拼课" forState:0];
        }
        
    }else if ([_courseitem getInt:@"FightCourseState"]==2){
        [self.courseButton setTitle:@"等待开奖" forState:0];
    }else if ([_courseitem getInt:@"FightCourseState"]){
        [self.courseButton setTitle:@"查看中奖情况" forState:0];
    }
    
}

-(void)bingdingViewModel:(DataItem*)detailItem{
    [_courseitem append:detailItem];
    
    self.originPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[detailItem getDouble:@"OriginalPrice"]];
    self.groupPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[detailItem getDouble:@"FightCoursePrice"]];
    self.groupPriceTitle.text = [NSString stringWithFormat:@"%d人拼课",[detailItem getInt:@"FightCoursePeopleCount"]];
    
    if ([detailItem getInt:@"FightCourseState"]==0) {
        [self.courseButton setTitle:@"拼课未开始" forState:0];
    }else if ([detailItem getInt:@"FightCourseState"]==1){
        if ([detailItem getInt:@"UserState"]==0) {
            [self.courseButton setTitle:@"一键拼课" forState:0];
        }else{
            [self.courseButton setTitle:@"邀请好友来拼课" forState:0];
        }
        
    }else if ([detailItem getInt:@"FightCourseState"]==2){
        [self.courseButton setTitle:@"等待开奖" forState:0];
    }else if ([detailItem getInt:@"FightCourseState"]){
        [self.courseButton setTitle:@"查看中奖情况" forState:0];
    }
}

-(IBAction)courseAction:(id)sender{
    [self.delegate goToCourseHandle:self.isOriginPrice];
}
@end
