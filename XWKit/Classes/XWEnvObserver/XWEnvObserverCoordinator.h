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
#import "XWEnvObserverCenterUIKeyboard.h"

#define XWAddNetworkStatusObserver(X)       [XWEnvObserverCoordinator addNetworkStatusObserver:X]
#define XWRemoveNetworkStatusObserver(X)    [XWEnvObserverCoordinator removeNetworkStatusObserver:X]
#define XWGetCurrentNetworkStatus           [XWEnvObserverCoordinator getCurrentNetworkStatus]

#define XWAddApplicationObserver(X)         [XWEnvObserverCoordinator addApplicationObserver:X]
#define XWRemoveApplicationObserver(X)      [XWEnvObserverCoordinator removeApplicationObserver:X]

#define XWAddUIKeyboardObserver(X)         [XWEnvObserverCoordinator addUIKeyboardObserver:X]
#define XWRemoveUIKeyboardObserver(X)      [XWEnvObserverCoordinator removeUIKeyboardObserver:X]

@interface XWEnvObserverCoordinator : NSObject
+ (XWEnvObserverCoordinator *)defaultCoordinator;

#pragma mark - NetworkStatusObserver
+ (void)addNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
+ (void)removeNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
+ (AFNetworkReachabilityStatus)getCurrentNetworkStatus;
- (void)addNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
- (void)removeNetworkStatusObserver:(id<XWEnvObserverNetworkStatusProtocol>)observer;
- (AFNetworkReachabilityStatus)getCurrentNetworkStatus;

#pragma mark - ApplicationObserver
+ (void)addApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;
+ (void)removeApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;
- (void)addApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;
- (void)removeApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer;

#pragma mark - UIKeyboardObserver
+ (void)addUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer;
+ (void)removeUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer;
- (void)addUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer;
- (void)removeUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer;

@end
