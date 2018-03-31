//
//  NetworkDef.h
//  mqrc
//
//  Created by VA on 2017/4/22.
//  Copyright © 2017年 kingman. All rights reserved.
//

#ifndef NetworkDef_h
#define NetworkDef_h

#import "NetworkHelper.h"
#ifdef DEBUG //调试

#define HTTPIsdmo @"http://192.168.1.187:2112"
#define HTTPService   @"http://192.168.1.187"

#else

#define HTTPService @"http://www.cqmqrc.com"
#define HTTPIsdmo @"http://192.168.1.187:2112"
#endif


//#define HTTPService   @"http://www.zhanqitx.com"


#define imgTestIP  [MQLunchTool shareInstance].imgBaseUrl

#define AbsolutePath(p) [NSString stringWithFormat:@"%@/api/appApi/%@", HTTPService, p]
#define AbsoluteDmo(p) [NSString stringWithFormat:@"%@/api/appApi/%@", HTTPIsdmo, p]

#define API_getToken  @"init/GetToken"
#define API_getImgService  @"init/GetImgService"

//首页相关接口
#define API_GetAllDataList @"Home/GetAllDataList"
#define API_GetNewsLis @"News/GetNewsLis"
#define API_InitIOSData @"Init/InitIOSData"
//用户类
#define API_SingleImgFileUpload @"User/SingleImgFileUpload"//用户上传图片
#define API_sendSmsCode  @"User/SendSmsCode"  //发送短信
#define API_registerUser  @"User/RegisterUser"  //注册
#define API_login  @"User/Login"  //登录
#define API_FindLoginPwd @"User/FindLoginPwd"//找回密码
#define API_UserLogOut @"User/UserLogOut"//注销登录
#define API_collectionAdd  @"User/CollectionAdd"  //添加收藏
#define API_collectionDelete  @"User/CollectionDelete"  //删除/清空收藏
#define API_collectionList  @"User/GetCollection"  //收藏列表
#define API_uploadAvatar @"User/UploadAvatar" //修改头像
#define API_updateUserInfo @"User/UpdateUserInfo" //修改信息
#define API_getPublishTakeOverList @"User/GetPublishTakeOverList" //会员股权收购发布信息列表
#define API_getGuessLikeTakeOverList @"User/GetGuessLikeTakeOverList" //感兴趣股份并购发布信息列表
#define API_getPublishTransferList @"User/GetPublishTransferList" //会员股份转让发布信息列表
#define API_getGuessLikeTransferList @"User/GetGuessLikeTransferList" //感兴趣股份转让发布信息列表
#define API_getPublishJobPositionList @"User/GetPublishJobPositionList" //会员招聘职位发布信息列表
#define API_getPositionDeliveryList @"User/GetPositionDeliveryList" //职位接收投递简历列表
#define API_getGuessLikeJobResumeList @"User/GetGuessLikeJobResumeList" //感兴趣的简历列表
#define API_getGuessLikeJobPositionList @"User/GetGuessLikeJobPositionList" //感兴趣的职位
#define API_getJobResumeList @"User/GetJobResumeList" //我的简历
#define API_getJobQulificationList @"User/GetJobQulificationList" //我的证书
#define API_addJobQulificationt @"User/AddJobQulification" //发布我的证书
#define API_getResumeDeliveryList @"User/GetResumeDeliveryList" //我的简历投递记录
#define API_getBrosweMeList @"User/GetBrosweMeList" //谁看过我
#define API_getPublishCarList @"User/GetPublishCarList" //会员名车买卖发布信息列表
#define API_getPublishHouseList @"User/GetPublishHouseList" //会员名宅发布信息列表
#define API_getPublishCooperationList @"User/GetPublishCooperationList" //会员资质合作发布列表
#define API_getPublishServiceList @"User/GetPublishServiceList" //会员本地服务发布列表
#define API_addCorporateCertification @"User/AddCorporateCertification" //会员企业信息认证接口-添加（每个用户仅限新增一次）
#define API_UploadAvatar @"User/UploadAvatar"//用户上传头像
#define API_GetPublishFullJobPositionInfo @"User/GetPublishFullJobPositionInfo"//获取用户发布的全职招聘信息
#define API_GetPublishPartJobPositionInfo @"User/GetPublishPartJobPositionInfo"//获取用户发布的兼职招聘信息

