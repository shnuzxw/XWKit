//
//  XWCalendarUnit.h
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XWOneDayTimeInterval 60 * 60 * 24  // 一天的NSTimeInterval

@interface XWCalendarUnit : NSObject

@property (nonatomic, strong, readonly) NSCalendar       *calendar;
@property (nonatomic, strong, readonly) NSDate           *date;
@property (nonatomic, strong, readonly) NSDateComponents *dateComponents;
@property (nonatomic, strong, readonly) NSDate           *firstDateOfMonth;
@property (nonatomic, strong, readonly) NSDateComponents *firstDateComponents;
@property (nonatomic, strong, readonly) NSDate           *lastDateOfMonth;
@property (nonatomic, strong, readonly) NSDateComponents *lastDateComponents;
@property (nonatomic, assign, readonly) NSUInteger       daysOfMonth;
@property (nonatomic, assign, readonly) NSUInteger       weeksOfMonth;

@property (nonatomic, strong, readonly) NSArray <NSDateComponents *>*dateComponentsOfMonth;

- (instancetype)initWithDate:(NSDate *)date isAlign:(BOOL)isAlign;

/**
 *  更新信息
 *
 *  @param willAddedMonths 将要更新的月数 {-12 —— -1} {1 —— 12}
 */
- (void)addMonths:(NSInteger)willAddedMonths;

/**
 *  更新信息
 *
 *  @param date 根据日期
 */
- (void)updateWithDate:(NSDate *)date;

/**
 * 所有
 */
+ (NSCalendarUnit)all;

/**
 * 时代、年、月、日
 */
+ (NSCalendarUnit)eraYearMonthDay;

/**
 * 时代、年、月、日、时、分、秒
 */
+ (NSCalendarUnit)eraYearMonthDayHourMinuteSecond;

/**
 * 时代、年、月、日、时、分、秒、纳秒
 */
+ (NSCalendarUnit)eraYearMonthDayHourMinuteSecondNonaSecond;

/**
 * 星期、星期序列、本月第几周、本年第几周
 * 如20160526，5、4、4、22
 */
+ (NSCalendarUnit)weekdayWeekdayOrdinalWeekOfMonthWeekOfYear;

/**
 * 季节、年份
 */
+ (NSCalendarUnit)quarterYearForWeekOfYear;

/**
 * 日历、时区
 */
+ (NSCalendarUnit)calendarTimeZone;


@end
