//
//  MyCardTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyCardTableViewCell.h"

@implementation MyCardTableViewCell

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
    NSInteger cardIndex;
    if ([AddCardBankName containsObject:[item getString:@"BankName"]]) {
        cardIndex = [AddCardBankName indexOfObject:[item getString:@"BankName"]];
    }else{
        cardIndex = 0;
    }
    
    self.cardBGView.backgroundColor = [UIColor colorWithHexString:CardBGColor[cardIndex][0]] ;
    
    self.cardLastNumber.text =  [NSString stringWithFormat:@"尾号 %@",[[item getString:@"CardNum"] substringWithRange:NSMakeRange([item getString:@"CardNum"].length-4, 4)]] ;
    [self.cardBGView.layer setCornerRadius:3.0];
    [self.cardBGView.layer setMasksToBounds:YES];
}

-(IBAction)deleteCardAction:(id)sender{
    [self.delegate deleteCard:sender];
}
@end
