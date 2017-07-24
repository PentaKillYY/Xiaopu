//
//  MainService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainService : NSObject
+ (instancetype)sharedMainService;

//获取广告位
- (void)mainGetAdvertisementWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock;
@end