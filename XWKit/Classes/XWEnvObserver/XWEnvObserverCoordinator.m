//
//  XWEnvObserverCoordinator.m
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//


#import "XWEnvObserverCoordinator.h"

static XWEnvObserverCoordinator *defaultCoordinator;

@implementation XWEnvObserverCoordinator

+ (XWEnvObserverCoordinator *)defaultCoordinator {
    if (!defaultCoordinator) {
        defaultCoordinator = [[XWEnvObserverCoordinator alloc] init];
    }
    return defaultCoordinator;
}

+ (void)addApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer {
    [[XWEnvObserverCenterApplication defaultCenter] addEnvObserver:observer];
}

+ (void)removeApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer {
    [[XWEnvObserverCenterApplication defaultCenter] removeEnvObserver:observer];
}

- (void)addApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer {
    [[self class] addApplicationObserver:observer];
}

- (void)removeApplicationObserver:(id<XWEnvObserverApplicationProtocol>)observer {
    [[self class] removeApplicationObserver:observer];
}

+ (void)addUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer {
    [[XWEnvObserverCenterUIKeyboard defaultCenter] addEnvObserver:observer];
}

+ (void)removeUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer {
    [[XWEnvObserverCenterUIKeyboard defaultCenter] removeEnvObserver:observer];
}

- (void)addUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer {
    [[self class] addUIKeyboardObserver:observer];
}

- (void)removeUIKeyboardObserver:(id<XWEnvObserverUIKeyboardProtocol>)observer {
    [[self class] removeUIKeyboardObserver:observer];
}

@end
