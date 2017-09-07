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

//获取课程在线试听信息列表
#define OnlineVideoCourseList @"/cousertrain/CourseVideoList"

//获取老师信息列表（分页)
#define TeacherList @"/cousertrain/courseTeacherInfo"

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

//通过课程名称获取机构列表
#define OrgByClass @"/cousertrain/orgInfoByCourseName"

//获取课程类别及其科目种类
#define CourseTypeByGroup @"/cousertrain/CourseTypeByGroup"


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

// *******************************订单**************************

//获取用户预约信息（预约列表）
#define UserAppointList @"/userOrder/AppointmentInfoInfo"

//获取用户订单信息（待支付、待评价、全部列表）
#define UsreOrderList @"/userOrder/GetUserOrderListInfo"

//取消用户预约信息
#define DeleteUserAppointment @"/userOrder/DeleteUserAppointment"

//用户下单
#define UserMakeOrder @"/userOrder/UserOrder"

//更新用户预约信息
#define UpdataUserAppointment @"/userOrder/UpdateUserAppointmentInfo"

//用户取消订单
#define CancelUserOrder @"/userOrder/CancelUserOrderInfo"

//获取订单信息
#define UserOrderInfo @"/userOrder/OrderInfoList"

//用户删除订单
#define DeleteUserOrder @"/userOrder/DeleteUserOrderInfo" 

//获取折扣金额
#define GetBackPrice @"/userOrder/GetDiscountPrice"

//更新订单分享状态
#define UpdateOrderShare @"/userOrder/UpdateIsShare"

//增加返现金额
#define AddBackPrice @"/userOrder/AddBackPrice"

//用户评价
#define UserEvaluate @"/userOrder/InsertUserReplyInfo"

//用户评价完成后更新订单信息
#define UpdateOrderAfterEvaluate @"/userOrder/UpdateOrderInfoAfterReply"

//获取用户优惠券列表
#define UserCouponList @"/user/UserCouponList"

//用户优惠券失效
#define UserCouponInvalid @"/user/UserCouponInvalid"

//用户余额操作
#define UpdateUserBalance @"/user/UserBalanceOperation"

//用户优惠券赠送
#define GiveCoupon @"/user/UserCouponGive"

//通过手机号码查询登录信息
#define SearchUserByPhone @"/user/GetUserInfoByPhone"

//支付宝签名接口
#define  AliPaySign @"/alipay/param"

//微信签名接口
#define WXPaySign @"/wechatpay/param"

//获取用户余额明细
#define UserTradeDetail @"/user/BalanceDetail"

//用户提现-新
#define UserReflect @"/userOrder/UserWithdrawCashNew"

//用户支付完成之后订单更新
#define UpdateOrderAfterPay @"/userOrder/UpdateUserOrderInfo"

//更新用户TotalPrice订单价格
#define UpdateTotalPriceAfterPay @"/userOrder/UpdateUserOrderInfoToTotalPrice"

//发送手机验证码
#define SendValidCode @"/user/sendMessage"

//用户注册验证码验证
#define CheckValidcode @"/user/JudgePhoneOrEmailValidateData"

//判断用户是否注册
#define CheckIsRegister @"/user/IsExistLoginName"

//用户注册
#define UserRegister @"/user/InsertUserRegistrationData" 

//更新密码
#define ResetPassword @"/user/updatePassword"

//更新用户Token
#define UpdateUserToken @"/user/UpdateUserToken" 

// *******************************社区**************************

//获取用户帖子类型列表
#define CommunityType @"/community/communityTypeList"

//获取社区帖子列表
#define CommunityList @"/community/noteList"

//获取社区帖子详情
#define CommunityDetail @"/community/note"

//获取帖子的用户回复列表
#define CommunityReplyList @"/community/userReplyList"

//用户帖子收藏
#define CollectCommunity @"/community/communityCollectionInsert"

//用户删除收藏
#define DeleteCollectCommunity @"/community/cmmunityCollectionDelete"

//获取用户帖子点赞数
#define UserPraiseNumber @"/community/communityUserGoodCountByUserId"

//用户收藏帖子查询
#define UserCommunityCollectList @"/community/communityCollectionList"

//获取用户发布的帖子
#define CommunityListByUser @"/community/communityNoteListByUserId"

//获取用户回复信息
#define CommunityReplyListByUser @"/community/communityUserReplyListByUserId"

//社区帖子删除
#define DeleteCommunity @"/community/noteDelete"

//用户浏览录入
#define UserBrowseCommunity @"/community/userBrowseInsert"

//用户点赞录入
#define UserGoodCommunity @"/community/userGoodInsert"

//更新用户身份
#define UpdateUserIdentity @"/community/userIdentityUpdate"

//用户删除收藏
#define UserCollectionDelete @"/community/cmmunityCollectionDelete"

//社区帖子录入
#define UserPostCommunity @"/community/noteInsert"

//帖子回复录入
#define UserReplyCommunity @"/community/userReplyInsert"
