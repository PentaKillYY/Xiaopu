//
//  PostCommunityImageCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "PostCommunityImageCell.h"

@implementation PostCommunityImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(104, 104);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 2;
    
    imageArray = [[NSMutableArray alloc] init];
    
    self.imageCollectionView.collectionViewLayout = layout;
    
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.scrollsToTop = NO;
    self.imageCollectionView.showsVerticalScrollIndicator = NO;
    self.imageCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"PostImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"kPostImageCollectionCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(NSArray*)array{
    [imageArray addObjectsFromArray:array];
    [self.imageCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (imageArray.count == 9) {
        return 9;
    }else{
        return imageArray.count+1;
    }
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"kPostImageCollectionCell" forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    PostImageCollectionViewCell* collectionCell = (PostImageCollectionViewCell*)cell;
    collectionCell.deleteButton.tag = indexPath.row;
    collectionCell.delegate = self;
    if (imageArray.count == 9) {
        collectionCell.deleteButton.hidden=NO;
        [collectionCell configureCellWithImage:imageArray[indexPath.row]];

    }else{
        if (indexPath.row == imageArray.count) {
            collectionCell.deleteButton.hidden=YES;
            collectionCell.selectImage.image = V_IMAGE(@"add-pic");
        }else{
            collectionCell.deleteButton.hidden=NO;
            [collectionCell configureCellWithImage:imageArray[indexPath.row]];
        }
    }
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate addImageDelegate];
}

-(void)deletePostImageDelegate:(id)sender{
    UIButton* button = (UIButton*)sender;
    [imageArray removeObjectAtIndex:button.tag];
    [self.delegate deleteImageDelegate:sender];
    [self.imageCollectionView reloadData];
}


@end
