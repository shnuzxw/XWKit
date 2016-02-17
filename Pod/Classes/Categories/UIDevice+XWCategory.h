//
//  UIDevice+XWCategory.h
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

//获取设备屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//应用尺寸
#define APP_WIDTH [[UIScreen mainScreen]applicationFrame].size.width
#define APP_HEIGHT [[UIScreen mainScreen]applicationFrame].size.height
//获取系统版本
#define iOSVer [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurSysVer [[UIDevice currentDevice] systemVersion]
#define isIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] intValue]==7)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] intValue]==8)
#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]>=4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]>=5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]>=6)
#define isAfterIOS7 ([[[UIDevice currentDevice] systemVersion] intValue]>=7)
#define isAfterIOS8 ([[[UIDevice currentDevice] systemVersion] intValue]>=8)

@interface UIDevice (XWCategory)
// 获取设备UUID地址，AABBCCDDEEFF
+ (NSString *)getUUIDAddress;
//
+ (NSString * )macString;
+ (NSString *)idfaString;
+ (NSString *)idfvString;
// 获取设备IP地址
+ (NSString *)getWLanIPAddresses;
+ (NSString *)getHWAddresses;

// 取得用户接入的AP信息
+ (id)fetchSSIDInfo;

+ (NSString *)appVersionString;
+ (NSString *)appBundleIdentifier;
+ (NSString *)appBuild;
+ (NSString *)systemVersionString;
+ (NSString *)deviceModelString;
+ (NSString *)deviceUUIDString;

+ (NSString*)deviceModel;

@end
