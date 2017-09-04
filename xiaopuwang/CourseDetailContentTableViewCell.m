//
//  CourseDetailContentTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/28.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CourseDetailContentTableViewCell.h"

@implementation CourseDetailContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataResult*)result{
    
    self.courseContent.preferredMaxLayoutWidth = Main_Screen_Width-16;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[ [result.detailinfo getString:@"Introduction"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    self.courseContent.attributedText = attrStr;
}
@end
