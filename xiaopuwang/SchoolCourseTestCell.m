//
//  SchoolCourseTestCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolCourseTestCell.h"

@implementation SchoolCourseTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindingViewModelWithTitle:(NSString*)coursetitle Score:(NSString*)score{
    self.courseTestTitle.text = coursetitle;
    self.courseTestScore.text = score;
}
@end
