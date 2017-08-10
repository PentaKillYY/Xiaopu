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
@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString* userBalance;
@property (copy, nonatomic) NSString* userLongitude;
@property (copy, nonatomic) NSString* userLatitude;
@property (copy, nonatomic) NSString* isReadIntro;
@property (copy, nonatomic) NSString* selectOrgTypeName;
@property (copy, nonatomic) NSString* selectCountryname;
@property (copy, nonatomic) NSString* selectSchoolTypeName;
+(instancetype)sharedUserInfo;
-(void)logout;
@end
