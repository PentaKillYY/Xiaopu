//
//  GroupCourseCollectionViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/18.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseCollectionViewCell.h"

@implementation GroupCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.trainingCorner.layer setCornerRadius:12.5];
    [self.trainingCorner.layer setMasksToBounds:YES];
}

@end
