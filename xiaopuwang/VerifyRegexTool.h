//
//  VerifyRegexTool.h
//  EZhi
//
//  Created by Luyang Huang on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyRegexTool : NSObject
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validateCarNo:(NSString *)carNo;
+ (BOOL) validateCarType:(NSString *)CarType;
+ (BOOL) validateUserName:(NSString *)name;
+ (BOOL) validatePassword:(NSString *)passWord;
+ (BOOL) validateNickname:(NSString *)nickname;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL) validateBankCard:(NSString *)bankcard;
+ (BOOL) validateLastIdentity:(NSString *)identityCard;
@end
