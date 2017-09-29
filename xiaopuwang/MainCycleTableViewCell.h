//
//  MainCycleTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/11.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SDCycleScrollView.h"

@protocol MainCycleDelegate <NSObject>

-(void)clickImageWithIndex:(NSString*)imageName;

@end

@interface MainCycleTableViewCell : BaseTableViewCell<SDCycleScrollViewDelegate>
@property(nonatomic,strong)IBOutlet SDCycleScrollView* cycleScrollView;
@property(nonatomic,strong)DataResult* dataresult;
@property(nonatomic,assign)id<MainCycleDelegate>delegate;
@property(nonatomic,strong)NSMutableArray* ImageNameArray;

@end

