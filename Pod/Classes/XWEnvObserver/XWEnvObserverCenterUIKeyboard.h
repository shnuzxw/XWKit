//
//  XWEnvObserverCenterKeyBoard.h
//  BookingClient
//
//  Created by smile.zhang on 16/5/13.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWEnvObserverCenter.h"

@protocol XWEnvObserverUIKeyboardProtocol <NSObject>
@optional
- (void)xwEnvObserverUIKeyboardWillShowNotification:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardDidShowNotification:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardWillHideNotification:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardDidHideNotification:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardFrameBeginUserInfoKey:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardFrameEndUserInfoKey:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardAnimationDurationUserInfoKey:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardAnimationCurveUserInfoKey:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardIsLocalUserInfoKey:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardWillChangeFrameNotification:(NSNotification *)notification;
- (void)xwEnvObserverUIKeyboardDidChangeFrameNotification:(NSNotification *)notification;
@end

@interface XWEnvObserverCenterUIKeyboard : XWEnvObserverCenter
+ (XWEnvObserverCenterUIKeyboard *)defaultCenter;
@end
