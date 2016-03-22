//
//  XWEnvObserverCoordinator.h
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWEnvObserverCenterApplication.h"
#import "XWEnvObserverCenterNetworkStatus.h"

#define XWAddNetworkStatusObserver(X)       [XWEnvObserverCoordinator addNetworkStatusObserver:X]
#define XWRemoveNetworkStatusObserver(X)    [XWEnvObserverCoordinator removeNetworkStatusObserver:X]
#define XWGetCurrentNetworkStatus           [XWEnvObserverCoordinator getCurrentNetworkStatus]

#define XWAddApplicationObserver(X)         [XWEnvObserverCoordinator addApplicationObserver:X]
#define XWRemoveApplicationObserver(X)      [XWEnvObserverCoordinator removeApplicationObserver:X]

@interface XWEnvObserverCoordinator : NSObject
+ (XWEnvObserverCoordinator *)defaultCoordinator;

+ (void)addNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
+ (void)removeNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
+ (AFNetworkReachabilityStatus)getCurrentNetworkStatus;

+ (void)addApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;
+ (void)removeApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;

@end
