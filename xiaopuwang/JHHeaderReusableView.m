//
//  JHHeaderReusableView.m
//  collectionView的首页
//
//  Created by 会跳舞的狮子 on 16/5/4.
//  Copyright © 2016年 会跳舞的狮子. All rights reserved.
//

#import "JHHeaderReusableView.h"
@interface JHHeaderReusableView ()

{
    NSInteger currentSegIndex;
}
@end
@implementation JHHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSegUI];
}

- (void)setupSegUI{
    UserInfo* info = [UserInfo sharedUserInfo];
    self.segControl.sectionTitles = OrginizationTypeAry;
    [self.segControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.segControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin ;
    self.segControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.segControl.selectionIndicatorColor = GroupCourseRed;
       self.segControl.titleTextAttributes= @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    self.segControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.segControl.selectionIndicatorEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 20);
    
    if (info.secondSelectIndex.length) {
        if ([info.secondSelectIndex intValue]==0) {
            [self.segControl setSelectedSegmentIndex:2];
        }else if ([info.secondSelectIndex intValue]==1){
            [self.segControl setSelectedSegmentIndex:3];
        }else if ([info.secondSelectIndex intValue]==2){
            [self.segControl setSelectedSegmentIndex:4];
        }else if ([info.secondSelectIndex intValue]==3){
            [self.segControl setSelectedSegmentIndex:0];
        }else if ([info.secondSelectIndex intValue]==4){
            [self.segControl setSelectedSegmentIndex:1];
        }else{
            [self.segControl setSelectedSegmentIndex:[info.secondSelectIndex intValue]];
        }
    }else{
        [self.segControl setSelectedSegmentIndex:2];
    }
}

-(void)segmentedControlChangedValue:(HMSegmentedControl*)seg{
    currentSegIndex = seg.selectedSegmentIndex;
    [self.delegate changeHeaderSeg:currentSegIndex];
}
@end
