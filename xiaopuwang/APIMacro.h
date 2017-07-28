//
//  APIMacro.h
//  PeachNet
//
//  Created by 牛哲 on 15/6/16.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

/**
 *  本文件可放请求API 拼接的路径
 */

// *******************************首页**************************

//获取广告位
#define GetAdvertisement @"/user/GetAdvertisement"

// *******************************机构**************************

//获取机构列表（分页）
#define GetOrginfo @"/cousertrain/orgInfo"

//获取班级课程列表
#define CourseClassType @"/cousertrain/CourseClassType"

//获取课程种类
#define CourseType @"/cousertrain/CourseType"

//获取科目种类
#define Grouptype @"/cousertrain/GroupType"

//获取培训机构详细信息
#define OrgDetailInfo @"/cousertrain/OrgDetailInfo"

//获取机构在线试听课程列表(分页)
#define OrgVideo @"/cousertrain/OrgVideoList"

//获取机构相册信息
#define OrgAlbum @"/cousertrain/OrganizationAlbum"

//获取机构在线试听课程列表(分页)
#define OrgVideoList @"/cousertrain/OrgVideoList"

//获取机构课程列表(分页)
#define OrgCourseList @"/cousertrain/OrgCourseList"

//获取机构教师列表(分页)
#define OrgTeacherList @"/cousertrain/OrgTeacherList"

//获取机构优秀学院列表(分页)
#define OrgStudentList @"/cousertrain/OrgStudentList"

//获取机构评价内容(分页)
#define OrgRelyContent @"/cousertrain/OrganizationRelyContent"

//判断用户是否预约
#define IsUserAppoint @"/userOrder/UserIsAppointment"

//判断此人是否关注过此机构
#define JudgeFocusOrg @"/cousertrain/judgeFocusOrgIsExist"

//用户关注机构
#define FocusOrg @"/cousertrain/InFocusOrg"

//取消关注机构
#define DelFocusOrg @"/cousertrain/delFocusOrg"

//获取课程详情
#define OrgCourseDetail @"/cousertrain/CourseInfoDetail"

// *******************************学校**************************

//学校搜索页-分页查询
#define SchoolSearchList @"/school/schoolsearchList"

// *******************************我的**************************

//用户登录 返回用户UserId
#define Login @"/user/Login"

//获取用户余额
#define UserBalance @"/user/UserBalance"

//通过用户UserId 查询单个用户
#define GetUserOnly @"/users/getUserOnly"

//更新用户头像
#define UpdateUserHead @"/user/updateUserHeadSculpture"

//获取 Token
#define GetToken @"/user/getToken"
