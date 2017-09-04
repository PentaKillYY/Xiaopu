//
//  PostImageCollectionViewCell.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/30.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PostImageDelegate <NSObject>

-(void)deletePostImageDelegate:(id)sender;

@end

@interface PostImageCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView* selectImage;
@property(nonatomic,weak)IBOutlet UIButton* deleteButton;
@property(nonatomic,assign)id<PostImageDelegate>delegate;

- (void)configureCellWithImage:(NSString *)imageUrl;
- (IBAction)deleteImage:(id)sender;
@end

