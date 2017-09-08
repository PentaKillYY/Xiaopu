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
    self.AlbumResult = [[DataResult alloc] init];
    [self .AlbumResult append:dataresult];

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
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        if (albumType) {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView*effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            effectview.frame = CGRectMake(0, 0, imgW+2,imgH+2);
            effectview.alpha = 0.7f;
            
            [imageView addSubview:effectview];
        }
        
        [self.imageViewFrames addObject:[NSValue valueWithCGRect:imageView.frame]];

        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imageView addGestureRecognizer:tap];
        tap.view.tag = albumType*10 +i;

        [self.contentScroll addSubview:imageView];
        
        if (albumType !=0) {
            UIImageView* playLogo = [[UIImageView alloc] initWithFrame:CGRectMake((imgW+2)*i+imgW/2-15, imgH/2-15, 30, 30)];
            
            [playLogo setImage:V_IMAGE(@"play")];
            
            [self.contentScroll addSubview:playLogo];
        }
        
    }
    self.contentScroll.contentSize = CGSizeMake(imgW*scrollCount, 0);
}

-(void)tapImage:(id)sender{
    
    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    
    UIImageView *tapedImageView = (UIImageView *)tap.view;
    if (tapedImageView.tag <10) {
        NSMutableArray *imageBrowserModels = [[NSMutableArray alloc] init];
        NSInteger albumNumber;
        
        if (self .AlbumResult.items.size>4) {
            albumNumber = 4;
        }else{
            albumNumber = self .AlbumResult.items.size;
        }
        for (NSInteger i = 0; i < albumNumber; i ++) {
            DataItem* item = [self .AlbumResult.items getItem:i];
            SRPictureModel *imageBrowserModel = [SRPictureModel sr_pictureModelWithPicURLString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"PhotoURL"]]
                                                                                  containerView:tapedImageView.superview
                                                                            positionInContainer:[self.imageViewFrames[i] CGRectValue]
                                                                                          index:i];
            [imageBrowserModels addObject:imageBrowserModel];
        }
        [SRPictureBrowser sr_showPictureBrowserWithModels:imageBrowserModels currentIndex:tapedImageView.tag delegate:self];

    }
    
    
    [self.delegate albumClickDelegate:sender];
}

@end
