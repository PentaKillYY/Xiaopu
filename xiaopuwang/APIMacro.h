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

//获取大额补贴机构（分页）
#define GetSubtidyList @"/cousertrain/orgInfoToExpertConsultation"

//录入专家咨询-机构
#define SpecialistOrg @"/user/OrgExpertConsultationInsert"

//录入专家咨询-国内学校
#define SpecialistChinaSchool @"/user/ChinaSchoolExpertConsultationInsert"

//录入专家咨询-国外学校
#define SpecialistOverseaSchool @"/user/OverSeasSchoolExpertConsultationInsert"

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

//用户机构预约
#define AppointMentOrg @"/userOrder/AppointmentOrg"

// *******************************学校**************************

//学校搜索页-分页查询
#define SchoolSearchList @"/school/schoolsearchList"

//获取所有国家列表
#define SchoolCountryList @"/school/countryList"

//根据国家获取相应的省份
#define SchoolProvinceList @"/school/provinceList"

//获取城市列表
#define SchoolCityList @"/school/cityList"

//获取学校类型
#define SchoolTypeList @"/school/schoolCollegeType"

//获取学校性质
#define SchoolNatureList @"/school/collegeNature"

//获取中国学校列表(分页)
#define ChinaSchoolList @"/school/chinaSchoolInfoList"

//获取学校所有基础信息
#define SchoolDetail @"/school/schoolBasicInfo"

//查询专业课程
#define SchoolCourseList @"/school/professionalCourseList"

//获取学校专业课程
#define SchoolProfessionalList @"/school/SchoolProfessionalCourse"

//查询可接收年级
#define SchoolAcceptedGrade @"/school/acceptGradeList"

//判断用户是否已关注该学校
#define JudgeSChoolFollowState @"/school/JudgeFocusIsExist"

//用户关注学校
#define FollowSchool @"/school/InsertFocusSchool"

//取消关注的学校
#define DelFollowSchool @"/school/DeleteFocusSchool"

//获取中国学校基本信息
#define ChinaSchoolBasicInfo @"/school/chinaSchoolBasicInfo"

//获取中国学校课程
#define ChinaSchoolCourse @"/school/ChinaSchoolCourse"

//获取中国学校师生列表
#define ChinaSchoolTeacherandStudent @"/school/ChinaSchoolTeacherAndStudent"

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

//获取用户基本信息
#define GetUserBasicInfo @"/user/userBaseInfo"

//用户砍价
#define UserBargain @"/user/InsertUserBargain"

//砍价成功短信提醒
#define SendMessageAfterBargain @"/user/SendMessageAfterBargain"

//判断用户归属问题
#define GetUserAdscription @"/userOrder/GetUserAdscription"

//获取上传文件信息
#define UpLoadFileInfo @"/user/uploadFiles?floderName=user&action=add"

//获取用户关注机构信息
#define GetUserFocusOrg @"/user/orgFocusInfo"

//获取用户关注学校信息
#define GetUserFocusSchool @"/user/SchoolFocusInfo"

//通过userId获取专家咨询内容-机构
#define GetSpecialistOrg @"/user/GetOrgExpertConsultation"

//通过userId获取专家咨询内容-中国学校
#define GetSpecialstChinaSchool @"/user/GetChinaSchoolExpertConsultation"

//通过userId获取专家咨询内容-海外学校
#define GetSpecialistOverseaSchool @"/user/GetOverSeasSchoolExpertConsultation"

//更新用户基本信息
#define UpdateUserInfo @"/user/UpdateOrInsertUserBaseInfo"

//获取用户银行卡
#define GetUserBankCard @"/user/userBankCardList"

//删除指定银行卡
#define DeleteUserbankCard @"/user/DeleteBankCard"

//判断用户是否已添加该银行卡
#define JudgeCardIsAdd @"/user/isExsistBankCard"

//添加银行卡
#define AddCard @"/user/addBankCard"

//更新密码
#define ChangePassword @"/user/updatePassword"
