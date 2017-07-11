//
//  YDViewModel.m
//  YiDing
//
//  Created by 王隆帅 on 16/3/21.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

@synthesize request  = _request;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    BaseViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel yd_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (CMRequest *)request {
    
    if (!_request) {
        
        _request = [CMRequest request];
    }
    return _request;
}

- (void)yd_initialize {}


@end
