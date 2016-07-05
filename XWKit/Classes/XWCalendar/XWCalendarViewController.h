//
//  XWCalendarViewController.h
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWCalendarView.h"


typedef NS_ENUM(NSUInteger, XWCalendarViewControllerVerticalType) {
    XWCalendarViewControllerVerTicalTypeTop,
    XWCalendarViewControllerVerTicalTypeCenter,
    XWCalendarViewControllerVerTicalTypeBottom,
};

@class XWCalendarViewController;
@protocol XWCalendarViewControllerDelegate <NSObject>

/**
 *  选中日历中某日，或者点击“确定”按钮时调用
 *
 *  @param calendarView   日历视图
 *  @param dateComponents 已选中的NSDateComponents
 */
- (void)xwCalendarViewController:(XWCalendarViewController *)calendarViewController
       didSelectedDateComponents:(NSArray <NSDateComponents *> *)dateComponents;

/**
 *  取消选中某日，或者点击“取消”按钮时调用
 *
 *  @param calendarView   日历视图
 *  @param dateComponents 取消选中的NSDateComponents；点击“取消”按钮时，为nil
 */
- (void)xwCalendarViewController:(XWCalendarViewController *)calendarViewController
     didDeselectedDateComponents:(NSArray <NSDateComponents *> *)dateComponents;

@end

@interface XWCalendarViewController : UIViewController

@property (nonatomic, strong, readonly) XWCalendarView *calendarView;
@property (nonatomic, weak) id <XWCalendarViewControllerDelegate> delegate;

- (instancetype)initWithConfig:(XWCalendarViewConfig *)config
                          type:(XWCalendarViewControllerVerticalType)type
                      delegate:(id<XWCalendarViewDataSource>)delegate;

@end
