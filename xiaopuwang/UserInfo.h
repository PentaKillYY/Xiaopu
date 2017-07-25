//
//  UserInfo.h
//  Kuaizhi
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BaseUserInfo.h"

@interface UserInfo : BaseUserInfo
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *telphone;
@property (copy, nonatomic) NSString *headPicUrl;
@property (strong, nonatomic) NSNumber *id;
@property (copy, nonatomic) NSString *idCard;
@property (strong, nonatomic) NSNumber *role;

@property (copy, nonatomic) NSString* userCityCode;
@property (copy, nonatomic) NSString* userCityname;

@property (copy, nonatomic) NSString* userBalance;
@property (copy, nonatomic) NSString* userLongitude;
@property (copy, nonatomic) NSString* userLatitude;

+(instancetype)sharedUserInfo;
-(void)logout;
@end
