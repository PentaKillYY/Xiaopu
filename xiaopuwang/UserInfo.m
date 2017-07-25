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
        decodeObject(id);
        decodeObject(idCard);
        decodeObject(userCityCode);
        decodeObject(userCityname);
        decodeObject(serviceTel);
        decodeObject(role);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    encodeObject(username);
    encodeObject(password);
    encodeObject(telphone);
    encodeObject(headPicUrl);
    encodeObject(id);
    encodeObject(idCard);
    encodeObject(userCityCode);
    encodeObject(userCityname);
    encodeObject(serviceTel);
    encodeObject(role);
}

- (void)setWithDict:(NSDictionary *)dict{
    self.username=dict[@"username"];
    self.password=dict[@"password"];
    self.telphone=dict[@"telephone"];
    self.headPicUrl=dict[@"headPicUrl"];
    self.id=dict[@"id"];
    self.idCard=dict[@"idCard"];
    self.userCityCode=dict[@"userCityCode"];
    self.userCityname=dict[@"userCityname"];
    self.serviceTel=dict[@"serviceTel"];
    self.role=dict[@"role"];
}

- (void)logout{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:NSStringFromClass(self.class)];
    [defaults synchronize];
    [self setWithDict:nil];
}
@end
