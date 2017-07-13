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

    
    for (int i = 0; i< 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.ings.org.cn/Uploads/Organization/20170606174503715932_Logo.png"] placeholderImage:nil];
                imageView.frame = CGRectMake((imgW+2)*i, 0, imgW, imgH);
        [self.scrollView addSubview:imageView];

    }
    self.scrollView.contentSize = CGSizeMake(imgW*4, imgH);
}
@end
