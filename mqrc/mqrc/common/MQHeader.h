//
//  MQHeader.h
//  mqrc
//
//  Created by 朱波 on 2017/11/24.
//  Copyright © 2017年 朱波. All rights reserved.
//

#ifndef MQHeader_h
#define MQHeader_h



#import "ValiDateTool.h"
#import "NetworkHelper.h"
#import "NetworkDef.h"
#import "UIView+MQExtension.h"
#import "UITableView+MQRegisterCell.h"
#import "MQBaseButton.h"
#import "MBProgressHUD+NH.h"
#import "MBProgressHUD.h"
#import "IQKeyboardManager.h"
#import "MQNavigationController.h"
#import "TZImagePickerController.h"
#import "MQLoginController.h"
#import "MQLoginTool.h"
#import "MQBaseCell.h"
#import "IQDropDownTextField.h"
#import "MQBaseSureBtn.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MQEmpyDataController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "STTextView.h"
#import "MJRefresh.h"
#import "NSDate+MJ.h"
#import "SDCycleScrollView.h"
#import "MQAdressTool.h"
#import "MQLoginModel.h"
#import "MQNavigationController.h"
#import "MQDropTypeView.h"
#import "MQCancelDataController.h"
#import "NSObject+MQTime.h"
#import "NSString+MQHeight.h"
#import "POP.h"
#import "MQAlertTool.h"
#import "UIImageView+LBBlurredImage.h"
#import "UIImageView+WebCache.h"
#import "MQDropTypeView.h"
#import "MJExtension.h"
#import "PGDatePicker.h"
#import "MQConst.h"
#import "MQMapController.h"
#import "Province.h"
#import "City.h"
#import "Area.h"
#import "UIViewController+MQHud.h"
#import "MQPresentNavController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MQResaultController.h"
#import "MQFrameLableCell.h"
#import "MQFrameBaseCell.h"
#import "MQFrameFiledCell.h"
#import "MQFramePriceCell.h"
#import "AddressPickerView.h"
#import "LocaltionInstance.h"
#import "MQEmptTableView.h"
#import "NSObject+MQCreatXIB.h"
#import "MQLabelModel.h"
#import "MQLunchTool.h"
#import "NSString+NSHash.h"
#import "UIImage+MQBase64.h"

#define MQWindow [UIApplication sharedApplication].keyWindow
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
#define nav_barH 64
#define NEEDY ([[[UIDevice currentDevice] systemVersion] integerValue]>=7 ? 20 : 0)
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)
#define DP(size) (size*(SCREEN_WIDTH)/375)
#define DPH(size)(size *(SCREEN_HEIGHT/667))

// 随机色
#define HWRandomColor COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//机型判断
#define IS_IPHONE4      (([[UIScreen mainScreen] bounds].size.height - 480)?NO:YES)
#define IS_IPHONE5      (([[UIScreen mainScreen] bounds].size.height - 568)?NO:YES)
#define IS_IPHONE6      (([[UIScreen mainScreen] bounds].size.width - 375)?NO:YES)
#define IS_IPHONE6_PLUS (([[UIScreen mainScreen] bounds].size.width - 414)?NO:YES)
#define IS_IPHONE_X     (([[UIScreen mainScreen] bounds].size.height - 812)?NO:YES)

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_OS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_OS_11_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

// RGB颜色
//颜色值处理
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define  UIColorFromRGBA(rgbValue,aalpha)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)aalpha]
#define COLOR(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define COLORA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define startColor COLOR(6, 129, 200)
#define endColor COLOR(3, 194, 216)
#define mainColor COLOR(1, 159, 234)
#define baseColor COLOR(239, 239, 244)

//字体处理
#define font(zize) [UIFont systemFontOfSize:zize]

#ifdef DEBUG //调试
#define XLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define XLOGRECT(rect) XLOG(@"rect[%f, %f, %f, %f]", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#else
#define XLOG(fmt,...) {}
#define XLOGRECT(rect) {}
#endif

//本地路径
#define path_Cokiie @"Set-Cookie"
#define path_doc NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
#define path_usermodel [path_doc stringByAppendingPathComponent:@"userModel.txt"]

#define rootController [UIApplication sharedApplication].keyWindow.rootViewController
#define MQNotificationCent [NSNotificationCenter defaultCenter]
#define nav_view self.navigationController.view


//常量字符串
#define Selected_city @"Selected_city"
#define Selected_Aqcer @"Selected_Aqcer"
#define Selected_Trcer @"Selected_Trcer"
#define Selected_TransferCity @"Selected_TransferCity"
#define SureAddres_des @"SureAddres_des"
#define regsinLogin @"regsinLogin"
#define starLogin @"starLogin"
#define login_userName @"loginUserName"
#define isAllowNoti @"isAllowNoti"
#define JobComExamine @"JobComExamine"
#define JobPerExamine @"JobPerExamine"
#define CheckVersion @"CheckVersion"
#define storageImgUrl @"storageImgUrl"

typedef NS_ENUM(NSUInteger,ShareType){
    ShareTypeAcquis = 0,  //股权收购
    ShareTypeTrans,        //股权转让
    ShareTypeSelectedT,    //筛选证书(股权转让)
    ShareTypeSelectedA,    //筛选证书(股权收购)
};

typedef NS_ENUM(NSUInteger,LicenseType) {
    LicenseType_Industry = 0,  //企业证书
    LicenseType_Person         //个人证书
};

typedef NS_ENUM(NSUInteger,JobType) {
    JobTypeOrdinaryFullTime = 0,   //普通全职
    JobTypeOrdinaryPartTime,       //普通兼职
    JobTypeQualificationFullTime,  //持证全职
    JobTypeQualificationPartTime   //持证兼职
};

typedef NS_ENUM(NSUInteger,EditType) {
    EditTypeAdd = 0,  //新增
    EditTypeUpdate   //更新
};

typedef NS_ENUM(NSUInteger,UserPasswordType){
    UserPasswordType_Register = 0,  //注册
    UserPasswordType_Findpwd,        //找回密码
    UserPasswordType_Modifypwd,    //修改密码
    UserPasswordType_Login     //登录
};

#define comNature @[@"国有企业",@"集体企业", @"联营企业",@"股份合作制企业",@"私营企业",@"个体户",@"合伙企业",@"有限责任公司",@"股份有限公司"]
#define CompanyScale @[@"20人以下",@"20-99人", @"100-499人",@"500-999人",@"1000-9999人",@"9999人以上"]
#define SalaryState @[@"1千以下",@"1千-3千", @"3千-5千",@"5千-8千",@"8千-1.2万",@"1.2万-1.5万",@"1.5万-2万",@"面议"]
#define Requirements @[@"不限",@"高中", @"技校",@"中专",@"本科",@"硕士",@"博士"]
#define Experience @[@"不限",@"1年以下", @"1-2年",@"3-5年",@"6-8年",@"8-10年",@"10年以上"]

#endif /* MQHeader_h */
