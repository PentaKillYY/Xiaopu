//
//  CommunityTableViewCell.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/25.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityOneLineImageCell.h"
static NSString *identifyCollection = @"CommentImageCollectionViewCell";

@implementation CommunityOneLineImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageCollectionView.backgroundColor = [UIColor whiteColor];
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:identifyCollection bundle:nil] forCellWithReuseIdentifier:identifyCollection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bingdingViewModel:(DataItem*)item{
    [self.userLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGE_URL,[item getString:@"UserPhoto"]]] placeholderImage:nil];
    [self.userLogo.layer setCornerRadius:11];
    [self.userLogo.layer setMasksToBounds:YES];
    
    self.userName.text = [item getString:@"UserName"];
    self.communityTime.text = [NSString stringWithFormat:@"%@·",[[item getString:@"CreateTime"] substringToIndex:10]];
    if ([item getString:@"UserIdentity"].length) {
        self.userType.text = [item getString:@"UserIdentity"];
    }else{
        self.userType.text = @"普通用户";
    }
    
    self.communityTitle.preferredMaxLayoutWidth = Main_Screen_Width-16;
    self.communityTitle.numberOfLines = 0;
    self.communityTitle.text = [item getString:@"Title"];
    
    self.communityContent.preferredMaxLayoutWidth = Main_Screen_Width-16;
    self.communityContent.numberOfLines = 2;
    self.communityContent.text = [item getString:@"Content"];
    
    self.praiseNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserGoodCount"]];
    self.replyNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserReplyCount"]];
    self.viewNumber.text = [NSString stringWithFormat:@"%d",[item getInt:@"CommunityUserBrowse"]];
    
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


@end
