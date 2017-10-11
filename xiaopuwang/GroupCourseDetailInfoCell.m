//
//  GroupCourseDetailInfoCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseDetailInfoCell.h"

@implementation GroupCourseDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)detailItem{
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[detailItem getString:@"OrgLogo"]]] placeholderImage:nil];
    [self.orgLogo.layer setCornerRadius:12.5];
    [self.orgLogo.layer setMasksToBounds:YES];
    
    self.orgName.text = [detailItem getString:@"OrgName"];
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[[detailItem getString:@"FightCourseIntroduction"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    self.courseInfo.attributedText = attrStr;
}

-(IBAction)seeMoreInfoAction:(id)sender{
    [self.delegate groupCourseMoreInfoDelegate:sender];
}

-(IBAction)goToOrgAction:(id)sender{
    [self.delegate groupCourseToOrgDelegate:sender];
}
@end
