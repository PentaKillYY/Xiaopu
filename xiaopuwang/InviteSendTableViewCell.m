//
//  InviteSendTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InviteSendTableViewCell.h"

@implementation InviteSendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupInviteTotal];
    [self.sendInviteButton.layer setCornerRadius:15.0];
    [self.sendInviteButton.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupInviteTotal{
    NSString* price = @"5050";
    
    self.totalWidth.constant = price.length*24-3;
    
    for (int i = 0; i< price.length; i++) {
        UILabel* number = [[UILabel alloc] initWithFrame:CGRectMake(24*i, 0, 21, 25)];
        
        number.text = [price substringWithRange:NSMakeRange(i, 1)];
        number.textColor = [UIColor whiteColor];
        number.backgroundColor = [UIColor blackColor];
        number.textAlignment = NSTextAlignmentCenter;
        [number.layer setCornerRadius:3.0];
        [number.layer setMasksToBounds:YES];
        number.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0];
        [self.priceBG addSubview:number];
    }

}
@end
