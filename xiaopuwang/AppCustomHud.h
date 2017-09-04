//
//  EKZCustomHud.h
//  Ekuaizhi_Base
//
//  Created by apple on 15/12/23.
//  Copyright (c) 2015年 Ekuaizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface AppCustomHud : NSObject

+ (instancetype)sharedEKZCustomHud;
- (void)showTextHud:(NSString*)messageText;

@end
