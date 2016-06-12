//
//  XWEnvObserverCenterApplication.h
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

#import "XWEnvObserverCenter.h"

@protocol XWEnvObserverApplicationProtocol <NSObject>
@optional
- (void)xwEnvObserverApplicationDidEnterBackground:(NSNotification *)notification;
- (void)xwEnvObserverApplicationWillEnterForeground:(NSNotification *)notification;
- (void)xwEnvObserverApplicationDidFinishLaunching:(NSNotification *)notification;
- (void)xwEnvObserverApplicationDidBecomeActive:(NSNotification *)notification;
- (void)xwEnvObserverApplicationWillResignActive:(NSNotification *)notification;
- (void)xwEnvObserverApplicationDidReceiveMemoryWarning:(NSNotification *)notification;
- (void)xwEnvObserverApplicationWillTerminate:(NSNotification *)notification;
- (void)xwEnvObserverApplicationSignificantTimeChange:(NSNotification *)notification;
- (void)xwEnvObserverApplicationWillChangeStatusBarOrientation:(NSNotification *)notification;
- (void)xwEnvObserverApplicationDidChangeStatusBarOrientation:(NSNotification *)notification;
- (void)xwEnvObserverApplicationStatusBarOrientationUserInfoKey:(NSNotification *)notification;
- (void)xwEnvObserverApplicationWillChangeStatusBarFrame:(NSNotification *)notification;
- (void)xwEnvObserverApplicationDidChangeStatusBarFrame:(NSNotification *)notification;
- (void)xwEnvObserverApplicationStatusBarFrameUserInfoKey:(NSNotification *)notification;

@end

@interface XWEnvObserverCenterApplication : XWEnvObserverCenter
+ (XWEnvObserverCenterApplication *)defaultCenter;
@end
