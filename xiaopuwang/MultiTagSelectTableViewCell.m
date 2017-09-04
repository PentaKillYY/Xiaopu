//
//  MultiTagSelectTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/7.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MultiTagSelectTableViewCell.h"

@implementation MultiTagSelectTableViewCell

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
    config.tagBackgroundColor = TEXTFIELD_BG_COLOR;
    config.tagSelectedBackgroundColor = MAINCOLOR;
    config.tagCornerRadius = 3.0f;
    config.tagBorderWidth = 1;
    
    config.tagBorderColor = [UIColor lightGrayColor];
    config.tagSelectedBorderColor = MAINCOLOR;
    config.tagShadowColor = [UIColor clearColor];
    config.tagShadowOffset = CGSizeMake(0, 0);
    
    _tagView.manualCalculateHeight = YES;
    _tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 16;
    
    for (NSString* string in self.selectIndexAray) {
        [_tagView setTagAtIndex:[string integerValue] selected:YES];
    }
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected{
    NSString* currentIndex = [NSString stringWithFormat:@"%lu",(unsigned long)index];
    if (selected) {
        [self.selectIndexAray addObject:currentIndex];
    }else{
        [self.selectIndexAray removeObject:currentIndex];
    }
    
    
    
    [self.deletage selectTextTag:self.selectIndexAray];
}


@end
