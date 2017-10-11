//
//  GroupCourseCollectionViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseCollectionViewCell.h"

@implementation GroupCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.trainingCorner.layer setCornerRadius:12.5];
    [self.trainingCorner.layer setMasksToBounds:YES];
}

-(void)bingdingViewModel:(DataItem*)item{
    [self.groupCourseLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"CourseImage"]]] placeholderImage:nil];
    self.courseName.text = [item getString:@"CourseName"];
    self.courseName.textColor = GroupCourseDarkGray;
    
    NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f",[item getDouble:@"FightCoursePrice"]]];
    NSRange redRangeTwo = NSMakeRange(1, [[noteStr string] rangeOfString:@"."].length);
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:redRangeTwo];
    [self.groupPrice setAttributedText:noteStr];
    self.groupPrice.textColor = GroupCourseRed;
    [self.groupPrice sizeToFit];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat:@"￥%.2f",[item getDouble:@"OriginalPrice"]] attributes:attribtDic];
    
    self.originPrice.attributedText = attribtStr;
    
    self.originPrice.textColor = GroupCourseLightGray;
    
    self.totalPeople.text = [NSString stringWithFormat:@" %ld人拼 ",[item getLong:@"FightCoursePeopleCount"]];
    self.currentPeople.textColor = GroupCourseLightGray;
    NSMutableAttributedString * currentPeopleStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已有%ld人参与拼课",[item getLong:@"FightCourseIsSignPeopleCount"]]];
    NSRange currentPeopleRange = NSMakeRange(2, [[currentPeopleStr string] rangeOfString:@"人"].location-2);
    [currentPeopleStr addAttribute:NSForegroundColorAttributeName value:GroupCourseRed range:currentPeopleRange];
    
    [self.currentPeople setAttributedText:currentPeopleStr];
    [self.currentPeople sizeToFit];

    
    if ([item getInt:@"FightCourseState"]==0) {
        self.groupCourseStateLabel.text = @" 未开始";
    }else if ([item getInt:@"FightCourseState"]==1) {
        if ([item getInt:@"UserState"]==0) {
           self.groupCourseStateLabel.text = @" 去拼课";
        }else{
            self.groupCourseStateLabel.text = @" 邀好友";
        }
    }else if ([item getInt:@"FightCourseState"]==2) {
        self.groupCourseStateLabel.text = @" 已结束";
    }else if ([item getInt:@"FightCourseState"]==3){
        self.groupCourseStateLabel.text = @" 待开奖";
    }else {
        self.groupCourseStateLabel.text = @" 已开奖";
    }
    
}
@end
