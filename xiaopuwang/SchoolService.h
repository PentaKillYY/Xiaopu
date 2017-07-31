//
//  SchoolService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/29.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolService : NSObject
+ (instancetype)sharedSchoolService;

//学校搜索页-分页查询
- (void)getSchoolListWithPage:(NSInteger)page
                         Size:(NSInteger)size
                   Parameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;

//获取所有国家列表
-(void)getSchoolCountryListonCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//根据国家获取相应的省份
-(void)getSchoolProvinceListWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock;

//获取城市列表
-(void)getSchoolCityListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//获取学校类型
-(void)getSchoolTypeListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//获取学校性质
-(void)getSchoolNatureListWithParameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock;
@end
