//
//  SchoolService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/29.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "SchoolService.h"

@implementation SchoolService
+ (instancetype)sharedSchoolService{
    static SchoolService *sharedSchoolService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSchoolService=[[SchoolService alloc]init];
    });
    return sharedSchoolService;
}

- (void)getSchoolListWithPage:(NSInteger)page
                         Size:(NSInteger)size
                   Parameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld",SchoolSearchList,(long)page,(long)size] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        
    }];
}

-(void)getSchoolCountryListonCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolCountryList parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];

}

-(void)getSchoolProvinceListWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolProvinceList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSchoolCityListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolCityList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSchoolTypeListWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolTypeList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSchoolNatureListWithParameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolNatureList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)postChinaSchoolListWithPage:(NSInteger)page
                                  Size:(NSInteger)size
                        Parameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld",ChinaSchoolList,(long)page,(long)size] parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSchoolDetailWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolDetail parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSchoolCourseWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolCourseList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSChoolProfessionalListWithParameters:(NSDictionary *)parameters
                                  onCompletion:(JSONResponse)completionBlock
                                     onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolProfessionalList parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getSchoolAcceptedGradeWithParameters:(NSDictionary *)parameters
                               onCompletion:(JSONResponse)completionBlock
                                  onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:SchoolAcceptedGrade parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)judgeSchoolFollowStateWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:JudgeSChoolFollowState parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}


-(void)followSchoolWithParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:FollowSchool parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)delFollowSchoolWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:DelFollowSchool parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getChinaSchoolDetailWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:ChinaSchoolBasicInfo parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getChinaSchoolCourseWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:ChinaSchoolCourse parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getChinaSchoolTeacherAndStudentWithParameters:(NSDictionary *)parameters
                                        onCompletion:(JSONResponse)completionBlock
                                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:ChinaSchoolTeacherandStudent parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}
@end
