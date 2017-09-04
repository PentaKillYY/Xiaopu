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

//用户删除订单
-(void)deleteUserOrderWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

//获取折扣金额
-(void)getBackPriceWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;

//更新订单分享状态
-(void)updateOrderShareWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;

//增加返现金额
-(void)addBackPriceWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;

//用户评价
-(void)userEvaluateWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;

//用户评价完成后更新订单信息
-(void)updateAfterEvaluateWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;

//获取用户优惠券列表
-(void)getUserCouponListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//用户优惠券失效
-(void)invalidUserCouponWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//用户余额操作
-(void)updateUserBalanceWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//用户优惠券赠送
-(void)giveCouponWithParameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock;

//通过手机号码查询登录信息
-(void)searchUserByPhoneWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//支付宝签名
-(void)aliPaySignWithParameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock;

//微信签名
-(void)wxPaySignWithParameters:(NSDictionary *)parameters
                  onCompletion:(JSONResponse)completionBlock
                     onFailure:(JSONResponse)failureBlock;

//获取用户余额明细
-(void)getUserTradeDetailWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//用户提现- 新
-(void)userReflectWithParameters:(NSDictionary *)parameters
                    onCompletion:(JSONResponse)completionBlock
                       onFailure:(JSONResponse)failureBlock;

//用户支付完成之后订单更新
-(void)userUpdateOrderAfterPayWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock;


//更新用户TotalPrice订单价格
-(void)userUpdateTotaoPriceAfterPayWithParameters:(NSDictionary *)parameters
                                     onCompletion:(JSONResponse)completionBlock
                                        onFailure:(JSONResponse)failureBlock;
//发送手机验证码
-(void)sendValidCodeWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock;

//用户注册验证码验证
-(void)checkValidCodeWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;

//判断用户是否注册
-(void)checkIsRegisterWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

//用户注册
-(void)userRegisterWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;

//更新密码
-(void)resetPasswordWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock;

//更新用户Token
-(void)updateUserTokenWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

@end
