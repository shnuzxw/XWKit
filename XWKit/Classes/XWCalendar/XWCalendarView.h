//
//  XWCalendarView.h
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWWeekCollectionViewCell.h"
#import "XWDayCollectionViewCell.h"

typedef NS_ENUM(NSUInteger, XWCalendarViewSubViewType) {
    XWCalendarViewSubViewTypeToolBar     = 0,
    XWCalendarViewSubViewTypeControlBar  = 1,
    XWCalendarViewSubViewTypeWeekdayView = 2,
    XWCalendarViewSubViewTypeDayView     = 3
};

typedef NS_ENUM(NSUInteger, XWCalendarViewIntervalType) {
    XWCalendarViewIntervalTypeHorizontal,
    XWCalendarViewIntervalTypeVertical
};

typedef NS_ENUM(NSUInteger, XWCalendarViewDayCellUIType) {
    XWCalendarViewDayCellUITypeNormal,
    XWCalendarViewDayCellUITypeToday,
    XWCalendarViewDayCellUITypeYesterday,
    XWCalendarViewDayCellUITypeTomorrow,
    XWCalendarViewDayCellUITypeSelected,
    XWCalendarViewDayCellUITypeAllowSelection,
    XWCalendarViewDayCellUITypeNotAllowSelection,
    XWCalendarViewDayCellUITypeWeekend,
    XWCalendarViewDayCellUITypeHoliday,

    /** 目前下面都未用到 */
    XWCalendarViewDayCellUITypeThisMonth,  // 当月
    XWCalendarViewDayCellUITypeBeforeThisMonth, // 上月
    XWCalendarViewDayCellUITypeAfterThisMonth, // 下月

    XWCalendarViewDayCellUITypeBeforeToday, // 今天之前
    XWCalendarViewDayCellUITypeBeforeYesterday, // 昨天之前
    XWCalendarViewDayCellUITypeAfterToday, // 今天之后
    XWCalendarViewDayCellUITypeAfterTomorrow, // 明天之后
};

typedef NS_ENUM(NSUInteger, XWCalendarViewDirection) {
    XWCalendarViewDirectionRight = 1 << 0,
    XWCalendarViewDirectionLeft  = 1 << 1,
    XWCalendarViewDirectionUp    = 1 << 2,
    XWCalendarViewDirectionDown  = 1 << 3
};

typedef NS_ENUM(NSUInteger, XWCalendarViewBarButtonItemType) {
    XWCalendarViewBarButtonItemTypeOK  = 0,
    XWCalendarViewBarButtonItemTypeCancel,
    XWCalendarViewBarButtonItemTypeToday,

    XWCalendarViewBarButtonItemTypeRight = 10,
    XWCalendarViewBarButtonItemTypeLeft,
    XWCalendarViewBarButtonItemTypeUp,
    XWCalendarViewBarButtonItemTypeDown,
};

@interface XWCalendarViewConfig : NSObject

/**
 * XWCalendarUnit 配置信息
 */
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL align; // 是否对齐，设置日历本月以外的日期是否显示

/**
 * XWCalendarView 配置信息
 */
@property (nonatomic, assign) CGFloat toolBarHeight;
@property (nonatomic, assign) CGFloat controlViewHeight;

@property (nonatomic, strong) UIColor *toolBarBackgroundColor; // toolbar背景色
@property (nonatomic, strong) UIColor *toolBarTintColor; // toolbar中title颜色
@property (nonatomic, strong) UIColor *toolBarBarTintColor; // toolbar前景色

@property (nonatomic, strong) UIColor *controlBarBackgroundColor;
@property (nonatomic, strong) UIColor *controlBarTintColor;
@property (nonatomic, strong) UIColor *controlBarBarTintColor;

@property (nonatomic, strong) UIColor *weekdaysViewBackgroundColor;
@property (nonatomic, strong) UIColor *daysViewBackgroundColor;

@property (nonatomic, strong) UICollectionViewFlowLayout *weekdaysFlowLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *daysFlowLayout;

@property (nonatomic, assign) BOOL showToolBar; // 是否显示工具条
@property (nonatomic, assign) BOOL showToday; // 是否显示今天
/**
 * 当选中某个日期时，是否立即执行代理方法
 */
@property (nonatomic, assign) BOOL executionDelegateWhenSelected;

/**
 * 当反选某个日期时，是否立即执行代理方法
 */
@property (nonatomic, assign) BOOL executionDelegateWhenUnSelected;
/**
 * 星期标志
 */
@property (nonatomic, copy) NSArray<NSString *> *weekdaySymbols;

/**
 * 是否允许不选择日期，若允许才可能在反选时立即执行反选代理方法
 */
@property (nonatomic, assign) BOOL allowNullDate;

@property (nonatomic, assign) BOOL allowsMultipleSelection; // 是否允许多选，默认NO

@end

@class XWCalendarView;

@protocol XWCalendarViewDelegate <NSObject>

@required

/**
 * 重新计算CalendarView高度时调用
 */
- (void)xwCalendarView:(XWCalendarView *)calendarView normalHeight:(CGFloat)normalHeight;

/**
 *  选中日历中某日，或者点击“确定”按钮时调用
 *
 *  @param calendarView   日历视图
 *  @param dateComponents 已选中的NSDateComponents
 */
- (void)xwCalendarView:(XWCalendarView *)calendarView didSelectedDateComponents:(NSArray <NSDateComponents *> *)dateComponents;

/**
 *  取消选中某日，或者点击“取消”按钮时调用
 *
 *  @param calendarView   日历视图
 *  @param dateComponents 取消选中的NSDateComponents；点击“取消”按钮时，为nil
 */
- (void)xwCalendarView:(XWCalendarView *)calendarView didDeselectedDateComponents:(NSArray <NSDateComponents *> *)dateComponents;

@end

@protocol XWCalendarViewDataSource <NSObject>

@optional

/**
 * 配置WeekCell样式
 */
- (void)xwCalendarView:(XWCalendarView *)calendarView
            weekdayCell:(XWWeekCollectionViewCell *)cell
             forWeekday:(NSInteger)weekday;

/**
 * 根据XWCalendarViewDayCellUIType设置UI
 */
- (void)xwCalendarView:(XWCalendarView *)calendarView
                dayCell:(XWDayCollectionViewCell *)cell
                   type:(XWCalendarViewDayCellUIType)type;

/**
 * UIBarButtonItem 按钮图片，优先“xwCalendarView:titleForBarButtonItemType:”调用
 */
- (UIImage *)xwCalendarView:(XWCalendarView *)calendarView imageForBarButtonItemType:(XWCalendarViewBarButtonItemType)type;

/**
 * UIBarButtonItem 按钮标题，“xwCalendarView:imageForBarButtonItemType:”未实现时调用
 */
- (NSString *)xwCalendarView:(XWCalendarView *)calendarView titleForBarButtonItemType:(XWCalendarViewBarButtonItemType)type;

/**
 * 能否选择
 */
- (BOOL)xwCalendarView:(XWCalendarView *)calendarView canSelectForDateComponents:(NSDateComponents *)dateComponents;
/**
 * 是否是假期
 */
- (BOOL)xwCalendarView:(XWCalendarView *)calendarView isHolidayForDateComponents:(NSDateComponents *)dateComponents;

@end


@interface XWCalendarView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       config:(XWCalendarViewConfig *)config
                  dataSourece:(id<XWCalendarViewDataSource>)dataSource
                     delegate:(id<XWCalendarViewDelegate>)delegate;

/**
 * 重新计算frame，手动调用
 */
- (void)recalculateFrame;

/**
 * 总体高度
 */
- (CGFloat)height;

@end



