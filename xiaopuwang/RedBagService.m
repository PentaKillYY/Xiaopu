//
//  RedBagService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/27.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "RedBagService.h"

@implementation RedBagService
+ (instancetype)sharedRedBagService{
    static RedBagService *sharedRedBagService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRedBagService=[[RedBagService alloc]init];
    });
    return sharedRedBagService;
}

-(void)getRedBagByContactWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@&organization_Application_ID=%@",RedBagByContact,[parameters objectForKey:@"userId"],[parameters objectForKey:@"organization_Application_ID"]]  parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}


-(void)getRedBagByConfirmOrderWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@&organization_Application_ID=%@",RedBagByConfirmOrder,[parameters objectForKey:@"userId"],[parameters objectForKey:@"organization_Application_ID"]] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserRedBagListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:RedBagList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)updateRedBagStateWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:UpdateRedBagState parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserRedBagInfoWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetUserRedBagInfo parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}
@end
