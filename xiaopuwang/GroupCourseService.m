//
//  GroupCourseService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/9/20.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "GroupCourseService.h"

@implementation GroupCourseService
+ (instancetype)sharedGroupCourseService{
    static GroupCourseService *sharedGroupCourseService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGroupCourseService=[[GroupCourseService alloc]init];
    });
    return sharedGroupCourseService;
}

- (void)groupCourseListWithPage:(NSInteger)page
                           Size:(NSInteger)size
                     Parameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld",GroupCourseList,(long)page,(long)size] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getGroupCourseDetailWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@",GroupCourseDetail] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)groupCoursePayWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@",FightCoursePayUnifiedorder] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getAdwardListWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@",GroupCourseReward] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserGroupCourseListWithPage:(NSInteger)page
                                 Size:(NSInteger)size
                           Parameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld",UserGroupList,page,size] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}
@end
