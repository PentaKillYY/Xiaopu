//
//  OrginizationService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationService.h"

@implementation OrginizationService
+ (instancetype)sharedOrginizationService{
    static OrginizationService *sharedOrginizationService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOrginizationService=[[OrginizationService alloc]init];
    });
    return sharedOrginizationService;
}

-(void)postGetOrginfoWithPage:(NSInteger)page
                        Size:(NSInteger)size
                  Parameters:(NSDictionary *)parameters
                onCompletion:(JSONResponse)completionBlock
                   onFailure:(JSONResponse)failureBlock{
    
    
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?pageIndex=%d&pageSize=%d",GetOrginfo,page,size]  parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}
@end
