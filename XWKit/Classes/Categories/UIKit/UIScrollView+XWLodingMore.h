//
//  UIScrollView+XWLodingMore.h
//  BookingClient
//
//  Created by smile.zhang on 16/4/5.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView (XWLodingMore)

- (void)setLodingMore:(BOOL)isLodingMore;

- (void)xw_lodingMore;

@end
