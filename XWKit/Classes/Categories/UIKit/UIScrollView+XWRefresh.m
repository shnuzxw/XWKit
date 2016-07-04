//
//  UIScrollView+XWRefresh.m
//  BookingClient
//
//  Created by smile.zhang on 16/4/5.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "UIScrollView+XWRefresh.h"

@implementation UIScrollView (XWRefresh)

- (void)xw_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
}

- (void)xw_headerWithTarget:(id)target action:(SEL)action {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
}

- (void)xw_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:refreshingBlock];
}

- (void)xw_footerWithTarget:(id)target action:(SEL)action {
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}

- (void)xw_removeHeader {
    self.mj_header = nil;
}

- (void)xw_removeFooter {
    self.mj_footer = nil;
}

@end
