//
//  CommunityDetailCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityDetailCell.h"
static NSString *identifyCollection = @"CommentImageCollectionViewCell";

@implementation CommunityDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    [self.userLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"UserPhoto"]]] placeholderImage:nil];
    [self.userLogo.layer setCornerRadius:12];
    [self.userLogo.layer setMasksToBounds:YES];
    
    if ([item getInt:@"IsUserGood"]==0) {
        self.praiseButton.selected = NO;
    }else{
        self.praiseButton.selected = YES;
    }
    
    self.userName.text = [item getString:@"UserName"];
    self.communityTime.text = [NSString stringWithFormat:@"%@",[[item getString:@"CreateTime"] substringToIndex:10]];
    if ([item getString:@"UserIdentity"].length) {
        self.userType.text = [item getString:@"UserIdentity"];
    }else{
        self.userType.text = @"普通用户";
    }
    
    self.communityTitle.preferredMaxLayoutWidth = Main_Screen_Width-16;
    self.communityTitle.numberOfLines = 0;
    self.communityTitle.text = [item getString:@"Title"];
    
    self.communityContent.preferredMaxLayoutWidth = Main_Screen_Width-16;
    self.communityContent.numberOfLines = 0;
    self.communityContent.text = [item getString:@"Content"];
    
    if ([item getInt:@"CommunityUserGoodCount"]>0) {
        self.praiseNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserGoodCount"]];
    }else{
        self.praiseNumber.text = @"0";
    }
    
    if ([item getInt:@"CommunityUserReplyCount"]>0) {
       self.replyNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserReplyCount"]];
    }else{
        self.replyNumber.text = @"0";
    }
    
    if ([item getInt:@"CommunityUserBrowse"]>0) {
        self.viewNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserBrowse"]];
    }else{
        self.viewNumber.text =  @"0";
    }
    
    self.address.text = [item getString:@"Address"];
}

#pragma mark - colletionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *imageStr = self.imageDatas[indexPath.item];
    CommentImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifyCollection forIndexPath:indexPath];
    __weak typeof(cell)weakCell = cell;
    [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,imageStr]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (cacheType == SDImageCacheTypeNone && image) {
            weakCell.mainImageView.alpha = 0;
            [UIView animateWithDuration:0.8 animations:^{
                weakCell.mainImageView.alpha = 1.0f;
            }];
        }
        else
        {
            weakCell.mainImageView.alpha = 1.0f;
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = SCREEN_WIDTH - 64 - 20;
    if (![NSArray isEmpty:self.imageDatas])
    {
        return CGSizeMake(width / 3, width / 3);
    }
    return CGSizeZero;
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

-(IBAction)deleteCommunityAction:(id)sender{
    [self.delegate deleteCommunityDelegate:sender];
}

-(IBAction)praiseCommunityAction:(id)sender{
    UIButton* button = (UIButton*)sender;
    if (!button.selected) {
        [self.delegate praiseCommunityDelegate:sender];
    }
}
@end
