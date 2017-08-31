//
//  CommunityTypeCollectionViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityTypeCollectionViewCell.h"

@implementation CommunityTypeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.typeTag.layer setCornerRadius:5.0];
    [self.typeTag.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.typeTag.layer setBorderWidth:0.5];
    [self.typeTag.layer setMasksToBounds:YES];
}

@end
