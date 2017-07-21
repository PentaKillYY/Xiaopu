//
//  OrginizationService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrginizationService : NSObject
+ (instancetype)sharedOrginizationService;

//获取机构列表（分页）
-(void)postGetOrginfoWithPage:(NSInteger)page
                        Size:(NSInteger)size
                  Parameters:(NSDictionary *)parameters
                onCompletion:(JSONResponse)completionBlock
                   onFailure:(JSONResponse)failureBlock;
@end
