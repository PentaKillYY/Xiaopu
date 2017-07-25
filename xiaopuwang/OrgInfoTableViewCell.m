//
//  OrgInfoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgInfoTableViewCell.h"

@implementation OrgInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[[item getString:@"Introduction"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    self.orgDetail.attributedText = attrStr;
    
    NSString* temp = [item getString:@"Introduction"];
    NSString *string1 = [temp stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    NSString *string4 = [string3 stringByReplacingOccurrencesOfString:@"</br>" withString:@""];
    NSString *string5 = [string4 stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    self.orgDetail.text = string5;
}
@end
