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
        
        info.headPicUrl = [result.detailinfo getString:@"UserImage"];
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

-(void)GetUserAdscriptionWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetUserAdscription parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)uploadFileInfoWithImage:(UIImage*)image
                    Parameters:(NSString *)imageName
                  onCompletion:(JSONResponse)completionBlock
                     onFailure:(JSONResponse)failureBlock{
    AFHTTPSessionManager* operationManager = [AFHTTPSessionManager manager];
    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    operationManager.requestSerializer.timeoutInterval = 15.0f;
    
    
    [operationManager POST:[NSString stringWithFormat:@"%@%@",REQUEST_URL,UpLoadFileInfo] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData* data = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@.png",imageName] mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        DataResult* result = [DataResult new];
        [result appendDictionary:responseDict];
        
        completionBlock(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)getUserFocusOrgWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@",GetUserFocusOrg,[parameters objectForKey:@"userId"]]  parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}


-(void)getUserFocusSchoolWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@",GetUserFocusSchool,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)getSpecialistOrgWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@",GetSpecialistOrg,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)getSpecialistChinaSchoolWithParameters:(NSDictionary *)parameters
                                 onCompletion:(JSONResponse)completionBlock
                                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@",GetSpecialstChinaSchool,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)getSpecialistOverseaSchoolWithParameters:(NSDictionary *)parameters
                                   onCompletion:(JSONResponse)completionBlock
                                      onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@",GetSpecialistOverseaSchool,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}
@end
