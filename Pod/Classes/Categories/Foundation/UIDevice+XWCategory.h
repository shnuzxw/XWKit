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
