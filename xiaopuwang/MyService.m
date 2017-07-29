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
        DataResult* result = json;
        UserInfo* info = [UserInfo sharedUserInfo];
        
        
        NSString* UserBase64Image = [result.detailinfo getString:@"UserImage"];
        NSRange range = [UserBase64Image rangeOfString:@"base64,"];
        NSInteger location = range.location;
        NSInteger leight = range.length;
        UserBase64Image = [UserBase64Image substringFromIndex:location+leight];
        
        info.headPicUrl = UserBase64Image;
        info.telphone = [result.detailinfo getString:@"Phone"];
        
        [info synchronize];

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

-(void)getTokenWithParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetToken parameters:parameters success:^(id json) {
        DataResult* result = json;
        
        UserInfo* info = [UserInfo sharedUserInfo];
        info.token = [result.detailinfo getString:@"token"];
        [info synchronize];
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)getUserBasicInfoWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetUserBasicInfo parameters:parameters success:^(id json) {
        DataResult* result = json;
        
        UserInfo* info = [UserInfo sharedUserInfo];
        info.username = [result.detailinfo getString:@"User_name"];
        [info synchronize];

        
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)getUserBargainWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:UserBargain parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)sendMessageAfterBargainWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:SendMessageAfterBargain parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}
@end
