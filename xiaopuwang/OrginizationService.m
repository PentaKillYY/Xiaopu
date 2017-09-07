//
//  OrginizationService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/7/21.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "OrginizationService.h"

@implementation OrginizationService
+ (instancetype)sharedOrginizationService{
    static OrginizationService *sharedOrginizationService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedOrginizationService=[[OrginizationService alloc]init];
    });
    return sharedOrginizationService;
}

-(void)postGetOrginfoWithPage:(NSInteger)page
                        Size:(NSInteger)size
                  Parameters:(NSDictionary *)parameters
                onCompletion:(JSONResponse)completionBlock
                   onFailure:(JSONResponse)failureBlock{
    
    
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld",GetOrginfo,(long)page,(long)size]  parameters:parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getCourseClassTypeWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
   [[BaseHttpRequest sharedBaseHttpRequest] GET:CourseClassType parameters:parameters success:^(id json) {
       completionBlock(json);
   } failure:^(id json) {
       failureBlock(json);
   }];
}

-(void)getCoursetypeParameters:(NSDictionary *)parameters
                  onCompletion:(JSONResponse)completionBlock
                     onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:CourseType parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getGroupTypeParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:Grouptype parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getOrgDetailInfoParameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgDetailInfo parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getAlbumWithParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgAlbum parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getVideoWithParameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgVideo parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getOrgCourseListWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgCourseList parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getCourseTeacherListWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgTeacherList parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getStudentListWithParameters:(NSDictionary *)parameters
                       onCompletion:(JSONResponse)completionBlock
                          onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgStudentList parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getOrgRelyContentListWithParameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgRelyContent parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserAppointMentStateWithParameters:(NSDictionary *)parameters
                                onCompletion:(JSONResponse)completionBlock
                                   onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:IsUserAppoint parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)judgeFocusOrgWithParameters:(NSDictionary *)parameters
                      onCompletion:(JSONResponse)completionBlock
                         onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:JudgeFocusOrg parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)focusOrgWithOrgID:(NSString*)orgid Userid:(NSString*)userid
            onCompletion:(JSONResponse)completionBlock
               onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?organizationId=%@&userId=%@",FocusOrg,orgid,userid] parameters: nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)delfocusOrgWithOrgID:(NSString*)orgid Userid:(NSString*)userid
               onCompletion:(JSONResponse)completionBlock
                  onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?organizationId=%@&userId=%@",DelFocusOrg,orgid,userid] parameters: nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getOrgCourseDetailWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgCourseDetail parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}


-(void)appointOrgWithParameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock{
    
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?orgApplicationID=%@&userId=%@&peopleContent=%@",AppointMentOrg,[parameters objectForKey:@"orgApplicationID"],[parameters objectForKey:@"userId"],[parameters objectForKey:@"peopleContent"]]  parameters: nil success:^(id json) {
        
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getOrgLisyByClassWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:OrgByClass parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getCourseTypeBuGroupWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:CourseTypeByGroup parameters: parameters success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}
@end
