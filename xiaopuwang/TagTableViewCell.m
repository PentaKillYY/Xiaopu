//
//  TagTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "TagTableViewCell.h"

@implementation TagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupTagView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupTagView
{
    
    //Add Tags
    [@[@"公立", @"大学", @"公立", @"大学",@"公立", @"大学",@"大学",@"公立", @"大学",@"大学",@"公立", @"大学",@"大学",@"公立", @"大学"] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:text];
        tag.textColor = [UIColor grayColor];
        tag.cornerRadius = 3;
        tag.fontSize = 11;
        tag.borderColor = [UIColor grayColor];
        tag.borderWidth = 0.5;
        tag.padding = UIEdgeInsetsMake(2, 2, 2, 2);
        [self.tagView addTag:tag];
    }];
    self.tagView.preferredMaxLayoutWidth = Main_Screen_Width-16;
    
    self.tagView.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tagView.interitemSpacing = 3;
    self.tagView.lineSpacing = 3;
    
    CGFloat tagHeight = self.tagView.intrinsicContentSize.height;
    self.tagH.constant =tagHeight;
}
    

@end