#define API_updateCorporateCertification @"User/UpdateCorporateCertification" //会员企业信息认证接口-修改
#define API_getCorporateCertification @"User/GetCorporateCertification" //获取会员企业信息认证接口
#define API_updateLoginPswd @"User/UpdateLoginPswd" //会员登录密码修改
#define API_findLoginPswd @"User/FindLoginPswd" //会员密码找回
#define API_SmsVerifyCode  @"User/SmsVerifyCode"  //验证码校验
#define API_addJobCompany @"User/AddJobCompany" //招聘公司信息新增（每个用户仅限新增一次）
#define API_updateJobCompany @"User/UpdateJobCompany" //招聘公司信息编辑
#define API_AddUserAuthentication @"User/AddUserAuthentication"//用户个人资质认证
#define API_GetJobCheckStatus @"/User/GetJobCheckStatus"//获取招聘企业状态
#define API_AddCollection @"User/AddCollection"//用户添加收藏
#define API_DeleteCollection @"User/DeleteCollection"//取消收藏
#define API_GetPublishJobList @"User/GetPublishJobList"//我发布的招聘
#define API_GetJobDelivery @"User/GetJobDelivery"//我的求职
#define API_OcrBusinessLicense @"OutService/OcrBusinessLicense"//营业执照识别

//股权收购相关接口
#define API_getAddGUID @"Universal/GetAddGUID" //获取预添加收购ID
#define API_addSharesTakeOver @"Shares/AddSharesTakeOver" //发布股权收购信息
#define API_getSharesTakeOverQualificationType @"Shares/GetSharesTakeOverQualificationType" //资质信息列表接口
#define API_updateSharesTakeOver @"Shares/UpdateSharesTakeOver" //修改股权收购信息
#define API_deleteSharesTakeOver @"Shares/DeleteSharesTakeOver" //删除股权收购信息
#define API_getSharesTakeOverList @"Shares/GetSharesTakeOverList" //股权收购信息列表
#define API_getSharesTakeOverInfo @"Shares/GetSharesTakeOverInfo" //股权收购信息详情
#define API_getSharesIndustryList @"Shares/GetSharesIndustryList" //行业分类获取
#define API_GetSharesExcellenceList @"Shares/GetSharesExcellenceList" //获取企业亮点
#define API_GetRecommendSharesTakeOverList @"Shares/GetRecommendSharesTakeOverList"//收购详情推荐
#define API_GetRecomendSharesTransferList @"Shares/GetRecomendSharesTransferList"//股权转让推荐列表

//股份转让相关接口
#define API_getAddGUID @"Universal/GetAddGUID" //获取预添加转让ID
#define API_addSharesTransfer @"Shares/AddSharesTransfer" //发布股份转让信息
#define API_getSharesTransferQualificationList @"Shares/GetSharesTransferQualificationList" //资质信息列表接口
#define API_addSharesTransferQualification @"Shares/AddSharesTransferQualification" //添加资质信息接口
#define API_deleteSharesTransferQualification @"Shares/DeleteSharesTransferQualification" //删除资质信息接口
#define API_updateSharesTransferInfo @"Shares/UpdateSharesTransferInfo" //修改股份转让信息
#define API_deleteSharesTransferInfo @"Shares/DeleteSharesTransferInfo" //删除股份转让信息
#define API_getSharesTransferList @"Shares/GetSharesTransferList" //股份转让信息列表
#define API_getSharesTransferInfo @"Shares/GetSharesTransferInfo" //股份转让信息详情

