//
//  XWEnvObserverCenterNetworkStatus.h
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

#import "XWEnvObserverCenter.h"
#import "AFNetworkReachabilityManager.h"

@protocol XWEnvObserverNetworkStatusProtocol <NSObject>
@optional
- (void)xwEnvObserverNetworkStatusDidChangedFromStatus:(AFNetworkReachabilityStatus)fromStatus toStatus:(AFNetworkReachabilityStatus)toStatus;
@end

@interface XWEnvObserverCenterNetworkStatus : XWEnvObserverCenter {
    AFNetworkReachabilityManager * _host;
    AFNetworkReachabilityStatus _networkStatus;
}

+ (XWEnvObserverCenterNetworkStatus *)defaultCenter;
- (AFNetworkReachabilityStatus)getCurrentNetworkStatus;
@end
