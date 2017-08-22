//
//  ReflectCardTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/22.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "ReflectCardTableViewCell.h"

@implementation ReflectCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.cardName.text = [item getString:@"BankName"];
    self.cardNumber.text = [NSString stringWithFormat:@"**** **** **** %@",[[item getString:@"CardNum"] substringWithRange:NSMakeRange([item getString:@"CardNum"].length-4, 4)]] ;
}


@end
