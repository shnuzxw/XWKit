//
//  MKEnvObserverCenterNetworkStatus.m
//  LNUniversal
//
//  Created by liu nian on 15/5/25.
//  Copyright (c) 2015年 Liu Nian site:http://iliunian.com. All rights reserved.
//

#import "MKEnvObserverCenterNetworkStatus.h"

static MKEnvObserverCenterNetworkStatus * defaultCenter;

@implementation MKEnvObserverCenterNetworkStatus
+ (MKEnvObserverCenterNetworkStatus *)defaultCenter
{
    if (!defaultCenter) {
        defaultCenter = [[MKEnvObserverCenterNetworkStatus alloc] init];
    }
    return defaultCenter;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:) 
                                                     name:AFNetworkingReachabilityDidChangeNotification
                                                   object:nil];
        
        _host = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
        [_host startMonitoring];
        _networkStatus = [_host networkReachabilityStatus];

    }
    return self;
}

- (AFNetworkReachabilityStatus)getCurrentNetworkStatus
{
    return _networkStatus;
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    AFNetworkReachabilityStatus fromStatus = _networkStatus;
    _networkStatus = [_host networkReachabilityStatus];;
    if (fromStatus == _networkStatus) {
        return;
    }
    
    for (MKObserver * ob in _observersAry) {
        id<MKEnvObserverNetworkStatusProtocol> observer = ob.observer;
        if ([observer respondsToSelector:@selector(mkEnvObserverNetworkStatusDidChangedFromStatus:toStatus:)]) {
            [observer mkEnvObserverNetworkStatusDidChangedFromStatus:fromStatus toStatus:_networkStatus];
        }
    }
}

@end
