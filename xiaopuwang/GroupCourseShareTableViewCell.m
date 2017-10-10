//
//  GroupCourseShareTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseShareTableViewCell.h"
static NSString *identifyCollection = @"GroupCourseSignedPeople";

@implementation GroupCourseShareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contactBotton.layer setCornerRadius:5.0];
    [self.contactBotton.layer setMasksToBounds:YES];
    
    [self.shareButton.layer setCornerRadius:5.0];
    [self.shareButton.layer setMasksToBounds:YES];
    
    [self.peopleCollectionView registerNib:[UINib nibWithNibName:@"GroupCourseSignedPeopleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifyCollection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
//    self.remainPeopleLabel.text = [NSString stringWithFormat:@"仅剩%d个名额，快邀请好友来参团吧",[item getInt:@"FightCoursePeopleCount"]-[item getInt:@"FightCourseIsSignPeopleCount"]];
}

-(IBAction)contactOrgAction:(id)sender{
    [self.delegate contactOrgDelegate:sender];
}

-(IBAction)shareOrgAction:(id)sender{
    [self.delegate shareOrgDelegate:sender];
}

#pragma mark - colletionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 11;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GroupCourseSignedPeopleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyCollection forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = SCREEN_WIDTH - 90;
    return CGSizeMake(width / 8, width / 8+19);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

@end
