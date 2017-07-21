//
//  MainService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MainService.h"

@implementation MainService
+ (instancetype)sharedMainService{
    static MainService *sharedMainService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMainService=[[MainService alloc]init];
    });
    return sharedMainService;
}

- (void)mainGetAdvertisementWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock{
    
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetAdvertisement parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}
@end
