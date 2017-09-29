//
//  UserConfirmOrderViewController.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/15.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "BaseViewController.h"

@interface UserConfirmOrderViewController : BaseViewController
@property(nonatomic,weak)NSString* orderNumber;
@property(nonatomic,weak)NSString* isAll;
@property(nonatomic,strong)NSDictionary* redBagDic;
@end
