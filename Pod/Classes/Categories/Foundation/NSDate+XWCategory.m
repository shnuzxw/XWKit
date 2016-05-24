//
//  NSDate+XWCategory.m
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "NSDate+XWCategory.h"
#import "UIDevice+XWCategory.h"

static NSString * const kDateFormatForNet       = @"yyyyMMdd";

@implementation NSDate (XWCategory)
// 日期比较
+ (NSComparisonResult)compareFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate {
    NSString *fromDateString = [[self class] stringFromDate:fromDate format:kDateFormatForNet];
    NSString *toDateString = [[self class] stringFromDate:toDate format:kDateFormatForNet];
    NSComparisonResult result = [fromDateString compare:toDateString];
    return result;
}

// 字符串转换为日期格式
+ (NSDate *)dateFromString:(NSString *)dateString {
    return [self dateFromString:dateString format:@"yyyy-MM-dd HH:mm:ss zzz"];
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)monthAndDayFromDate:(NSDate *)date {
    return [self stringFromDate:date format:@"MM月dd日"];
}

+ (NSString *)hourAndMinuteFromDate:(NSDate *)date {
    return [self stringFromDate:date format:@"HH:mm"];
}

// 日期格式转换为字符串显示
+ (NSString *)stringFromDate:(NSDate *)date {
    return [self stringFromDate:date format:@"yyyy-MM-dd HH:mm:ss zzz"];
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)weekday1FromDate:(NSDate *)date {
    return [self weekdayStringFromDate:date weekdays:@[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"]];
}

+ (NSString *)weekday2FromDate:(NSDate *)date {
    return [self weekdayStringFromDate:date weekdays:@[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"]];
}

+ (NSString *)weekdayStringFromDate:(NSDate *)date weekdays:(NSArray *)weekdays {
    
    if (!date || !weekdays || weekdays.count != 7) return nil;
    NSDateComponents * comps = [self dateComponentsWithDate:date];
    NSInteger weekday = [comps weekday];
    if (weekday < 1 || weekday > 7) return nil;
    return [weekdays objectAtIndex:weekday - 1];
}

+ (NSString *)monthStringFromDate:(NSDate *)date {
    if (!date) return nil;
    NSArray * monthArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    NSDateComponents * comps = [self dateComponentsWithDate:date];
    NSInteger month = [comps month];
    if (month < 1 || month > 12) return nil;
    return [monthArray objectAtIndex:month - 1];
}

+ (NSDateComponents *)dateComponentsWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags;
#ifdef __IPHONE_8_0
        unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
#else
    unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
#endif
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}

// NSDate -->> Weekday
+ (XWWeekday)weekdayWithDate:(NSDate *)date {
    NSDateComponents *comps = [self dateComponentsWithDate:date];
    XWWeekday weekday = comps.weekday - 1;
    return weekday;
}

+ (NSInteger)integerDateWithDate:(NSDate *)date {
    return [[self stringFromDate:date format:@"yyyyMMdd"] integerValue];
}

+ (long long)bookingTimeIntervalSince1970 {
    return (long long)([[NSDate date] timeIntervalSince1970] * 1000);
}

- (NSString *)monthAndDay {
    return [[self class] monthAndDayFromDate:self];
}

- (NSString *)hourAndMinute {
    return [[self class] hourAndMinuteFromDate:self];
}

- (NSString *)string {
    return [[self class] stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format {
    return [[self class] stringFromDate:self format:format];
}

- (NSString *)weekday1 {
    return [[self class] weekday1FromDate:self];
}

- (NSString *)weekday2 {
    return [[self class] weekday2FromDate:self];
}

- (XWWeekday)weekdayEnum {
    return [[self class] weekdayWithDate:self];
}

- (NSString *)month {
    return [[self class] monthStringFromDate:self];
}

- (NSDateComponents *)dateComponments {
    return [[self class] dateComponentsWithDate:self];
}

// NSDate  -->>    "今天"/"明天"/"后天"
- (NSString *)todayString {
    
    NSComparisonResult todayComparison = [[self class] compareFromDate:[NSDate date] toDate:self];
    if (todayComparison == NSOrderedSame) {
        return @"今天";
    }
    
    NSDate *tomorrow = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    if ([NSDate compareFromDate:tomorrow toDate:self] == NSOrderedSame) {
        return @"明天";
    }
    
    NSDate *afterTomorrow = [NSDate dateWithTimeIntervalSinceNow:60*60*24*2];
    if ([NSDate compareFromDate:afterTomorrow toDate:self] == NSOrderedSame) {
        return @"后天";
    }
    return @"";
}

/** 20160501 */
- (NSInteger)integerDate {
    return [[self class] integerDateWithDate:self];
}

- (NSInteger)bookingTimeIntervalSince1970 {
    return (NSInteger)([self timeIntervalSince1970] * 1000);
}

@end
