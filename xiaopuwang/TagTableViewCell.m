//
//  TagTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "TagTableViewCell.h"

@implementation TagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectIndexAray = [[NSMutableArray alloc] init];
    _tagView.delegate = self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTags:(NSArray<NSString *> *)tags {
    [_tagView removeAllTags];
    [_tagView addTags:tags];
    
    
    // Style2
    TTGTextTagConfig *config = _tagView.defaultConfig;
    
    config.tagTextFont = [UIFont systemFontOfSize:12.0f];
    config.tagTextColor = [UIColor lightGrayColor];
    config.tagSelectedTextColor = [UIColor whiteColor];
    config.tagBackgroundColor = [UIColor whiteColor];
    config.tagSelectedBackgroundColor = MAINCOLOR;
    config.tagCornerRadius = 3.0f;
    config.tagBorderWidth = 1;
    
    config.tagBorderColor = [UIColor lightGrayColor];
    config.tagSelectedBorderColor = MAINCOLOR;
    config.tagShadowColor = [UIColor clearColor];
    config.tagShadowOffset = CGSizeMake(0, 0);

    _tagView.manualCalculateHeight = YES;
    _tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 16;
    
    if (self.selectIndexAray.count == 0) {
        [_tagView setTagAtIndex:0 selected:YES];
    }
    
    for (NSString* string in self.selectIndexAray) {
        [_tagView setTagAtIndex:[string integerValue] selected:YES];
    }
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected{
    NSString* currentIndex = [NSString stringWithFormat:@"%lu",(unsigned long)index];
    for (int i = 0; i < textTagCollectionView.allTags.count; i++) {
        if (i ==  index) {
           [textTagCollectionView setTagAtIndex:i selected:YES];
        }else{
            [textTagCollectionView setTagAtIndex:i selected:NO];
        }
    }
    
        [self.selectIndexAray removeAllObjects];
        [self.selectIndexAray addObject:currentIndex];
   
//    if (currentIndex == 0) {
//        [self.deletage selectTextTag:nil TagType:self.tagType.text];
//    }else{
//        [self.deletage selectTextTag:self.selectIndexAray TagType:self.tagType.text];
//    }
    
    [self.deletage selectTextTag:self.selectIndexAray TagType:self.tagType.text];
}


-(void)resetAllTag{
  [self.selectIndexAray removeAllObjects];
}
@end
