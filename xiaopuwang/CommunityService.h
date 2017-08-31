//
//  CommunityService.h
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityService : NSObject
+ (instancetype)sharedCommunityService;

//获取社区帖子列表
-(void)getCommunityListWithPage:(NSInteger)page
                           Size:(NSInteger)size
                     Parameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock;

//获取社区帖子详情
-(void)getCommunityDetailWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//获取帖子的用户回复列表
-(void)getCommunityReplyListWithPage:(NSInteger)page
                                Size:(NSInteger)size
                          Parameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

//用户帖子收藏
-(void)collectCommunityWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;

//用户删除收藏
-(void)deleteCollectCommunityWithParameters:(NSDictionary *)parameters
                               onCompletion:(JSONResponse)completionBlock
                                  onFailure:(JSONResponse)failureBlock;

//获取用户帖子点赞数
-(void)getUserPraiseNumberWithParameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock;

//用户收藏帖子查询
-(void)getUserCollectListWithPage:(NSInteger)page
                             Size:(NSInteger)size
                       Parameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;

//获取用户发布的帖子
-(void)getCommunityByUserWithPage:(NSInteger)page
                             Size:(NSInteger)size
                       Parameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock;

//获取用户回复信息
-(void)getReplyByUserWithPage:(NSInteger)page
                         Size:(NSInteger)size
                   Parameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock;

//社区帖子删除
-(void)deleteCommunityWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock;

//用户浏览录入
-(void)userBrowseCommunityWithParameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock;

//用户点赞录入
-(void)userGoodCommunityWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;

//更新用户身份
-(void)updateUserIdentityWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock;

//用户删除收藏
-(void)userCollectionDeleteWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock;

//获取用户帖子类型列表
-(void)getCommunityTypeWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock;

//社区帖子录入
-(void)UserPostCommunityWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock;
@end
