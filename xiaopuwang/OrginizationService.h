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

//获取机构相册信息
-(void)getAlbumWithParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;

//获取机构在线试听课程列表（分页）
-(void)getVideoWithParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;

//获取机构课程列表(分页)
-(void)getOrgCourseListWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;

//获取机构教师列表(分页)
-(void)getCourseTeacherListWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock;

//获取机构优秀学院列表(分页)
-(void)getStudentListWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock;

//获取机构评价内容(分页)
-(void)getOrgRelyContentListWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock;

//判断用户是否预约
-(void)getUserAppointMentStateWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock;

//判断此人是否关注过此机构
-(void)judgeFocusOrgWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock;

//用户关注机构
-(void)focusOrgWithOrgID:(NSString*)orgid Userid:(NSString*)userid
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;

//取消关注机构
-(void)delfocusOrgWithOrgID:(NSString*)orgid Userid:(NSString*)userid
            onCompletion:(JSONResponse)completionBlock
               onFailure:(JSONResponse)failureBlock;

//获取课程详情
-(void)getOrgCourseDetailWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//用户机构预约
-(void)appointOrgWithParameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock;

//通过课程名称获取机构列表
-(void)getOrgLisyByClassWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//获取课程类别及其科目种类
-(void)getCourseTypeBuGroupWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock;

//发送通知提醒至预约机构
-(void)sendToOrgWithParameters:(NSDictionary *)parameters
                  onCompletion:(JSONResponse)completionBlock
                     onFailure:(JSONResponse)failureBlock;

//获取机构下的拼课列表
-(void)groupCourseByOrgWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;
@end
