//
//  NSDate+XWCategory.m
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "NSDate+XWCategory.h"
#import "UIDevice+XWCategory.h"

@implementation NSDate (XWCategory)
// 字符串转换为日期格式
+ (NSDate *)dateFromString:(NSString *)dateString{
    return [self dateFromString:dateString format:@"yyyy-MM-dd HH:mm:ss zzz"];
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

// 日期格式转换为字符串显示
+ (NSString *)stringFromDate:(NSDate *)date{
    return [self stringFromDate:date format:@"yyyy-MM-dd HH:mm:ss zzz"];
}

+ (NSString *)monthAndDayFromDate:(NSDate *)date{
    return [self stringFromDate:date format:@"MM月dd日"];
}

+ (NSString *)hourAndMinuteFromDate:(NSDate *)date{
    return [self stringFromDate:date format:@"HH:mm"];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)weekdayStringFromDate:(NSDate*)inputDate{
    if (!inputDate) return nil;
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDateComponents * comps = [self dateComponentsWithDate:inputDate];
    NSInteger weekday = [comps weekday];
    if (weekday < 1 || weekday > 7) return nil;
    return [arrWeek objectAtIndex:weekday - 1];
}

+ (NSString*)monthStringFromDate:(NSDate*)date{
    if (!date) return nil;
    NSArray * monthArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    NSDateComponents * comps = [self dateComponentsWithDate:date];
    NSInteger month = [comps month];
    if (month < 1 || month > 12) return nil;
    return [monthArray objectAtIndex:month - 1];
}

+ (NSDateComponents*)dateComponentsWithDate:(NSDate *)inputDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags;
#ifdef __IPHONE_8_0
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
#else
    unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
#endif
    comps = [calendar components:unitFlags fromDate:inputDate];
    return comps;
}

// NSDate -->> Weekday
+ (XWWeekday)weekdayWithDate:(NSDate*)date{
    NSDateComponents *comps = [self dateComponentsWithDate:date];
    XWWeekday weekday = comps.weekday - 1;
    return weekday;
}

- (NSString *)monthAndDay{
    return [[self class] monthAndDayFromDate:self];
}

- (NSString *)hourAndMinute{
    return [[self class] hourAndMinuteFromDate:self];
}

- (NSString *)string{
    return [[self class] stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format{
    return [[self class] stringFromDate:self format:format];
}

- (NSString *)weekdayString{
    return [[self class] weekdayStringFromDate:self];
}

- (XWWeekday)weekdayEnum{
    return [[self class] weekdayWithDate:self];
}

- (NSString *)month{
    return [[self class] monthStringFromDate:self];
}

- (NSDateComponents *)dateComponments{
    return [[self class] dateComponentsWithDate:self];
}

@end
