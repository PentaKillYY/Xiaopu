//
//  AppMacro.h
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/20.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

/**
 *  本类放app相关的宏定义 
 */

//内网
#define REQUEST_URL @"http://www.api.ings.org.cn"
#define IMAGE_URL @"http://www.ings.org.cn"

// 正式
//#define REQUEST_URL @"http://www.api.ings.org.cn"
//#define IMAGE_URL @"http://www.ings.org.cn"


// 首次启动判断
#define CM_FIRST_LAUNCHED @"firstLaunch"

// 动态令牌
#define YC_DYNAMIC_TOKEN_NAME @"yc_dynamic_token"

#define YC_DYNAMIC_TOKEN IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(YC_DYNAMIC_TOKEN_NAME)))

