//
//  UIScrollView+XWRefresh.h
//  BookingClient
//
//  Created by smile.zhang on 16/4/5.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView (XWRefresh)

- (void)setRefresh:(BOOL)isRefresh;

- (void)xw_refresh;

@end
