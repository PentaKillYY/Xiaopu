//
//  MyCouponDetailTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyCouponDetailTableViewCell.h"

@implementation MyCouponDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.giveToAnother.layer setCornerRadius:3.0];
    [self.giveToAnother.layer setBorderColor:[UIColor redColor].CGColor];
    [self.giveToAnother.layer setBorderWidth:0.5];
    [self.giveToAnother.layer setMasksToBounds:YES];
    [self.giveToAnother setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.8f;
    self.bgView.layer.shadowRadius = 2.f;
    self.bgView.layer.shadowOffset = CGSizeMake(0,1);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(NSString*)detailText{
    self.detailContent.preferredMaxLayoutWidth = Main_Screen_Width-32-16;
    self.detailContent.numberOfLines = 0;
    self.detailContent.text = detailText;
}

-(IBAction)giveAnotherAction:(id)sender{
    [self.delegate giveAnotherDelegate:sender];
}
@end
