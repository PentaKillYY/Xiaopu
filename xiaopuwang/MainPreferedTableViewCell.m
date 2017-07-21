//
//  MainPreferedTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainPreferedTableViewCell.h"

@implementation MainPreferedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self setupUI];
}

- (void)setupUI{
    CGFloat imgW = (Main_Screen_Width-14)/3; // 图片的宽度
    CGFloat imgH = (Main_Screen_Width-14)/3; // 图片的高度
    NSMutableArray* array = [[NSMutableArray alloc] init];

    for (int i = 0; i < self.dataResult.items.size; i++) {
        DataItem* item = [self.dataResult.items getItem:i];
        
        if ([item getInt:@"AdvType"] == 2) {
            [array addObject:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"AdvImage"]]];
        }
    }
    for (int i = 0; i< array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView.layer setCornerRadius:3.0];
        [imageView.layer setMasksToBounds:YES];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:nil];
                imageView.frame = CGRectMake((imgW+2)*i, 0, imgW, imgH);
        [self.scrollView addSubview:imageView];

    }
    self.scrollView.contentSize = CGSizeMake(imgW*array.count, imgH);
}
@end
