//
//  MyService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/25.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "MyService.h"

@implementation MyService
+ (instancetype)sharedMyService{
    static MyService *sharedMyService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyService=[[MyService alloc]init];
    });
    return sharedMyService;
}

- (void)loginWithParameters:(NSDictionary *)parameters
               onCompletion:(JSONResponse)completionBlock
                  onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:Login parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];

}

-(void)getUserOnlyWithParameters:(NSDictionary *)parameters
                    onCompletion:(JSONResponse)completionBlock
                       onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetUserOnly parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];

}

-(void)getUserBalanceWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:UserBalance parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)postUserHeadWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:UpdateUserHead parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}
@end
