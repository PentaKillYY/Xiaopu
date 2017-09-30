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
    NSMutableArray* array = [[NSMutableArray alloc] init];
    self.ImageNameArray = [NSMutableArray new];
    for (int i = 0; i < self.dataresult.items.size; i++) {
        DataItem* item = [self.dataresult.items getItem:i];
        
        if ([item getInt:@"AdvType"] == 1 ) {
            [array addObject:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"AdvImage"]]];
            [self.ImageNameArray addObject:[item getString:@"AdvName"]];
        }
    }
    _cycleScrollView.imageURLStringsGroup = array;
    
    _cycleScrollView.autoScrollTimeInterval = 3.;// 自动滚动时间间隔

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self.delegate clickImageWithIndex:[self.dataresult.items getItem:index]];
}
@end
