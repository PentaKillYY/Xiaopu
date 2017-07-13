//
//  MainCycleTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainCycleTableViewCell.h"


@implementation MainCycleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self bingdingViewModel];
    // Configure the view for the selected state
}

- (void)bingdingViewModel{
    
    _cycleScrollView.delegate = self;
    _cycleScrollView.imageURLStringsGroup = @[@"http://www.ings.org.cn/Uploads/Organization/20170606174414155577_Logo.png",@"http://www.ings.org.cn/Uploads/Organization/20170606174359987157_Logo.png"];
    
    _cycleScrollView.autoScrollTimeInterval = 3.;// 自动滚动时间间隔

}
@end
