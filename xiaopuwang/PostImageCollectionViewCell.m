//
//  PostImageCollectionViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "PostImageCollectionViewCell.h"

@implementation PostImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureCellWithImage:(NSString *)imageUrl{
    [self.selectImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,imageUrl]] placeholderImage:nil];
    
}


- (IBAction)deleteImage:(id)sender{
    [self.delegate deletePostImageDelegate:sender];
}
@end
