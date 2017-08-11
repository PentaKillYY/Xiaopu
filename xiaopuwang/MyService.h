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

//获取Token（融云）
-(void)getTokenWithParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;


//获取用户基本信息
-(void)getUserBasicInfoWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;

//用户砍价
-(void)getUserBargainWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;

//砍价成功短信提醒
-(void)sendMessageAfterBargainWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock;

//判断用户归属问题
-(void)GetUserAdscriptionWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//获取上传文件信息
-(void)uploadFileInfoWithImage:(UIImage*)image
                    Parameters:(NSString *)imageName
                  onCompletion:(JSONResponse)completionBlock
                     onFailure:(JSONResponse)failureBlock;

//获取用户关注机构信息
-(void)getUserFocusOrgWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

//获取用户关注学校信息
-(void)getUserFocusSchoolWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//通过userId获取专家咨询内容-机构
-(void)getSpecialistOrgWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;

//通过userId获取专家咨询内容-中国学校
-(void)getSpecialistChinaSchoolWithParameters:(NSDictionary *)parameters
                                 onCompletion:(JSONResponse)completionBlock
                                    onFailure:(JSONResponse)failureBlock;

//通过userId获取专家咨询内容-海外学校
-(void)getSpecialistOverseaSchoolWithParameters:(NSDictionary *)parameters
                                   onCompletion:(JSONResponse)completionBlock
                                      onFailure:(JSONResponse)failureBlock;

//更新用户基本信息
-(void)updateUserInfoWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;
@end
