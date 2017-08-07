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
    if ([item getString:@"Introduction"].length) {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[[item getString:@"Introduction"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        
        self.schoolIntro.attributedText = attrStr;

    }else if ([item getString:@"SchoolIntroduce"].length){
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[[item getString:@"SchoolIntroduce"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        
        self.schoolIntro.attributedText = attrStr;
    }else{
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[[item getString:@"CourseIntroduce"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        
        self.schoolIntro.attributedText = attrStr;
    }
    
}

@end
