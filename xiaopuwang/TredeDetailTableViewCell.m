//
//  TredeDetailTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "TredeDetailTableViewCell.h"

@implementation TredeDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.tradeOrderNumber.text = [item getString:@"ChannelCode"];
    self.tradeContent.text = [NSString stringWithFormat:@"说明:%@",[item getString:@"ChannelName"]] ;
    if ([item getInt:@"OperationType"]==0) {
        self.tradePrice.text = [NSString stringWithFormat:@"收入+%.2f",[item getDouble:@"DetailPrice"]];
    }else{
        self.tradePrice.text = [NSString stringWithFormat:@"收入-%.2f",[item getDouble:@"DetailPrice"]];
    }
    self.tradeTime.text = [[item getString:@"CreateTime"] substringToIndex:10];
    
    self.tradeOrderNumber.textColor = [UIColor lightGrayColor];
    self.tradeContent.textColor = [UIColor blackColor];
    self.tradePrice.textColor = SPECIALISTNAVCOLOR;
    self.tradeTime.textColor = [UIColor lightGrayColor];
    
}
@end
