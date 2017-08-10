//
//  UserInfo.m
//  Kuaizhi
//
//  Created by apple on 15/6/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
+ (instancetype)sharedUserInfo{
    static UserInfo *sharedUserInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
        if (data) {
            sharedUserInfo=(UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        }else{
            sharedUserInfo=[[UserInfo alloc]init];
        }
    });
    
    return sharedUserInfo;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        decodeObject(username);
        decodeObject(password);
        decodeObject(telphone);
        decodeObject(headPicUrl);
        decodeObject(userID);
        decodeObject(token);
        decodeObject(userBalance);
        decodeObject(userLongitude);
        decodeObject(userLatitude);
        decodeObject(isReadIntro);
        decodeObject(selectOrgTypeName);
        decodeObject(selectSchoolTypeName);
        decodeObject(selectCountryname);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    encodeObject(username);
    encodeObject(password);
    encodeObject(telphone);
    encodeObject(headPicUrl);
    encodeObject(userID);
    encodeObject(token);
    encodeObject(userBalance);
    encodeObject(userLongitude);
    encodeObject(userLatitude);
    encodeObject(isReadIntro);
    encodeObject(selectOrgTypeName);
    encodeObject(selectSchoolTypeName);
    encodeObject(selectCountryname);
}

- (void)setWithDict:(NSDictionary *)dict{
    self.username=dict[@"username"];
    self.password=dict[@"password"];
    self.telphone=dict[@"telephone"];
    self.headPicUrl=dict[@"headPicUrl"];
    self.userID=dict[@"userID"];
    self.token=dict[@"token"];
    self.userBalance=dict[@"userBalance"];
    self.userLongitude=dict[@"userLongitude"];
    self.userLatitude=dict[@"userLatitude"];
    self.isReadIntro=dict[@"isReadIntro"];
    self.selectOrgTypeName=dict[@"selectOrgTypeName"];
    self.selectSchoolTypeName=dict[@"selectSchoolTypeName"];
    self.selectCountryname=dict[@"selectCountryname"];
}

- (void)logout{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:NSStringFromClass(self.class)];
    [defaults synchronize];
    [self setWithDict:nil];
}
@end
