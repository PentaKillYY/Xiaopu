//
//  CommonRedBagTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommonRedBagTableViewCell.h"

@implementation CommonRedBagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupred{
    self.bagPriceLabel.textColor = GroupCourseRed;
    self.bagPriceUnitLabel.textColor = GroupCourseRed;
    self.bagTipImage.image = V_IMAGE(@"commonredtitle");
    self.bagLogoImage.image = V_IMAGE(@"commonredbag");
    self.bagEndTimeLabel.text = @"有效期至2017-10-30";
    self.useButton.hidden = NO;
}

-(void)setupgray{
    self.bagPriceLabel.textColor = RedBagGray;
    self.bagPriceUnitLabel.textColor = RedBagGray;
    self.bagTipImage.image = V_IMAGE(@"commongraytitle");
    self.bagLogoImage.image = V_IMAGE(@"commongraybag");
    self.bagEndTimeLabel.text = @"已失效";
    self.bagEndTimeLabel.textColor = RedBagGray;
    self.useButton.hidden = YES;
}

-(void)bingdingViewModel:(DataItem*)item{
    self.bagPriceLabel.text = [NSString stringWithFormat:@"%d",[item getInt:@"Price"]] ;
    
    NSString* startTime =  [[item getString:@"CreateTime"] substringToIndex:10] ;
     

    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    
    NSDate *data = [format dateFromString:startTime];
    NSDate *nextDate = [NSDate dateWithTimeInterval:60*60*60 sinceDate:data];
    NSString *endTime = [format stringFromDate:nextDate];

    self.bagEndTimeLabel.text= [NSString stringWithFormat:@"有效期至:%@",endTime] ;

}
@end
