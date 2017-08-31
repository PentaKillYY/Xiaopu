//
//  CommunityService.m
//  xiaopuwang
//
//  Created by TonyJiang on 2017/8/26.
//  Copyright © 2017年 ings. All rights reserved.
//

#import "CommunityService.h"

@implementation CommunityService
+ (instancetype)sharedCommunityService{
    static CommunityService *sharedCommunityService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCommunityService=[[CommunityService alloc]init];
    });
    return sharedCommunityService;
}

-(void)getCommunityListWithPage:(NSInteger)page
                           Size:(NSInteger)size
                     Parameters:(NSDictionary *)parameters
                   onCompletion:(JSONResponse)completionBlock
                      onFailure:(JSONResponse)failureBlock{
    
    NSString* communityId = [parameters objectForKey:@"communityTypeId"];
    if (communityId.length) {
        [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld&communityTypeId=%@&isEssence=%d&userId=%@",CommunityList,(long)page,(long)size,communityId,[[parameters objectForKey:@"isEssence"] intValue],[parameters objectForKey:@"userId"]] parameters:nil success:^(id json) {
            completionBlock(json);
        } failure:^(id json) {
            failureBlock(json);
        }];
    }else{
        [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?pageIndex=%ld&pageSize=%ld&isEssence=%d&userId=%@",CommunityList,(long)page,(long)size,[[parameters objectForKey:@"isEssence"] intValue],[parameters objectForKey:@"userId"]] parameters:nil success:^(id json) {
            completionBlock(json);
        } failure:^(id json) {
            failureBlock(json);
        }];
    }
    
    
}

-(void)getCommunityDetailWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?id=%@&userId=%@",CommunityDetail,[parameters objectForKey:@"id"] ,[parameters objectForKey:@"userId"]] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getCommunityReplyListWithPage:(NSInteger)page
                                Size:(NSInteger)size
                          Parameters:(NSDictionary *)parameters
                              onCompletion:(JSONResponse)completionBlock
                                 onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?pageIndex=%d&pageSize=%d&noteId=%@",CommunityReplyList,page ,size,[parameters objectForKey:@"noteId"]] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)collectCommunityWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@&noteId=%@",CollectCommunity,[UserInfo sharedUserInfo].userID,[parameters objectForKey:@"noteId"]] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}


-(void)deleteCollectCommunityWithParameters:(NSDictionary *)parameters
                               onCompletion:(JSONResponse)completionBlock
                                  onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?userId=%@&id=%@",DeleteCollectCommunity,[UserInfo sharedUserInfo].userID,[parameters objectForKey:@"noteId"]] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserPraiseNumberWithParameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@",UserPraiseNumber,[UserInfo sharedUserInfo].userID] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getUserCollectListWithPage:(NSInteger)page
                             Size:(NSInteger)size
                       Parameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@&pageIndex=%d&pageSize=%d",UserCommunityCollectList,[UserInfo sharedUserInfo].userID,page,size] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getCommunityByUserWithPage:(NSInteger)page
                             Size:(NSInteger)size
                       Parameters:(NSDictionary *)parameters
                     onCompletion:(JSONResponse)completionBlock
                        onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@&pageIndex=%d&pageSize=%d",CommunityListByUser,[UserInfo sharedUserInfo].userID,page,size] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)getReplyByUserWithPage:(NSInteger)page
                         Size:(NSInteger)size
                   Parameters:(NSDictionary *)parameters
                 onCompletion:(JSONResponse)completionBlock
                    onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:[NSString stringWithFormat:@"%@?userId=%@&pageIndex=%d&pageSize=%d",CommunityReplyListByUser,[UserInfo sharedUserInfo].userID,page,size] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)deleteCommunityWithParameters:(NSDictionary *)parameters
                        onCompletion:(JSONResponse)completionBlock
                           onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?id=%@&userId=%@",DeleteCommunity,[parameters objectForKey:@"noteId"],[UserInfo sharedUserInfo].userID] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userBrowseCommunityWithParameters:(NSDictionary *)parameters
                            onCompletion:(JSONResponse)completionBlock
                               onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?noteId=%@&userId=%@",UserBrowseCommunity,[parameters objectForKey:@"noteId"],[UserInfo sharedUserInfo].userID] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userGoodCommunityWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?noteId=%@&userId=%@",UserGoodCommunity,[parameters objectForKey:@"noteId"],[UserInfo sharedUserInfo].userID] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)updateUserIdentityWithParameters:(NSDictionary *)parameters
                           onCompletion:(JSONResponse)completionBlock
                              onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?identityName=%@&userId=%@",UpdateUserIdentity,[parameters objectForKey:@"identityName"],[UserInfo sharedUserInfo].userID] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)userCollectionDeleteWithParameters:(NSDictionary *)parameters
                             onCompletion:(JSONResponse)completionBlock
                                onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] POST:[NSString stringWithFormat:@"%@?id=%@&userId=%@",UserCollectionDelete,[parameters objectForKey:@"noteId"],[UserInfo sharedUserInfo].userID] parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
 
}

-(void)getCommunityTypeWithParameters:(NSDictionary *)parameters
                         onCompletion:(JSONResponse)completionBlock
                            onFailure:(JSONResponse)failureBlock{
    [[BaseHttpRequest sharedBaseHttpRequest] GET:CommunityType parameters:nil success:^(id json) {
        completionBlock(json);
    } failure:^(id json) {
        failureBlock(json);
    }];
}

-(void)UserPostCommunityWithParameters:(NSDictionary *)parameters
                          onCompletion:(JSONResponse)completionBlock
                             onFailure:(JSONResponse)failureBlock{
  [[BaseHttpRequest sharedBaseHttpRequest] POST:UserPostCommunity parameters:parameters success:^(id json) {
      
  } failure:^(id json) {
      
  }];
}
@end
