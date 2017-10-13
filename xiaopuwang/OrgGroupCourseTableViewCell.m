//
//  OrgGroupCourseTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/10/12.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgGroupCourseTableViewCell.h"
static NSString *identifyCollection = @"GroupCourseCollectionViewCell";

@implementation OrgGroupCourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.grouppCourseCollectionView registerNib:[UINib nibWithNibName:identifyCollection bundle:nil] forCellWithReuseIdentifier:identifyCollection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataResult*)result{
    self.courseResult = [DataResult new];
    [self.courseResult append:result];
}

#pragma mark - colletionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.courseResult.items.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyCollection forIndexPath:indexPath];
    DataItem* item = [self.courseResult.items getItem:indexPath.row];
    [cell bingdingViewModel:item];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-24)/2, 145+(Main_Screen_Width)/2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate orgGroupCourseToDetailDelegate:indexPath.row];
}
@end
