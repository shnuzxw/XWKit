//
//  XWEnvObserverCenterNetworkStatus.m
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

#import "XWEnvObserverCenterNetworkStatus.h"

static XWEnvObserverCenterNetworkStatus * defaultCenter;

@implementation XWEnvObserverCenterNetworkStatus
+ (XWEnvObserverCenterNetworkStatus *)defaultCenter
{
    if (!defaultCenter) {
        defaultCenter = [[XWEnvObserverCenterNetworkStatus alloc] init];
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
    
    for (XWObserver * ob in _observersAry) {
        id<XWEnvObserverNetworkStatusProtocol> observer = ob.observer;
        if ([observer respondsToSelector:@selector(mkEnvObserverNetworkStatusDidChangedFromStatus:toStatus:)]) {
            [observer mkEnvObserverNetworkStatusDidChangedFromStatus:fromStatus toStatus:_networkStatus];
        }
    }
}

@end
