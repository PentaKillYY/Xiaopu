//
//  FixAlertView.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/29.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "FixAlertView.h"

@implementation FixAlertView
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    UITextField *txtName = [self textFieldAtIndex:0];
    if (txtName.text.length) {
        [super dismissWithClickedButtonIndex:buttonIndex animated:animated]; // 消失
    }else{
        return;
    }
}

@end
