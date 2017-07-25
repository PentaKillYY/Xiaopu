//
//  OrginizationService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrginizationService : NSObject
+ (instancetype)sharedOrginizationService;

//获取机构列表（分页）
-(void)postGetOrginfoWithPage:(NSInteger)page
                        Size:(NSInteger)size
                  Parameters:(NSDictionary *)parameters
                onCompletion:(JSONResponse)completionBlock
                   onFailure:(JSONResponse)failureBlock;

//获取班级课程列表
-(void)getCourseClassTypeWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//获取课程种类
-(void)getCoursetypeParameters:(NSDictionary *)parameters
                  onCompletion:(JSONResponse)completionBlock
                     onFailure:(JSONResponse)failureBlock;

//获取科目种类
-(void)getGroupTypeParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;

//获取培训机构详细信息
-(void)getOrgDetailInfoParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;
@end
