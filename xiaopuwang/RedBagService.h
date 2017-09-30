//
//  RedBagService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/27.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedBagService : NSObject
+ (instancetype)sharedRedBagService;

//用户咨询得红包
-(void)getRedBagByContactWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//用户下单得红包
-(void)getRedBagByConfirmOrderWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock;

//获取用户现金红包
-(void)getUserRedBagListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//更新用户现金红包状态
-(void)updateRedBagStateWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//获取用户邀请人和总的红包面值
-(void)getUserRedBagInfoWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;
@end
