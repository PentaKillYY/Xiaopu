//
//  OrginizationTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationTableViewCell.h"

@implementation OrginizationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self bingdingViewModel];
    
    self.sepH.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

-(void)bingdingViewModel{
    [self setupTagView];
}

- (void)setupTagView
{
    
    //Add Tags
    [@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C", @"C", @"PHP"] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:text];
        tag.textColor = [UIColor grayColor];
        tag.cornerRadius = 3;
        tag.fontSize = 11;
        tag.borderColor = [UIColor grayColor];
        tag.borderWidth = 0.5;
        tag.padding = UIEdgeInsetsMake(2, 2, 2, 2);
        [self.orgClassView addTag:tag];
    }];
    self.orgClassView.preferredMaxLayoutWidth = Main_Screen_Width-111;

    self.orgClassView.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    self.orgClassView.interitemSpacing = 3;
    self.orgClassView.lineSpacing = 3;
    
    CGFloat tagHeight = self.orgClassView.intrinsicContentSize.height;
    self.tagH.constant =tagHeight;
    self.leftTag.backgroundColor = MAINCOLOR;
    self.middleTag.backgroundColor = MAINCOLOR;
    self.rightTag.backgroundColor = MAINCOLOR;
    
    [self.leftTag.layer setCornerRadius:3.0];
    [self.middleTag.layer setCornerRadius:3.0];
    [self.rightTag.layer setCornerRadius:3.0];
    
    [self.leftTag.layer setMasksToBounds:YES];
    [self.middleTag.layer setMasksToBounds:YES];
    [self.rightTag.layer setMasksToBounds:YES];
    
    StarRatingViewConfiguration *conf = [[StarRatingViewConfiguration alloc] init];
    conf.rateEnabled = NO;
    conf.starWidth = 15.0f;
    conf.fullImage = @"fullstar.png";
    conf.halfImage = @"halfstar.png";
    conf.emptyImage = @"emptystar.png";
    
    _starView.configuration = conf;
    [_starView setStarConfiguration];
    
    [_starView setRating:4.5 completion:^{
        NSLog(@"rate done");
    }];

}


@end
