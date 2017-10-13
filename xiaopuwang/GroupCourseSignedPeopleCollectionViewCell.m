//
//  GroupCourseSignedPeopleCollectionViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/10/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseSignedPeopleCollectionViewCell.h"

@implementation GroupCourseSignedPeopleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.userLogoView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.userLogoView.layer setBorderWidth:0.5];
    [self.userLogoView.layer setCornerRadius: (SCREEN_WIDTH - 90)/16];
    [self.userLogoView.layer setMasksToBounds:YES];
    
}

-(void)bingdingViewModel:(DataItem*)item{
    self.userName.text = [item getString:@"UserName"].length>2?[NSString stringWithFormat:@"%@*",[[item getString:@"UserName"] substringToIndex:1]]: [item getString:@"UserName"];
    [self.userLogoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"UserPhoto"]]] placeholderImage:V_IMAGE(@"UserDefaultLogo")];
}

@end
