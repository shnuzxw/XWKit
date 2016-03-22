//
//  NSDate+XWCategory.h
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XWWeekday){
    XWWeekdaySunday,      // 周日
    XWWeekdayMonday,      // 周一
    XWWeekdayTuesday,     // 周二
    XWWeekdayWednesday,   // 周三
    XWWeekdayThursday,    // 周四
    XWWeekdayFriday,      // 周五
    XWWeekdaySaturday,    // 周六
};

@interface NSDate (XWCategory)

/**
 *  字符串->日期格式
 *
 *  @param dateString 格式"yyyy-MM-dd HH:mm:ss zzz"的日期
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

/**
 *  字符串->日期格式
 *
 *  @param dateString 字符串格式日期
 *  @param format     字符串形式日期格式。如"2016-03-31"
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString*)format;

/**
 *  日期->"MM月dd日"
 *
 *  @param date 字符串格式日期
 *
 *  @return 字符串
 */
+ (NSString *)monthAndDayFromDate:(NSDate *)date;

/**
 *  日期->"05:19"
 *
 *  @param date 字符串格式日期
 *
 *  @return 字符串
 */
+ (NSString *)hourAndMinuteFromDate:(NSDate *)date;

/**
 *  日期->"2016-03-15 09:45:07 Asia/Shanghai"
 *
 *  @param date NSDate
 *
 *  @return 字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/**
 *  日期->指定格式的字符串
 *
 *  @param date   NSDate
 *  @param format 格式
 *
 *  @return 字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

/**
 *  日期->星期几
 *
 *  @param inputDate 日期
 *
 *  @return 星期几
 */
+ (NSString *)weekdayStringFromDate:(NSDate*)date; // "星期几"

/**
 *  日期->几月
 *
 *  @param date 日期
 *
 *  @return 几月
 */
+ (NSString *)monthStringFromDate:(NSDate *)date; // "几月"

/**
 *  日期->日历。 // 获得日期组件，可以拿到 年、月、日、星期、时、分、秒等
 *
 *  @param date 日期
 *
 *  @return 日历
 */
+ (NSDateComponents *)dateComponentsWithDate:(NSDate *)date;

/**
 *  日期->XWWeekday
 *
 *  @param date 日期
 *
 *  @return XWWeekday
 */
+ (XWWeekday)weekdayWithDate:(NSDate *)date;

/**
 *  几月几日
 */
- (NSString *)monthAndDay;

/**
 * 09:18
 */
- (NSString *)hourAndMinute;

/**
 * @"yyyy-MM-dd HH:mm:ss zzz"]
 */
- (NSString *)string;

/**
 *  得到指定格式的字符串
 *
 *  @param format 格式
 *
 *  @return 字符串
 */
- (NSString *)stringWithFormat:(NSString *)format;

/**
 * 星期几
 */
- (NSString *)weekdayString;

/**
 *  返回XWWeekday
 */
- (XWWeekday)weekdayEnum;

/**
 * 几月
 */
- (NSString *)month;

/**
 * 获取日历
 */
- (NSDateComponents *)dateComponments;


@end
