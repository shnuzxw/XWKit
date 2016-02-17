//
//  NSString+Category.h
//  LNUniversal
//
//  Created by liu nian on 15/5/25.
//  Copyright (c) 2015年 Liu Nian site:http://iliunian.com. All rights reserved.
//


#import "MKEnvObserverCoordinator.h"

static MKEnvObserverCoordinator * defaultCoordinator;

@implementation MKEnvObserverCoordinator

+ (MKEnvObserverCoordinator *)defaultCoordinator
{
    if (!defaultCoordinator) {
        defaultCoordinator = [[MKEnvObserverCoordinator alloc] init];
    }
    return defaultCoordinator;
}

+ (void)addNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer
{
    [[MKEnvObserverCenterNetworkStatus defaultCenter] addEnvObserver:observer];
}

+ (void)removeNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer
{
    [[MKEnvObserverCenterNetworkStatus defaultCenter] removeEnvObserver:observer];
}

+ (AFNetworkReachabilityStatus)getCurrentNetworkStatus
{
    return [[MKEnvObserverCenterNetworkStatus defaultCenter] getCurrentNetworkStatus];
}

+ (void)addApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer
{
    [[MKEnvObserverCenterApplication defaultCenter] addEnvObserver:observer];
}

+ (void)removeApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer
{
    [[MKEnvObserverCenterApplication defaultCenter] removeEnvObserver:observer];
}

@end
