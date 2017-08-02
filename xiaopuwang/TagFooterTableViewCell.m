//
//  TagFooterTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "TagFooterTableViewCell.h"

@implementation TagFooterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.clearBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.clearBtn.layer setBorderWidth:1.0];
    [self.clearBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.clearBtn.layer setCornerRadius:3.0];
    [self.clearBtn.layer setMasksToBounds:YES];
    
    [self.resetBtn.layer setBorderColor:MAINCOLOR.CGColor];
    [self.resetBtn.layer setBorderWidth:1.0];
    [self.resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.resetBtn setBackgroundColor:MAINCOLOR];
    [self.resetBtn.layer setCornerRadius:3.0];
    [self.resetBtn.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)clearButtonAction:(id)sender{
    [self.delegate clearDelegate:sender];
}

-(IBAction)confirmButtonAction:(id)sender{
    [self.delegate confirmDelegate:sender];
}

@end
