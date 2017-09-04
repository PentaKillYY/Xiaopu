//
//  OrgEvaluateTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgEvaluateTableViewCell.h"

@implementation OrgEvaluateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.nameLabel.text = [item getString:@"UserName"];
    self.relyContent.text = [item getString:@"Reply_Content"];
    
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"UserImage"]]] placeholderImage:nil];
    
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
