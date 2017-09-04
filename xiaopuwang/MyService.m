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
        failureBlock(json);
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
        info.recommand = [result.detailinfo getString:@"Recommender"];
        [info synchronize];

        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];

}

-(void)getUserBalanceWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:UserBalance parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)postUserHeadWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:UpdateUserHead parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
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
        failureBlock(json);
    }];
}

-(void)getUserBasicInfoWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetUserBasicInfo parameters:parameters success:^(id json) {
        DataResult* result = json;
        
        UserInfo* info = [UserInfo sharedUserInfo];
        info.username = [result.detailinfo getString:@"User_name"];
        info.userGender= [result.detailinfo getString:@"Sex"];
        info.userCountry = [result.detailinfo getString:@"CountryName"];
        info.userProvince = [result.detailinfo getString:@"ProvinceName"];
        info.userCity = [result.detailinfo getString:@"CityName"];
        info.headPicUrl = [result.detailinfo getString:@"Photo"];
        info.userIdentity = [result.detailinfo getString:@"UserIdentity"];
        
        [info synchronize];
        
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserBargainWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:UserBargain parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)sendMessageAfterBargainWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:SendMessageAfterBargain parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)GetUserAdscriptionWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:GetUserAdscription parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
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
        if (result.statusCode == 1) {
           completionBlock(result);
        }else{
            failureBlock(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)getUserFocusOrgWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@",GetUserFocusOrg,[parameters objectForKey:@"userId"]]  parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}


-(void)getUserFocusSchoolWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@",GetUserFocusSchool,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSpecialistOrgWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@",GetSpecialistOrg,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
       failureBlock(json);
    }];
}

-(void)getSpecialistChinaSchoolWithParameters:(NSDictionary *)parameters
                                 onCompletion:(JSONResponse)completionBlock
                                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@",GetSpecialstChinaSchool,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSpecialistOverseaSchoolWithParameters:(NSDictionary *)parameters
                                   onCompletion:(JSONResponse)completionBlock
                                      onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@",GetSpecialistOverseaSchool,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
       failureBlock(json);
    }];
}

-(void)updateUserInfoWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:UpdateUserInfo parameters:parameters success:^(id json) {

        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserBankCardWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@",GetUserBankCard,[parameters objectForKey:@"userId"]] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];

}

-(void)changePasswordWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:ChangePassword parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)deleteBankcardWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:DeleteUserbankCard parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)judgeCardIsAddWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:JudgeCardIsAdd parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)addCardWithParameters:(NSDictionary *)parameters
                onCompletion:(JSONResponse)completionBlock
                   onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:AddCard parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
       failureBlock(json);
    }];
}

-(void)getUserAppointListWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UserAppointList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];

}

-(void)getUserOrderListWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UsreOrderList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)deleteUserAppointmentWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:DeleteUserAppointment parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userMakeOrderWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:UserMakeOrder parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)updateUserAppointmentWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UpdataUserAppointment parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)cancelUserOrderWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:CancelUserOrder parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserOrderInfoWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UserOrderInfo parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)deleteUserOrderWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:DeleteUserOrder parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getBackPriceWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:GetBackPrice parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)updateOrderShareWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UpdateOrderShare parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
       failureBlock(json);
    }];
}

-(void)addBackPriceWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:AddBackPrice parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userEvaluateWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:UserEvaluate parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)updateAfterEvaluateWithParameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UpdateOrderAfterEvaluate parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserCouponListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UserCouponList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)invalidUserCouponWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:UserCouponInvalid parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];

}

-(void)updateUserBalanceWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:UpdateUserBalance parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
       failureBlock(json);
    }];
}

-(void)giveCouponWithParameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:GiveCoupon parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)searchUserByPhoneWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:SearchUserByPhone parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)aliPaySignWithParameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:AliPaySign parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
       failureBlock(json);
    }];
}

-(void)wxPaySignWithParameters:(NSDictionary *)parameters
                  onCompletion:(JSONResponse)completionBlock
                     onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:WXPaySign parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserTradeDetailWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:[NSString stringWithFormat:@"%@?userId=%@",UserTradeDetail,[parameters objectForKey:@"userId"]]  parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userReflectWithParameters:(NSDictionary *)parameters
                    onCompletion:(JSONResponse)completionBlock
                       onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:[NSString stringWithFormat:@"%@?userId=%@&cardNum=%@",UserReflect,[parameters objectForKey:@"userId"],[parameters objectForKey:@"cardNum"]]  parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userUpdateOrderAfterPayWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:UpdateOrderAfterPay parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userUpdateTotaoPriceAfterPayWithParameters:(NSDictionary *)parameters
                                     onCompletion:(JSONResponse)completionBlock
                                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:UpdateTotalPriceAfterPay parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)sendValidCodeWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST: [NSString stringWithFormat:@"%@?name=%@&mobile=%@",SendValidCode,@"客户",[parameters objectForKey:@"mobile"]] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)checkValidCodeWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:CheckValidcode parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)checkIsRegisterWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:CheckIsRegister parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userRegisterWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]POST:UserRegister parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)resetPasswordWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:ResetPassword parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)updateUserTokenWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest]GET:[NSString stringWithFormat:@"%@?userId=%@&token=%@",UpdateUserToken,[UserInfo sharedUserInfo].userID,[parameters objectForKey:@"token"]]  parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}
@end
