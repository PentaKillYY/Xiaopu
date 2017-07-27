//
//  OrgPhotoBrowserViewController.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/27.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrgPhotoBrowserViewController.h"
#import "ImageCollectionViewCell.h"
#import "SRPictureBrowser.h"
#import "SRPictureModel.h"
@interface OrgPhotoBrowserViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SRPictureBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *imageViewFrames;
@property(nonatomic,weak)IBOutlet UICollectionView* collctionView;
@end

@implementation OrgPhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"机构相册";

    [self.collctionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];

    DLog(@"%@",_AlbumResult);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)imageViewFrames {
    
    if (!_imageViewFrames) {
        _imageViewFrames = [NSMutableArray array];
    }
    return _imageViewFrames;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _AlbumResult.items.size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Main_Screen_Width-50)/4, (Main_Screen_Width-50)/4);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    DataItem* item = [_AlbumResult.items getItem:indexPath.row];
    
    [cell.orgImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"PhotoURL"]]] placeholderImage:nil];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
    cell.orgImage.tag = indexPath.row;
    [cell.orgImage addGestureRecognizer:tapGestureRecognizer];
    [self.imageViewFrames addObject:[NSValue valueWithCGRect:cell.orgImage.frame]];

    return cell;
}

- (void)imageTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    UIImageView *tapedImageView = (UIImageView *)tapGestureRecognizer.view;
    NSMutableArray *imageBrowserModels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < _AlbumResult.items.size; i ++) {
         DataItem* item = [_AlbumResult.items getItem:i];
        SRPictureModel *imageBrowserModel = [SRPictureModel sr_pictureModelWithPicURLString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[item getString:@"PhotoURL"]]
                                                                              containerView:tapedImageView.superview
                                                                        positionInContainer:[self.imageViewFrames[i] CGRectValue]
                                                                                      index:i];
        [imageBrowserModels addObject:imageBrowserModel];
    }
    [SRPictureBrowser sr_showPictureBrowserWithModels:imageBrowserModels currentIndex:tapedImageView.tag delegate:self];
}

- (void)pictureBrowserDidShow:(SRPictureBrowser *)pictureBrowser {
    
    NSLog(@"%s", __func__);
}

- (void)pictureBrowserDidDismiss {
    
    NSLog(@"%s", __func__);
}

@end
