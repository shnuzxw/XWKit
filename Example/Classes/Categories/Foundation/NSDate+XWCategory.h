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
// 字符串转换为日期格式
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString*)format;
+ (NSString *)monthAndDayFromDate:(NSDate *)date;
+ (NSString *)hourAndMinuteFromDate:(NSDate *)date;
// 日期格式转换为字符串显示
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString*)format;

+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate; // "星期几"
+ (NSString*)monthStringFromDate:(NSDate*)date; // "几月"
+ (NSDateComponents *)dateComponentsWithDate:(NSDate *)inputDate; // 获得日期组件，可以拿到 年、月、日、星期、时、分、秒等
+ (XWWeekday)weekdayWithDate:(NSDate*)date;

- (NSString *)monthAndDay;
- (NSString *)hourAndMinute;
- (NSString *)string;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)weekdayString;
- (XWWeekday)weekdayEnum;
- (NSString *)month;
- (NSDateComponents *)dateComponments;


@end
