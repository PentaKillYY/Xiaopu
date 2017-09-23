//
//  GroupCourseAdwardInfoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseAdwardInfoTableViewCell.h"

@implementation GroupCourseAdwardInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*) adwardItem{
    if ([adwardItem getString:@"UserName"].length) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@**",[[adwardItem getString:@"UserName"] substringToIndex:1]];
    }
    
    if ([adwardItem getString:@"UserPhone"].length==11) {
        self.phoneLabel.text = [NSString stringWithFormat:@"%@****%@",[[adwardItem getString:@"UserPhone"] substringWithRange:NSMakeRange(0, 3)],[[adwardItem getString:@"UserPhone"] substringWithRange:NSMakeRange(7, 4)]] ;
    }
    
    self.orderId.text = [adwardItem getString:@"OrderNumber"];
    
}
@end