//人才招聘相关接口
#define API_getJobPositionTypeList @"Job/GetJobPositionTypeList" //职位发布职业类型获取
#define API_getJobSalaryList @"Job/GetJobSalaryList" //职位薪资获取接口
#define API_getJobWelfare @"Job/GetJobWelfareList" //职位福利获取接口
#define API_getRequierEducationList @"Job/GetRequierEducationList" //学历要求获取
#define API_getRequierWorkExperienceList @"Job/GetRequierWorkExperienceList" //工作年限获取
#define API_addJobPositionOrdinary @"Job/AddJobPositionOrdinary" //普通全职职位信息发布
#define API_addJobPositionParttime @"Job/AddJobPositionParttime" //普通兼职职位信息发布接口
#define API_addJobPositionOrdinaryQualification @"Job/AddJobPositionOrdinaryQualification" //持证全职职位信息发布
#define API_addJobPositionParttimeQualification @"Job/AddJobPositionParttimeQualification" //持证兼职职位信息发布
#define API_updateJobPositionOrdinary @"Job/UpdateJobPositionOrdinary" //普通全职职位信息修改
#define API_updateJobPositionParttime @"Job/UpdateJobPositionParttime" //普通兼职职位信息修改
#define API_GetFullJobPositionList @"Job/GetFullJobPositionList" //获取持证全职列表
#define API_GetFullJobPositionInfo @"Job/GetFullJobPositionInfo"//获取持证全职详情
#define API_GetPartJobPositionList @"Job/GetPartJobPositionList"//获取持证兼职列表
#define API_GetPartPositionInfo @"Job/GetPartPositionInfo"//获取兼职详情

#define API_updateJobPositionOrdinaryQualification @"Job/UpdateJobPositionOrdinaryQualification" //持证全职职位信息修改接口
#define API_updateJobPositionParttimeQualification @"Job/UpdateJobPositionParttimeQualification" //持证兼职职位信息修改
#define API_getJobPositionList @"Job/GetJobPositionList" //职位信息列表接口
#define API_getJobPositionInfo @"Job/GetJobPositionInfo" //获取职位详细信息
#define API_getJobQualificationList @"Job/GetJobQualificationList"//获取证书类型

//个人求职相关接口
#define API_GetUserResume @"User/GetUserResume"//我的简历
#define API_addResume @"Job/AddResume" //创建简历接口
#define API_addResumeEducation @"Job/AddResumeEducation" //简历-学历提交接口
#define API_getResumeEducationList @"Job/GetResumeEducationList" //简历-学历列表获取接口
#define API_addResumeWorkExprience @"Job/AddResumeWorkExprience" //简历-工作经历提交接口
#define API_getResumeWorkExprienceList @"Job/GetResumeWorkExprienceList" //简历-工作经历列表获取接口
#define API_addResumeQualification @"Job/AddResumeQualification" //简历-个人证书提交接口
#define API_getResumeQualificationList @"Job/GetResumeQualificationList" //简历-个人证书列表获取接口
#define API_getJobPositionTypeList @"Job/GetJobPositionTypeList" //简历-求职职位类型列表获取接口
#define API_deleteResume @"Job/DeleteResume" //删除简历接口
#define API_deleteResumeEducation @"Job/DeleteResumeEducation" //删除简历-学历接口
#define API_deleteResumeWorkExprience @"Job/DeleteResumeWorkExprience" //删除简历-工作经历接口
#define API_deleteResumeQualification @"Job/DeleteResumeQualification" //删除简历-个人证书接口
#define API_updateResume @"Job/UpdateResume" //修改简历接口
#define API_updateResumeWorkExprience @"Job/UpdateResumeWorkExprience" //简历-工作经历修改接口
#define API_updateResumeEducation @"Job/UpdateResumeEducation" //简历-学历修改接口
#define API_getJobResumeLists @"Job/GetJobResumeList" //简历列表接口
#define API_getResumeInfo @"Job/GetJobResumeInfo" //简历详情获取接口
#define API_UserDeliveryResume @"Job/UserDeliveryResume"//投递简历
#define API_GetPublishShareTakeOverInfo @"User/GetPublishShareTakeOverInfo"//获取需要修改的股权收购信息
#define API_GetPublishShareTransferInfo @"User/GetPublishShareTransferInfo"//获取需要修改的股转让购信息

