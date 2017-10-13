//
//  GroupCoursePayTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/10/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCoursePayTableViewCell.h"

@implementation GroupCoursePayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)payTypeChange:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (button.tag == 0) {
        self.aliPayButton.selected = YES;
        self.weixinPayButton.selected = NO;
    }else{
        self.aliPayButton.selected = NO;
        self.weixinPayButton.selected = YES;
    }
    [self.delegate payType:sender];
}
@end
