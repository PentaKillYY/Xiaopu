//
//  MultiTagSelectTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/7.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>
@protocol TextTagDelegate <NSObject>

-(void)selectTextTag:(NSArray*)tagArray;

@end

@interface MultiTagSelectTableViewCell : BaseTableViewCell<TTGTextTagCollectionViewDelegate>
@property (weak, nonatomic) IBOutlet TTGTextTagCollectionView *tagView;
@property(nonatomic,strong)NSMutableArray* selectIndexAray;
@property(nonatomic,assign)id<TextTagDelegate>deletage;

- (void)setTags:(NSArray <NSString *> *)tags;
@end
