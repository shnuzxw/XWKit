//
//  UIDevice+XWCategory.h
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (XWCategory)

// 获取设备UUID地址，AABBCCDDEEFF
+ (NSString *)macAddresses;
+ (NSString *)idfaString;
+ (NSString *)idfvString;
// 获取设备IP地址
+ (NSString *)WLANIPAddresses;
+ (NSString *)getHWAddresses;

// 取得用户接入的AP信息
+ (id)fetchSSIDInfo;

+ (NSString *)appVersion;
+ (NSString *)appBundleIdentifier;
+ (NSString *)appBuild;
+ (NSString *)sysVersion;

/**
 * [NSUUID UUIDString]
 */
+ (NSString *)deviceUUIDString;

/**
 * [NSUUID UUIDString] 去除'-'
 */
+ (NSString *)deviceUUID;

/**
 * "iPhone5, 3" : [UIDevice currentDevice].model
 */
+ (NSString *)deviceModel;

/**
 * "iPhone 5c" : 经过处理后的Type
 */
+ (NSString *)deviceModelType;

@end
