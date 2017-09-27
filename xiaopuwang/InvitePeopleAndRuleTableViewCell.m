//
//  InvitePeopleAndRuleTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "InvitePeopleAndRuleTableViewCell.h"

@implementation InvitePeopleAndRuleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupSeg];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupSeg{
    [self.topSep.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.topSep.layer setBorderWidth:1.0];
    [self.topSep.layer setCornerRadius:5.0];
    [self.topSep.layer setMasksToBounds:YES];

    _segmentedControl.sectionTitles =@[@"我的邀请", @"活动规则"];
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionIndicatorEdgeInsets =UIEdgeInsetsMake(0, -10, 0,-20);
    _segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    _segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};

    [_segmentedControl setSelectedSegmentIndex:0];
}

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{

}
@end
