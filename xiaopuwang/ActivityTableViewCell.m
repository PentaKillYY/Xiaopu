//
//  ActivityTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    [self.activityImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"AdvImage"]]] placeholderImage:nil];
    self.activityTime.text = [[item getString:@"AdvExpirationDate"] substringToIndex:10];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[[item getString:@"AdvExpirationDate"] substringToIndex:10]];
    
    NSDate *now = [NSDate date];
    
    
    if ([now compare:date] == NSOrderedDescending) {
        self.activityState.textColor = [UIColor redColor];
        self.activityState.text = @"已结束";
    }else{
        self.activityState.textColor = [UIColor greenColor];
        self.activityState.text = @"进行中";
    }
}
@end
