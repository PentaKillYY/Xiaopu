//
//  MyAboutInfoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyAboutInfoTableViewCell.h"

@implementation MyAboutInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellContent{
    [self.appLogo.layer setCornerRadius:2.0];
    [self.appLogo.layer setMasksToBounds:YES];
    
    self.appVersion.text =  [NSString stringWithFormat:@"版本号:%@",[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]];

    self.appContent.preferredMaxLayoutWidth = Main_Screen_Width-16;
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[MyAboutInfo dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    self.appContent.attributedText = attrStr;

}
@end
