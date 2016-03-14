//
//  XWEnvObserverCoordinator.m
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//


#import "XWEnvObserverCoordinator.h"

static XWEnvObserverCoordinator * defaultCoordinator;

@implementation XWEnvObserverCoordinator

+ (XWEnvObserverCoordinator *)defaultCoordinator
{
    if (!defaultCoordinator) {
        defaultCoordinator = [[XWEnvObserverCoordinator alloc] init];
    }
    return defaultCoordinator;
}

+ (void)addNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer
{
    [[XWEnvObserverCenterNetworkStatus defaultCenter] addEnvObserver:observer];
}

+ (void)removeNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer
{
    [[XWEnvObserverCenterNetworkStatus defaultCenter] removeEnvObserver:observer];
}

+ (AFNetworkReachabilityStatus)getCurrentNetworkStatus
{
    return [[XWEnvObserverCenterNetworkStatus defaultCenter] getCurrentNetworkStatus];
}

+ (void)addApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer
{
    [[XWEnvObserverCenterApplication defaultCenter] addEnvObserver:observer];
}

+ (void)removeApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer
{
    [[XWEnvObserverCenterApplication defaultCenter] removeEnvObserver:observer];
}

@end
