//
//  MyService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/25.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyService : NSObject
+ (instancetype)sharedMyService;

//用户登录
- (void)loginWithParameters:(NSDictionary *)parameters
               onCompletion:(JSONResponse)completionBlock
                  onFailure:(JSONResponse)failureBlock;


//通过用户UserId 查询单个用户
-(void)getUserOnlyWithParameters:(NSDictionary *)parameters
                    onCompletion:(JSONResponse)completionBlock
                       onFailure:(JSONResponse)failureBlock;


//通过用户余额
-(void)getUserBalanceWithParameters:(NSDictionary *)parameters
                    onCompletion:(JSONResponse)completionBlock
                       onFailure:(JSONResponse)failureBlock;

//更新用户头像
-(void)postUserHeadWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;
@end
