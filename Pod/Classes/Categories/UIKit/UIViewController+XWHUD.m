//
//  UIViewController+XWHUD.m
//  XWCarCost
//
//  Created by smile.zhang on 16/1/29.
//  Copyright © 2016年 Zhang Xiaowei. All rights reserved.
//

#import "UIViewController+XWHUD.h"

@implementation UIViewController (XWHUD)

- (void)xw_showLoding{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
}

- (void)xw_showLoding:(NSString *)loding{
    [self xw_showLoding:loding inView:self.view];
}

- (void)xw_showLoding:(NSString *)loding inView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if (view == nil) view = [UIApplication sharedApplication].keyWindow;
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = loding;
        hud.removeFromSuperViewOnHide = YES;
        // YES代表需要蒙版效果
        hud.dimBackground = YES;
    });
}

- (void)xw_hideLoding{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    });
}

- (void)xw_showMessage:(NSString *)msg{
    [self xw_showMessage:msg delay:defaultDelay];
}

- (void)xw_showMessage:(NSString *)msg delay:(NSTimeInterval)delay{
    [self xw_showMessage:msg delay:delay animation:YES];
}

- (void)xw_showMessage:(NSString *)msg delay:(NSTimeInterval)delay animation:(BOOL)animation{
    [self xw_showImage:nil message:msg inView:self.view delay:delay animation:animation];
}

- (void)xw_showError:(NSString *)msg{
    [self xw_showError:msg inView:self.view];
}

- (void)xw_showError:(NSString *)msg inView:(UIView *)view{
    [self xw_showError:msg inView:view animation:YES];
}

- (void)xw_showError:(NSString *)msg inView:(UIView *)view animation:(BOOL)animation{
    [self xw_showError:msg inView:view delay:defaultDelay animation:animation];
}

- (void)xw_showError:(NSString *)msg inView:(UIView *)view delay:(NSTimeInterval)delay animation:(BOOL)animation{
    UIImage *errorImage = [UIImage imageNamed:@"tip_error"];
    [self xw_showImage:errorImage message:msg inView:view delay:delay animation:animation];
}

- (void)xw_showSuccess:(NSString *)msg{
    [self xw_showSuccess:msg inView:self.view];
}

- (void)xw_showSuccess:(NSString *)msg inView:(UIView *)view{
    [self xw_showSuccess:msg inView:view animation:YES];
}

- (void)xw_showSuccess:(NSString *)msg inView:(UIView *)view animation:(BOOL)animation{
    [self xw_showSuccess:msg inView:view delay:defaultDelay animation:animation];
}

- (void)xw_showSuccess:(NSString *)msg inView:(UIView *)view delay:(NSTimeInterval)delay animation:(BOOL)animation{
    UIImage *successImage = [UIImage imageNamed:@"tip_success"];
    [self xw_showImage:successImage message:msg inView:view delay:delay animation:animation];
}

- (void)xw_showImage:(UIImage *)image message:(NSString *)msg inView:(UIView *)view delay:(NSTimeInterval)delay animation:(BOOL)animation{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (view == nil) view = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animation];
        if (msg.length > 10) {
            hud.detailsLabelText = msg;
        }else{
            hud.labelText = msg;
        }
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:animation afterDelay:delay];
    });
}

- (void)xw_hideHud{
    [self xw_hideHud:YES];
}

- (void)xw_hideHud:(BOOL)animated{
    [self xw_hideHud:animated completeBlock:nil];
}

- (void)xw_hideHud:(BOOL)animated completeBlock:(dispatch_block_t)block{
    [self xw_hideHud:animated afterDelay:defaultDelay completeBlock:block];
}


- (void)xw_hideHud:(BOOL)animated afterDelay:(NSTimeInterval)delay completeBlock:(dispatch_block_t)block{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

@end
