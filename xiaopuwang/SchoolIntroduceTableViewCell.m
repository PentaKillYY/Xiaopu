//
//  SchoolIntroduceTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/2.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolIntroduceTableViewCell.h"

@implementation SchoolIntroduceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[[item getString:@"Introduction"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    
    self.schoolIntro.attributedText = attrStr;
}

@end
