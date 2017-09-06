//
//  VideoCourseTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/4.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "VideoCourseTableViewCell.h"

@implementation VideoCourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataResult*)result{
    if (result) {
        self.oneLabel.text = [[result.items getItem:0] getString:@"VideoName"];
        [self.oneBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:0] getString:@"VideoPictureUrl"]]]  placeholderImage:nil];
        [self.oneBG.layer setCornerRadius:2.0];
        
        self.twoLabel.text = [[result.items getItem:1] getString:@"VideoName"];
        [self.twoBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:1] getString:@"VideoPictureUrl"]]]  placeholderImage:nil];
        [self.twoBG.layer setCornerRadius:2.0];
        self.threeLabel.text = [[result.items getItem:2] getString:@"VideoName"];
        [self.threeBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:2] getString:@"VideoPictureUrl"]]]  placeholderImage:nil];
        [self.threeBG.layer setCornerRadius:2.0];
        self.fourLabel.text = [[result.items getItem:3] getString:@"VideoName"];
        [self.fourBG sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:3] getString:@"VideoPictureUrl"]]]  placeholderImage:nil];
        [self.fourBG.layer setCornerRadius:2.0];
    }
    
}

-(IBAction)selectViedeoAction:(id)sender{
    [self.delegate selectVideoDelegate:sender];
}
@end
