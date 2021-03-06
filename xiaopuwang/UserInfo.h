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
@property (copy, nonatomic) NSString *userGender;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *telphone;
@property (copy, nonatomic) NSString *headPicUrl;
@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *recommand;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString* userBalance;
@property (copy, nonatomic) NSString* userCoupon;
@property (copy, nonatomic) NSString* userIdentity;
@property (copy, nonatomic) NSString* userLongitude;
@property (copy, nonatomic) NSString* userLatitude;
@property (copy, nonatomic) NSString* isReadIntro;
@property (copy, nonatomic) NSString* selectOrgTypeName;
@property (copy, nonatomic) NSString* selectCountryname;
@property (copy, nonatomic) NSString* selectSchoolTypeName;
@property (copy, nonatomic) NSString* address;
@property (copy, nonatomic) NSString* userCountry;
@property (copy, nonatomic) NSString* userProvince;
@property (copy, nonatomic) NSString* userCity;
@property (copy, nonatomic) NSString* communityType;
@property (copy, nonatomic) NSString* firstSelectIndex;
@property (copy, nonatomic) NSString* secondSelectIndex;

@property (copy, nonatomic) NSString* countryID;
@property (copy, nonatomic) NSString* provinceID;
@property (copy, nonatomic) NSString* cityID;
+(instancetype)sharedUserInfo;
-(void)logout;
@end
