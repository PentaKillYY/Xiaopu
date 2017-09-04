//
//  VerifyRegexTool.m
//  EZhi
//
//  Created by Luyang Huang on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "VerifyRegexTool.h"

@implementation VerifyRegexTool
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"(\\+\\d+)?1[34578]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL) validateBankCard:(NSString *)bankcard{
    BOOL flag;
    if (bankcard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{16}|\\d{19})$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:bankcard];
}

+ (BOOL) validateLastIdentity:(NSString *)identityCard{
    NSString* upIdentityCard = [identityCard uppercaseString];
    NSArray* ratioArray= @[@(7),@(9),@(10),@(5),@(8),@(4),@(2),@(1),@(6),@(3),@(7),@(9),@(10),@(5),@(8),@(4),@(2)];
    NSDictionary* checkDic = @{@"0":@"1",@"1":@"0",@"2":@"X",@"3":@"9",@"4":@"8",@"5":@"7",@"6":@"6",@"7":@"5",@"8":@"4",@"9":@"3",@"10":@"2"};
    NSInteger sum = 0;
    for (int i = 0; i<[upIdentityCard length]-1; i++) {
        NSString *s = [upIdentityCard substringWithRange:NSMakeRange(i, 1)];
        NSInteger index = [s integerValue];
        sum += index*[[ratioArray objectAtIndex:i] integerValue];
        
    }
    if ([checkDic objectForKey:[NSString stringWithFormat:@"%ld",(long)sum%11]]) {
        if ([[upIdentityCard substringWithRange:NSMakeRange(17, 1)] isEqualToString:[checkDic objectForKey:[NSString stringWithFormat:@"%ld",(long)sum%11]]]) {
            NSLog(@"校验通过");
            return YES;
        }else{
            NSLog(@"校验不通过");
            return NO;
        }
    }else{
        return NO;
    }
    
}
@end
