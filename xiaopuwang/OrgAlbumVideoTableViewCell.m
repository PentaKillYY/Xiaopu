//
//  OrgAlbumVideoTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgAlbumVideoTableViewCell.h"

@implementation OrgAlbumVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupUI:(DataResult*)dataresult Type:(NSInteger)albumType{
    CGFloat imgW = (Main_Screen_Width-14)/3; // 图片的宽度
    CGFloat imgH = (Main_Screen_Width-14)/3; // 图片的高度
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    
    if (albumType ==0 ) {
        //相册
        for (int i = 0; i < dataresult.items.size; i++) {
            [array addObject:[[dataresult.items getItem:i] getString:@"PhotoURL"]];
        }
        
    }else if (albumType == 1){
        //视频
        
        DataItemArray* itemArray =  [dataresult.detailinfo getDataItemArray:@"videoList"];
        
        for (int i = 0; i <itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            if ([item getInt:@"VideoType"] == 0) {
                [array addObject:[item getString:@"VideoPictureUrl"]];
            }
        }

    }else{
        //在线试听
        
        DataItemArray* itemArray =  [dataresult.detailinfo getDataItemArray:@"videoList"];
        
        for (int i = 0; i <itemArray.size; i++) {
            DataItem* item = [itemArray getItem:i];
            if ([item getInt:@"VideoType"] != 0) {
                [array addObject:[item getString:@"VideoPictureUrl"]];
            }
        }

    }
    
    NSInteger scrollCount = 0;
    if (array.count >4) {
        scrollCount = 4;
    }else{
        scrollCount = array.count;
    }
    
    for (int i = 0; i< scrollCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView.layer setCornerRadius:3.0];
        [imageView.layer setMasksToBounds:YES];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,array[i]] ] placeholderImage:nil];
        imageView.frame = CGRectMake((imgW+2)*i, 0, imgW, imgH);
        [self.contentScroll addSubview:imageView];
        
    }
    self.contentScroll.contentSize = CGSizeMake(imgW*array.count, imgH);
}

@end
