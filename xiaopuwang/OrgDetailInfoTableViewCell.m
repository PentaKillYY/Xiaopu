//
//  OrgDetailInfoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgDetailInfoTableViewCell.h"

@implementation OrgDetailInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    self.orgName.text = [item getString:@"OrganizationName"];
    [self.orgLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"Logo"]]] placeholderImage:nil];
    self.viewCount.text = [NSString stringWithFormat:@"%d",arc4random()%500];
    self.focusCount.text =[NSString stringWithFormat:@"%d",arc4random()%500];
}

-(void)bingdingImageModel:(DataItemArray*)itemArray{
    _cycleScrollView.delegate = self;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSInteger cycleImageCount = itemArray.size>4?4:itemArray.size;
    
    for (int i = 0; i < cycleImageCount; i++) {
        DataItem* item = [itemArray getItem:i];
        
        [array addObject: [NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"PhotoURL"]] ];
    }
    _cycleScrollView.imageURLStringsGroup = array;
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 3.;// 自动滚动时间间隔
}

-(IBAction)clickMoreInfoAction:(id)sender{
    [self.delegate showMoreInfo:sender];
}
@end
