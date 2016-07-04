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

/**
 *  集成默认下拉刷新
 *
 *  @param refreshingBlock 下拉刷新时执行的Block
 */
- (void)xw_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/**
 *  集成默认下拉刷新，执行操作时会调用target的action方法
 *
 *  @param target 对象
 *  @param action 方法
 */
- (void)xw_headerWithTarget:(id)target action:(SEL)action;
/**
 *  隐藏下拉刷新，一般用于界面由于某种原因，导致已集成的默认下拉刷新空间需要移除的场景
 */
- (void)xw_removeHeader;


/**
 *  集成默认加载更多
 *
 *  @param refreshingBlock 加载更多时执行的Block
 */
- (void)xw_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/**
 *  集成默认加载更多，执行操作时会调用target的action方法
 *
 *  @param target 对象
 *  @param action 方法
 */
- (void)xw_footerWithTarget:(id)target action:(SEL)action;
/**
 *  隐藏加载更多，当分页加载完毕时，需要隐藏加载更多操作
 */
- (void)xw_removeFooter;

@end
