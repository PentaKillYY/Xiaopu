//
//  PostCommunityImageCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PostImageCollectionViewCell.h"

@protocol AddPostCommunityDelegate <NSObject>

-(void)addImageDelegate;
-(void)deleteImageDelegate:(id)sender;

@end

@interface PostCommunityImageCell : BaseTableViewCell<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PostImageDelegate>
{
    NSMutableArray* imageArray;
}
@property(nonatomic,assign)id<AddPostCommunityDelegate>delegate;

@property(nonatomic,weak)IBOutlet UICollectionView* imageCollectionView;

-(void)bingdingViewModel:(NSArray*)array;
@end

