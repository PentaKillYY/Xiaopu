//
//  EvaluatePicTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "EvaluatePicTableViewCell.h"

@implementation EvaluatePicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)takePicAction:(id)sender{
    [self.delegate takePicDelegate:sender];
}

-(IBAction)deletePicAction:(id)sender{
    [self.delegate deletePicDelegate:sender];
}
@end
