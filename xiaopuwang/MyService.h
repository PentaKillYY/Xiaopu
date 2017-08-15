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

//获取用户银行卡
-(void)getUserBankCardWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

//删除指定银行卡
-(void)deleteBankcardWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;

//判断用户是否已添加该银行卡
-(void)judgeCardIsAddWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;

//添加银行卡
-(void)addCardWithParameters:(NSDictionary *)parameters
                onCompletion:(JSONResponse)completionBlock
                   onFailure:(JSONResponse)failureBlock;

//更新密码
-(void)changePasswordWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;

//获取用户预约信息（预约列表）
-(void)getUserAppointListWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//获取用户订单信息(待支付、待评价、全部列表)
-(void)getUserOrderListWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;

//取消用户预约信息
-(void)deleteUserAppointmentWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock;

//用户下单
-(void)userMakeOrderWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock;

//更新用户预约信息
-(void)updateUserAppointmentWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock;

//用户取消订单
-(void)cancelUserOrderWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

//获取订单信息
-(void)getUserOrderInfoWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;
@end
