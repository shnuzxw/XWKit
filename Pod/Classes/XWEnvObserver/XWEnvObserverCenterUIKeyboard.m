//
//  XWEnvObserverCenterUIKeyBoard.m
//  BookingClient
//
//  Created by smile.zhang on 16/5/13.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWEnvObserverCenterUIKeyboard.h"
#import <UIKit/UIKit.h>

static XWEnvObserverCenterUIKeyboard *defaultCenter;

@interface XWEnvObserverCenterUIKeyboard ()
- (void)appNotification:(NSNotification *)notification;
@end

@implementation XWEnvObserverCenterUIKeyboard
+ (XWEnvObserverCenterUIKeyboard *)defaultCenter {
    if (!defaultCenter) {
        defaultCenter = [[XWEnvObserverCenterUIKeyboard alloc] init];
    }
    return defaultCenter;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardFrameBeginUserInfoKey
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardFrameEndUserInfoKey
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardAnimationDurationUserInfoKey
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardAnimationCurveUserInfoKey
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardIsLocalUserInfoKey
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appNotification:)
                                                     name:UIKeyboardDidChangeFrameNotification
                                                   object:nil];

    }
    return self;
}

- (void)appNotification:(NSNotification *)notification {
    NSString * name = [notification name];
    SEL s;
    if ([name isEqualToString:UIKeyboardWillShowNotification]) {
        s = @selector(xwEnvObserverUIKeyboardWillShowNotification:);
    } else if ([name isEqualToString:UIKeyboardDidShowNotification]) {
        s = @selector(xwEnvObserverUIKeyboardDidShowNotification:);
    } else if ([name isEqualToString:UIKeyboardWillHideNotification]) {
        s = @selector(xwEnvObserverUIKeyboardWillHideNotification:);
    } else if ([name isEqualToString:UIKeyboardDidHideNotification]) {
        s = @selector(xwEnvObserverUIKeyboardDidHideNotification:);
    } else if ([name isEqualToString:UIKeyboardFrameBeginUserInfoKey]) {
        s = @selector(xwEnvObserverUIKeyboardFrameBeginUserInfoKey:);
    } else if ([name isEqualToString:UIKeyboardFrameEndUserInfoKey]) {
        s = @selector(xwEnvObserverUIKeyboardFrameEndUserInfoKey:);
    } else if ([name isEqualToString:UIKeyboardAnimationDurationUserInfoKey]) {
        s = @selector(xwEnvObserverUIKeyboardAnimationDurationUserInfoKey:);
    } else if ([name isEqualToString:UIKeyboardAnimationCurveUserInfoKey]) {
        s = @selector(xwEnvObserverUIKeyboardAnimationCurveUserInfoKey:);
    } else if ([name isEqualToString:UIKeyboardIsLocalUserInfoKey]) {
        s = @selector(xwEnvObserverUIKeyboardIsLocalUserInfoKey:);
    } else if ([name isEqualToString:UIKeyboardWillChangeFrameNotification]) {
        s = @selector(xwEnvObserverUIKeyboardWillChangeFrameNotification:);
    } else if ([name isEqualToString:UIKeyboardDidChangeFrameNotification]) {
        s = @selector(xwEnvObserverUIKeyboardDidChangeFrameNotification:);
    } else {
        return;
    }
    for (XWObserver * ob in _observersAry) {
        id<XWEnvObserverUIKeyboardProtocol> observer = ob.observer;
        if ([observer respondsToSelector:s]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [observer performSelector:s withObject:notification];
#pragma clang diagnostic pop
        }
    }
}

@end
