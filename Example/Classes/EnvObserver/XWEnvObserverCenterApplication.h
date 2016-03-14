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
- (void)mkEnvObserverApplicationDidEnterBackground:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillEnterForeground:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidFinishLaunching:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidBecomeActive:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillResignActive:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidReceiveMemoryWarning:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillTerminate:(NSNotification *)notification;
- (void)mkEnvObserverApplicationSignificantTimeChange:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillChangeStatusBarOrientation:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidChangeStatusBarOrientation:(NSNotification *)notification;
- (void)mkEnvObserverApplicationStatusBarOrientationUserInfoKey:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillChangeStatusBarFrame:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidChangeStatusBarFrame:(NSNotification *)notification;
- (void)mkEnvObserverApplicationStatusBarFrameUserInfoKey:(NSNotification *)notification;

@end

@interface XWEnvObserverCenterApplication : XWEnvObserverCenter
+ (XWEnvObserverCenterApplication *)defaultCenter;
@end
