//
//  UtilsMacro.h
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/20.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

/**
 *  本类放一些方便使用的宏定义
 */

// ios7之上的系统
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

// 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE4 [UIScreen mainScreen].bounds.size.height == 480

// 获取当前屏幕的高度 applicationFrame就是app显示的区域，不包含状态栏
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)

// 判断字段时候为空的情况
#define IF_NULL_TO_STRING(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)
// 转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 设置颜色RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
#define ImageNamed(name) [UIImage imageNamed:name]

// 每次请求列表 数据量
#define LS_REQUEST_LIST_COUNT @"10"
#define LS_REQUEST_LIST_NUM_COUNT 10

// 个人信息
#define IS_LOGIN (((NSString *)SEEKPLISTTHING(USER_ID)).length > 0)

#define YC_USER_ID IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_ID)))
#define YC_USER_PHONE IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_PHONE)))
#define YC_USER_EASEMOB_NAME IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_EASEMOB_NAME)))


#define MAINCOLOR UIColorFromRGB(0x0090F0)
#define SPECIALISTNAVCOLOR UIColorFromRGB(0xEB6438)
#define LIGHTORANGE UIColorFromRGB(0xF79864)
#define FIRSTLEVELORGCOLOR UIColorFromRGB(0xea6000)
#define FIRSTLEVELINTERCOLOR UIColorFromRGB(0xb0d627)
#define FIRSTLEVELOVERSEACOLOR UIColorFromRGB(0x5a5af9)
#define GroupCourseRed UIColorFromRGB(0xff2e45)
#define DealOrderButtonColor COLOR(233, 105, 100, 1)
#define PayOrderButtonCOlor COLOR(146, 178, 84, 1)
#define GroupCourseDarkGray UIColorFromRGB(0x727171)
#define GroupCourseLightGray UIColorFromRGB(0x9fa0a0)
#define RedBagGray UIColorFromRGB(0xb5b5b5)
#define SUBCOLOR UIColorFromRGB(0xFF4C4C)
#define ORGGOLD UIColorFromRGB(0xf5cd13)
#define GX_BGCOLOR COLOR(234, 234, 234, 1)

#define MAIN_LIGHT_TEXT_COLOR UIColorFromRGB(0x575757)

#define MAIN_LINE_COLOR COLOR(135, 135, 135, 1)

#define MAIN_LIGHT_LINE_COLOR COLOR(174, 174, 174, 1)

#define MAIN_BLACK_TEXT_COLOR COLOR(38, 38, 38, 1)

#define TEXTFIELD_BG_COLOR [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;














