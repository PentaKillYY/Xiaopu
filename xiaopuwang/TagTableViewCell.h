//
//  TagTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>
@protocol TextTagDelegate <NSObject>

-(void)selectTextTag:(NSArray*)tagArray TagType:(NSString*)tagtype;

@end

@interface TagTableViewCell : BaseTableViewCell<TTGTextTagCollectionViewDelegate>

@property(nonatomic,weak)IBOutlet UILabel* tagType;
@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *tagView;

@property(nonatomic,strong)NSMutableArray* selectIndexAray;
@property(nonatomic,assign)id<TextTagDelegate>deletage;

- (void)setTags:(NSArray <NSString *> *)tags;

- (void)resetAllTag;

@end

