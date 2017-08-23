//
//  EvaluateTagTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "EvaluateTagTableViewCell.h"

@implementation EvaluateTagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.goodButton.layer setCornerRadius:5.0];
    [self.goodButton.layer setBorderColor:[UIColor redColor].CGColor];
    [self.goodButton.layer setBorderWidth:0.5];
    [self.goodButton.layer setMasksToBounds:YES];
    
    [self.middleButton.layer setCornerRadius:5.0];
    [self.middleButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.middleButton.layer setBorderWidth:0.5];
    [self.middleButton.layer setMasksToBounds:YES];
    
    [self.badButton.layer setCornerRadius:5.0];
    [self.badButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.badButton.layer setBorderWidth:0.5];
    [self.badButton.layer setMasksToBounds:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)clickButton:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (button.tag == 0) {
        [self.goodButton.layer setBorderColor:[UIColor redColor].CGColor];
        [self.goodButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.goodButton.layer setMasksToBounds:YES];

        [self.middleButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.middleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.middleButton.layer setMasksToBounds:YES];
        
        [self.badButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.badButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.badButton.layer setMasksToBounds:YES];
    }else if (button.tag == 1){
        [self.goodButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.goodButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.goodButton.layer setMasksToBounds:YES];
        
        [self.middleButton.layer setBorderColor:[UIColor redColor].CGColor];
        [self.middleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.middleButton.layer setMasksToBounds:YES];
        
        [self.badButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.badButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.badButton.layer setMasksToBounds:YES];
    }else{
        [self.goodButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.goodButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.goodButton.layer setMasksToBounds:YES];
        
        [self.middleButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.middleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.middleButton.layer setMasksToBounds:YES];
        
        [self.badButton.layer setBorderColor:[UIColor redColor].CGColor];
        [self.badButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.badButton.layer setMasksToBounds:YES];
    }
    
    [self.delegate evaluateTagDelegate:sender];
}

@end
