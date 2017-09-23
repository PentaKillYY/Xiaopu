//
//  GroupCourseService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupCourseService : NSObject
+ (instancetype)sharedGroupCourseService;

//获取拼课列表
- (void)groupCourseListWithPage:(NSInteger)page
                           Size:(NSInteger)size
                     Parameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock;

//获取拼课详情
-(void)getGroupCourseDetailWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;


//拼课支付参数
-(void)groupCoursePayWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;

//获取中奖名单
-(void)getAdwardListWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock;

//通过用户ID获取拼课列表
-(void)getUserGroupCourseListWithPage:(NSInteger)page
                                 Size:(NSInteger)size
                           Parameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                                  onFailure:(JSONResponse)failureBlock;
@end
