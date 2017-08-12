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

-(void)loginWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:Login parameters:parameters success:^(id json) {
        DataResult * result = json;
        UserInfo* info = [UserInfo sharedUserInfo];
        info.userID = result.message;
        info.telphone = [parameters objectForKey:@"loginName"];
        info.password = [parameters objectForKey:@"password"];
        [info synchronize];
        
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)postSubtidyWithPage:(NSInteger)page
                         Size:(NSInteger)size
                   Parameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld",GetSubtidyList,(long)page,(long)size] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)postSpecialistOrgWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:SpecialistOrg parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}


-(void)postSpecialistChinaSchoolWithParameters:(NSDictionary *)parameters
                                  onCompletion:(JSONResponse)completionBlock
                                     onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:SpecialistChinaSchool parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)postSpecialistOverseaSchoolWithParameters:(NSDictionary *)parameters
                                    onCompletion:(JSONResponse)completionBlock
                                       onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:SpecialistOverseaSchool parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}
@end
