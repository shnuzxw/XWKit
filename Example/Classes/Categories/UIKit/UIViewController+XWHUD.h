//
//  UIViewController+XWHUD.h
//  XWCarCost
//
//  Created by smile.zhang on 16/1/29.
//  Copyright © 2016年 Zhang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

//#import <UIViewController+HUD/UIViewController+HUD.h>
//#import <SVProgressHUD/SVProgressHUD.h>
//#import <MBProgressHUD+BWMExtension/MBProgressHUD+BWMExtension.h>
//#import <JGProgressHUD/JGProgressHUD.h>
//#import <JTProgressHUD/JTProgressHUD.h>
//#import <SVStatusHUD/SVStatusHUD.h>
//#import <GGProgressHUD/GGProgressHUD.h>
//#import <HTProgressHUD/HTProgressHUD.h>
//#import <JTProgressHUD/JTProgressHUD.h>
//#import <LCCoolHUD/LCCoolHUD.h>
//#import <LCLoadingHUD/LCLoadingHUD.h>
//#import <LCProgressHUD/LCProgressHUD.h>
//#import <SCCatWaitingHUD/SCCatWaitingHUD.h>
//#import <WSProgressHUD/WSProgressHUD.h>

static NSTimeInterval const defaultDelay = 1;

@interface UIViewController (XWHUD)

- (void)xw_showLoding;
- (void)xw_showLoding:(NSString *)loding;
- (void)xw_showLoding:(NSString *)loding inView:(UIView *)view;
- (void)xw_hideLoding;

- (void)xw_showMessage:(NSString *)msg;
- (void)xw_showMessage:(NSString *)msg delay:(NSTimeInterval)delay;
- (void)xw_showMessage:(NSString *)msg delay:(NSTimeInterval)delay animation:(BOOL)animation;

- (void)xw_showError:(NSString *)msg;
- (void)xw_showError:(NSString *)msg inView:(UIView *)view;
- (void)xw_showError:(NSString *)msg inView:(UIView *)view animation:(BOOL)animation;
- (void)xw_showError:(NSString *)msg inView:(UIView *)view delay:(NSTimeInterval)delay animation:(BOOL)animation;

- (void)xw_showSuccess:(NSString *)msg;
- (void)xw_showSuccess:(NSString *)msg inView:(UIView *)view;
- (void)xw_showSuccess:(NSString *)msg inView:(UIView *)view animation:(BOOL)animation;
- (void)xw_showSuccess:(NSString *)msg inView:(UIView *)view delay:(NSTimeInterval)delay animation:(BOOL)animation;

- (void)xw_showImage:(UIImage *)image message:(NSString *)msg inView:(UIView *)view delay:(NSTimeInterval)delay animation:(BOOL)animation;

- (void)xw_hideHud;
- (void)xw_hideHud:(BOOL)animated;
- (void)xw_hideHud:(BOOL)animated completeBlock:(dispatch_block_t)block;
- (void)xw_hideHud:(BOOL)animated afterDelay:(NSTimeInterval)delay completeBlock:(dispatch_block_t)block;

@end
