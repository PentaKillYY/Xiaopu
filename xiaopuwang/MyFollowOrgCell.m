//
//  MyFollowOrgCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/10.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyFollowOrgCell.h"

@implementation MyFollowOrgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdinViewModel:(DataItem*)item{
    [self setupTagView];
    
    
    [self.logoView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"Logo"]] ] placeholderImage:nil];
    
    self.orgContent.text = [item getString:@"TeachCourses"];
    self.orgContent.preferredMaxLayoutWidth = Main_Screen_Width-104;
    
    
    self.orgName.text = [item getString:@"ChineseName"];
    
    
    self.distance.text = [NSString stringWithFormat:@"%@-%@-%@",[item getString:@"Area"],[item getString:@"City"],[item getString:@"Field"]];

}

- (void)setupTagView
{
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
