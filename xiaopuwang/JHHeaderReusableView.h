//
//  JHHeaderReusableView.h
//  collectionView的首页
//
//  Created by 会跳舞的狮子 on 16/5/4.
//  Copyright © 2016年 会跳舞的狮子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@protocol JHHeaderDelegate <NSObject>

-(void)changeHeaderSeg:(NSInteger)valueIndex;

@end

@interface JHHeaderReusableView : UICollectionReusableView

@property(nonatomic,assign)id<JHHeaderDelegate>delegate;
@property(nonatomic,weak)IBOutlet HMSegmentedControl* segControl;
@end


