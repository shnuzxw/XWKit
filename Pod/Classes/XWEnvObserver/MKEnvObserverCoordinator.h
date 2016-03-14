//
//  MKEnvObserverCoordinator.h
//  LNUniversal
//
//  Created by liu nian on 15/5/25.
//  Copyright (c) 2015年 Liu Nian site:http://iliunian.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKEnvObserverCenterApplication.h"
#import "MKEnvObserverCenterNetworkStatus.h"

#define MKAddNetworkStatusObserver(X)       [MKEnvObserverCoordinator addNetworkStatusObserver:X]
#define MKRemoveNetworkStatusObserver(X)    [MKEnvObserverCoordinator removeNetworkStatusObserver:X]
#define MKGetCurrentNetworkStatus           [MKEnvObserverCoordinator getCurrentNetworkStatus]

#define MKAddApplicationObserver(X)         [MKEnvObserverCoordinator addApplicationObserver:X]
#define MKRemoveApplicationObserver(X)      [MKEnvObserverCoordinator removeApplicationObserver:X]

@interface MKEnvObserverCoordinator : NSObject
+ (MKEnvObserverCoordinator *)defaultCoordinator;

+ (void)addNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer;
+ (void)removeNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer;
+ (AFNetworkReachabilityStatus)getCurrentNetworkStatus;

+ (void)addApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer;
+ (void)removeApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer;

@end
