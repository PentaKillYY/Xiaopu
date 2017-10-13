//
//  GroupCourseDetailExplainCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseDetailExplainCell.h"

@implementation GroupCourseDetailExplainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)detailItem{
    self.explainLabel.preferredMaxLayoutWidth = Main_Screen_Width-16;
    self.explainLabel.numberOfLines = 0;
    self.explainLabel.textColor = GroupCourseRed;

    self.explainLabel.text = GroupCourseExplain;
    
    if ([detailItem getInt:@"FightCourseState"]==0) {
        [self setupStepImageState:1];
    }else if ([detailItem getInt:@"FightCourseState"]==1) {
        if ([detailItem getInt:@"UserState"]==0) {
           [self setupStepImageState:1];
        }else{
            [self setupStepImageState:2];
        }
    }else if ([detailItem getInt:@"FightCourseState"]==2) {
        [self setupStepImageState:4];
    }else{
        [self setupStepImageState:3];
    }
}

-(void)setupStepImageState:(NSInteger)state{
    
    if (state ==1) {
        self.oneStepImage.image = V_IMAGE(@"groupCourse-1-red");
        self.twoStepImage.image = V_IMAGE(@"groupCourse-2-gray");
        self.threeStepImage.image = V_IMAGE(@"groupCourse-3-gray");
    }else if (state ==2){
        self.oneStepImage.image = V_IMAGE(@"groupCourse-1-gray");
        self.twoStepImage.image = V_IMAGE(@"groupCourse-2-red");
        self.threeStepImage.image = V_IMAGE(@"groupCourse-3-gray");
    }else if(state ==3){
        self.oneStepImage.image = V_IMAGE(@"groupCourse-1-gray");
        self.twoStepImage.image = V_IMAGE(@"groupCourse-2-gray");
        self.threeStepImage.image = V_IMAGE(@"groupCourse-3-red");
    }else{
        self.oneStepImage.image = V_IMAGE(@"groupCourse-1-gray");
        self.twoStepImage.image = V_IMAGE(@"groupCourse-2-gray");
        self.threeStepImage.image = V_IMAGE(@"groupCourse-3-gray");
    }
}
@end
