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

#define MKAddNetworkStatusObserver(X)       [MKEnvObserverCoordinator addNetworkStatusObserver:X]
#define MKRemoveNetworkStatusObserver(X)    [MKEnvObserverCoordinator removeNetworkStatusObserver:X]
#define MKGetCurrentNetworkStatus           [MKEnvObserverCoordinator getCurrentNetworkStatus]

#define MKAddApplicationObserver(X)         [MKEnvObserverCoordinator addApplicationObserver:X]
#define MKRemoveApplicationObserver(X)      [MKEnvObserverCoordinator removeApplicationObserver:X]

@interface XWEnvObserverCoordinator : NSObject
+ (XWEnvObserverCoordinator *)defaultCoordinator;

+ (void)addNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
+ (void)removeNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
+ (AFNetworkReachabilityStatus)getCurrentNetworkStatus;

+ (void)addApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;
+ (void)removeApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;

@end
