//
//  SchoolBasicInfoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolBasicInfoTableViewCell.h"

@implementation SchoolBasicInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdngViewModel:(DataItem*)item{
    NSString* TOEFL = [item getString:@"TOEFL"];
    NSString* IELTS = [item getString:@"IELTS"];
    NSString* Japanese = [item getString:@"Japanese"];
    
    NSMutableString* scoreTItleString = [[NSMutableString alloc] init];
    NSMutableString* scoreString = [[NSMutableString alloc] init];
    
    if (TOEFL.length>0) {
        [scoreTItleString appendString:@"托福"];
        [scoreString appendString:TOEFL];
    }
    
    if (IELTS.length>0 && scoreTItleString.length>0) {
        [scoreTItleString appendString:@"/雅思"];
        [scoreString appendString:[NSString stringWithFormat:@"/%@",IELTS]];
    }else if (IELTS.length>0){
        [scoreTItleString appendString:@"雅思"];
        [scoreString appendString:IELTS];
    }
    
    if (Japanese.length>0 && scoreTItleString.length>0) {
        [scoreTItleString appendString:@"/日语"];
        [scoreString appendString:[NSString stringWithFormat:@"/%@",Japanese]];
    }else if (Japanese.length>0){
        [scoreTItleString appendString:@"日语"];
        [scoreString appendString:Japanese];
    }
    
    self.scoreTitleLabel.text = scoreTItleString;
    self.scoreLabel.text = scoreString;
    
    self.applyStartLabel.text = [item getString:@"ApplyStart"];
    self.applyEndLabel.text = [item getString:@"ApplyEnd"];
    
}
@end
