//
//  CMRequest.m
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/21.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

#import "BaseHttpRequest.h"

@implementation BaseHttpRequest

+ (instancetype)sharedBaseHttpRequest{
    static BaseHttpRequest *sharedBaseHttpRequest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBaseHttpRequest=[[BaseHttpRequest alloc]init];
    });
    return sharedBaseHttpRequest;
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(JSONResponse)success
    failure:(JSONResponse)failure {
    
    
    DLog(@"%@,%@",[NSString stringWithFormat:@"%@%@",REQUEST_URL,URLString],parameters);
    
    self.operationManager = [AFHTTPSessionManager manager];
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.operationManager.requestSerializer.timeoutInterval = 15.0f;
    
    
    
    [self.operationManager GET:[NSString stringWithFormat:@"%@%@",REQUEST_URL,[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        _result = [DataResult new];
        [_result appendDictionary:responseDict];
        
        if (_result.statusCode ==1) {
            success(_result);
        }else{
            if (_result.message.length) {
                [[AppCustomHud sharedEKZCustomHud] showTextHud:_result.message];
            }
            failure(_result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"[CMRequest]: %@",error.localizedDescription);
        failure(error);
    }];
    
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(JSONResponse)success
     failure:(JSONResponse)failure{
    
    self.operationManager = [AFHTTPSessionManager manager];
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.operationManager.requestSerializer.timeoutInterval = 15.0f;
   
    DLog(@"%@",[NSString stringWithFormat:@"%@%@",REQUEST_URL,URLString]);
    
    [self.operationManager POST:[NSString stringWithFormat:@"%@%@",REQUEST_URL,[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _result = [DataResult new];
       NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [_result appendDictionary:responseDict];
        success(_result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);

    }];
    
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

@end