//#define API_AddCar @"Car/AddCar" //名车发布接口
//#define API_AddResume @"Car/GetCarBrand" //名车品牌列表获取接口
//#define API_AddResume @"Car/GetCarVehicleType" //名车车型车系列表获取接口
//#define API_AddResume @"Car/AddResume" //
//#define API_AddResume @"Car/AddResume" //
//#define API_AddResume @"Car/AddResume" //
//#define API_AddResume @"Car/AddResume" //
//#define API_AddResume @"Car/AddResume" //
//#define API_AddResume @"Car/AddResume" //
//2.6.4(A)名车发布-图片上传接口[组图上传在添加或修改方法中直接上传图片路径的集合]	60
//2.6.5(A)修改名车信息接口[Car/UpdateCar]	60
//2.6.6(A)删除名车信息接口[Car/DeleteCar]	62
//2.6.7(A)名车列表获取接口[Car/GetCarList]	63
//2.6.8名车详细信息获取接口[Car/GetCarInfo]	64
//2.6.9(A)名车类型列表获取接口[Car/GetCarTypeList]	64
//2.7(A)名宅买卖相关接口	65
//2.7.1(A)住宅发布接口[House/AddHouse]	65
//2.7.2(A)写字楼发布接口[House/ AddHouseOfficeBuilding]	66
//2.7.3（A）厂房土地发布接口[House/AddHousePlantLand]	67
//2.7.4(A)名宅分类列表获取接口[House/GetHouseTypeList]	68
//2.7.5（A）租赁方式列表获取接口[House/GetRentTypeList]	69
//2.7.6(A)修改住宅信息接口[House/UpdateHouse]	69
//2.7.7(A)修改写字楼信息接口[House/UpdateHouseOfficeBuilding]	71
//2.7.8(A)修改厂房/土地信息接口[House/UpdateHousePlantLand]	73
//2.7.9(A)删除名宅信息接口[House/DeleteHouse]	74
//2.7.10(A)名宅列表获取接口[House/GetHouseList]	74
//2.7.11(A)名宅详细信息获取接口[House/GetHouseInfo]	75
//2.8(A)本地服务相关接口	75
//2.8.1(A)本地服务发布接口[Service/AddService]	75
//2.8.2(A)本地服务分类获取接口[Service/GetServiceTypeList]	76
//2.8.3(A)修改本地服务信息接口[Service/UpdateService]	77
//2.8.4(A)删除本地服务信息接口[Service/DeleteService]	78
//2.8.5(A)本地服务列表获取接口[Service/GetServiceList]	78
//2.8.6(A)本地服务详细信息获取接口[Service/GetServiceInfo]	79
//2.9(A)企业订制相关接口	80
//2.9.1(A)培训类别获取接口[Customized/GetCustomTrainTypeList]	80
//2.9.2(A)培训课程获取接口[Customized/GetCustomTrain]	80
//2.9.3(A)培训课程详情获取接口[Customized/GetCustomTrainInfo]	81
//2.9.4(A)培训报名信息提交接口[Customized/AddCustomEnter]	81
//2.9.5(A)资质代理资质类型获取接口[Customized/GetCustomizedQualificationType]	82
//2.9.6(A)资质代理提交接口[Customized/AddQualificationAgency]	82
//2.9.7(A)职称评审评审机构获取接口[Customized/GetReviewAgencyList]	83
//2.9.8(A)职称评审提交接口[Customized/AddReviewApply]	84
//2.9.9(A)资质合作提交接口[Customized/AddQualificationCooperation]	84
//2.9.10(A)资质合作信息列表获取接口[Customized/GetQualificationCooperationList]	85
//2.9.11(A)资质合作详细信息获取接口[Customized/GetQualificationCooperationInfo]	86






#define API_getReviewAgencyList @"Customized/GetReviewAgencyList" //资质评审机构获取
#define API_GetCustomTrainTypeList @"Train/GetCustomTrainTypeList"//培训类别
#define API_GetTrainList @"Train/GetTrainList"//培训课程列表
#define API_GetCustomTrainInfo @"Train/GetCustomTrainInfo"//培训课程详情
#define API_AddCustomEnter @"Train/AddCustomEnter"//报名



#endif /* NetworkDef_h */
