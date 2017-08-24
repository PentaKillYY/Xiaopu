//
//  PopViewController.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/24.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopSelectDelegate <NSObject>

-(void)selectIndexDelegate:(NSInteger)index;

@end

@interface PopViewController : UIViewController

@property(nonatomic,assign)id<PopSelectDelegate>delegate;

@end

