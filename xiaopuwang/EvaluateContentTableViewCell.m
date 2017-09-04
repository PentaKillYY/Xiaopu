//
//  EvaluateContentTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "EvaluateContentTableViewCell.h"

@implementation EvaluateContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textViewDidBeginEditing:(UITextView*)textView {
    
    if([textView.text isEqualToString:@"请简易评价本次交易过程"]) {
        
        textView.text=@"";
        
        textView.textColor= [UIColor blackColor];
        
    }
    
}


- (void)textViewDidEndEditing:(UITextView*)textView {
    
    if(textView.text.length<1) {
        
        textView.text=@"请简易评价本次交易过程";
        
        textView.textColor= [UIColor lightGrayColor];
        
    }
    
}

@end
