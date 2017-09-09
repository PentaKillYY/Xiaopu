//
//  OrgAlbumVideoTableViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SRPictureBrowser.h"
#import "SRPictureModel.h"

@protocol AlbumVideoDelegate <NSObject>

-(void)albumClickDelegate:(id)sender;

@end

@interface OrgAlbumVideoTableViewCell : BaseTableViewCell<SRPictureBrowserDelegate>
@property(nonatomic,weak)IBOutlet UILabel* orgTitle;
@property(nonatomic,weak)IBOutlet UIScrollView* contentScroll;
@property(nonatomic,assign)id<AlbumVideoDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *imageViewFrames;
@property(nonatomic,strong)DataResult *AlbumResult;

- (void)setupUI:(DataResult*)dataresult Type:(NSInteger)albumType;

@end

