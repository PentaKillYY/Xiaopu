//
//  EKZCustomHud.m
//  Ekuaizhi_Base
//
//  Created by apple on 15/12/23.
//  Copyright (c) 2015年 Ekuaizhi. All rights reserved.
//

#import "AppCustomHud.h"
#import "AppDelegate.h"
@implementation AppCustomHud

+ (instancetype)sharedEKZCustomHud{
    static AppCustomHud *sharedEKZCustomHud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedEKZCustomHud=[[AppCustomHud alloc]init];
    });
    return sharedEKZCustomHud;
}

- (void)showTextHud:(NSString*)messageText{
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = messageText;
    [hud hideAnimated:YES afterDelay:2];
}
@end
