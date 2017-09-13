//
//  OrgDetailEvaluateTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgDetailEvaluateTableViewCell.h"

@implementation OrgDetailEvaluateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataResult*)result{
    self.evaluateNumber.text = [NSString stringWithFormat:@"%ld条评价",[result.detailinfo getDataItemArray:@"replyList"].size];
}
@end
