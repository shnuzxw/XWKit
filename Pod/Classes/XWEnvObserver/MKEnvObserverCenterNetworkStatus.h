//
//  MKEnvObserverCenterNetworkStatus.h
//  LNUniversal
//
//  Created by liu nian on 15/5/25.
//  Copyright (c) 2015年 Liu Nian site:http://iliunian.com. All rights reserved.
//

#import "MKEnvObserverCenter.h"
#import "AFNetworkReachabilityManager.h"

@protocol MKEnvObserverNetworkStatusProtocol <NSObject>
@optional
- (void)mkEnvObserverNetworkStatusDidChangedFromStatus:(AFNetworkReachabilityStatus)fromStatus toStatus:(AFNetworkReachabilityStatus)toStatus;
@end

@interface MKEnvObserverCenterNetworkStatus : MKEnvObserverCenter {
    AFNetworkReachabilityManager * _host;
    AFNetworkReachabilityStatus _networkStatus;
}
+ (MKEnvObserverCenterNetworkStatus *)defaultCenter;
- (AFNetworkReachabilityStatus)getCurrentNetworkStatus;
@end
