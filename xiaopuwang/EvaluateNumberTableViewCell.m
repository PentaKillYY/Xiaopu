//
//  EvaluateNumberTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/16.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "EvaluateNumberTableViewCell.h"

@implementation EvaluateNumberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUpUI];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUpUI{
    DLStarRatingControl *customNumberOfStars = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(77.5, 10, 125, 44)];
    customNumberOfStars.backgroundColor = [UIColor clearColor];
    [customNumberOfStars setStar:[UIImage imageNamed:@"star.png"] highlightedStar:[UIImage imageNamed:@"star_highlighted.png"] atIndex:0];
    [customNumberOfStars setStar:[UIImage imageNamed:@"star.png"] highlightedStar:[UIImage imageNamed:@"star_highlighted.png"] atIndex:1];
    [customNumberOfStars setStar:[UIImage imageNamed:@"star.png"] highlightedStar:[UIImage imageNamed:@"star_highlighted.png"] atIndex:2];
    [customNumberOfStars setStar:[UIImage imageNamed:@"star.png"] highlightedStar:[UIImage imageNamed:@"star_highlighted.png"] atIndex:3];
    [customNumberOfStars setStar:[UIImage imageNamed:@"star.png"] highlightedStar:[UIImage imageNamed:@"star_highlighted.png"] atIndex:4];
    
    customNumberOfStars.delegate = self;
    customNumberOfStars.backgroundColor = [UIColor clearColor];
    customNumberOfStars.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    customNumberOfStars.rating = 0.0;
    self.rateText.text = @"";
    [self.contentView addSubview:customNumberOfStars];
}

#pragma mark - DLStarRatingDelegate
- (void)newRating:(DLStarRatingControl *)control :(float)rating {
    rate = rating;
    if (rate==5.0) {
        self.rateText.text = @"非常好";
    }else if (rate==4.0){
        self.rateText.text = @"好";
    }else if (rate==3.0){
        self.rateText.text = @"一般";
    }else if (rate==2.0){
        self.rateText.text = @"差";
    }else if (rate==1.0){
        self.rateText.text = @"非常差";
    }else{
        self.rateText.text = @"";
    }
    
    [self.delegate evaluateNumberChange:[NSString stringWithFormat:@"%d",(int)rate]];
    
}
@end
