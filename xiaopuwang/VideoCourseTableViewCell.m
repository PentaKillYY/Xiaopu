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
        [self.oneButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:0] getString:@"VideoPictureUrl"]]] forState:0];
        self.oneButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.oneButton.imageView.clipsToBounds = YES;
        
        self.twoLabel.text = [[result.items getItem:1] getString:@"VideoName"];
        [self.twoButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:1] getString:@"VideoPictureUrl"]]] forState:0];
        self.twoButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.twoButton.imageView.clipsToBounds = YES;
        
        self.threeLabel.text = [[result.items getItem:2] getString:@"VideoName"];
        [self.threeButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:2] getString:@"VideoPictureUrl"]]] forState:0];
        self.threeButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.threeButton.imageView.clipsToBounds = YES;
        
        self.fourLabel.text = [[result.items getItem:3] getString:@"VideoName"];
        [self.fourButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[result.items getItem:3] getString:@"VideoPictureUrl"]]] forState:0];
        self.fourButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.fourButton.imageView.clipsToBounds = YES;
        
        CGFloat imgW = (Main_Screen_Width-12-8-12)/2;
        CGFloat imgH = imgW/326*200;
        
        UIBlurEffect *oneblur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView*oneeffectview = [[UIVisualEffectView alloc] initWithEffect:oneblur];
        oneeffectview.frame = CGRectMake(0, 0, imgW,imgH);
        oneeffectview.alpha = 0.7f;
        
        [self.oneButton addSubview:oneeffectview];
        
        UIBlurEffect *twoblur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView*twoeffectview = [[UIVisualEffectView alloc] initWithEffect:twoblur];
        twoeffectview.frame = CGRectMake(0, 0, imgW,imgH);
        twoeffectview.alpha = 0.7f;
        [self.twoButton addSubview:twoeffectview];
        
        UIBlurEffect *threeblur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView*threeffectview = [[UIVisualEffectView alloc] initWithEffect:threeblur];
        threeffectview.frame = CGRectMake(0, 0, imgW,imgH);
        threeffectview.alpha = 0.7f;
        [self.threeButton addSubview:threeffectview];
        
        UIBlurEffect *fourblur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView*foureffectview = [[UIVisualEffectView alloc] initWithEffect:fourblur];
        foureffectview.frame = CGRectMake(0, 0, imgW,imgH);
        foureffectview.alpha = 0.7f;
        [self.fourButton addSubview:foureffectview];
        
    }
    
}

-(IBAction)selectViedeoAction:(id)sender{
    [self.delegate selectVideoDelegate:sender];
}
@end
