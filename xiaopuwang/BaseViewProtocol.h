//
//  YDViewProtocol.h
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewModelProtocol;

@protocol BaseViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;

- (void)yd_bindViewModel;
- (void)yd_setupViews;
- (void)yd_addReturnKeyBoard;

@end

