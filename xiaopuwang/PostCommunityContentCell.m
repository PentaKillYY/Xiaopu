//
//  PostCommunityContentCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "PostCommunityContentCell.h"

@implementation PostCommunityContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentTextView.xx_placeholderFont = [UIFont systemFontOfSize:13.0f];
    self.contentTextView.xx_placeholderColor = [UIColor lightGrayColor];
    self.contentTextView.xx_placeholder = @"增加问题补充，如问题背景等（选填）";
    self.contentTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textViewDidChange:(UITextView *)textView{
    
    self.textLength.text = [NSString stringWithFormat:@"%d / 140",self.contentTextView.text.length];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (self.contentTextView.text.length>139) {
        return NO;
    }else{
        return YES;
    }
}
@end
