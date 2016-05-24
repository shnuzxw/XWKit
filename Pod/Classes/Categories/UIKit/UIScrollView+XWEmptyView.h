//
//  UIScrollView+XWEmptyView.h
//  BookingClient
//
//  Created by smile.zhang on 16/4/27.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyViewFactory.h"

@interface UIScrollView (XWEmptyView)

- (void)showEmptyViewWithImage:(UIImage *)image;
- (void)showEmptyViewWithTitle:(NSString *)title;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title subTitle:(NSString *)subTitle;

@end
