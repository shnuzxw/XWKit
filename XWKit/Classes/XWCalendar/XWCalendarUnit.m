//
//  XWCalendarUnit.m
//  XWCalendar
//
//  Created by smile.zhang on 16/5/26.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "XWCalendarUnit.h"

@interface XWCalendarUnit () {
    BOOL _isAlign;
}
@property (nonatomic, strong) NSDateComponents *tempDateComponents;
@end

@implementation XWCalendarUnit

- (instancetype)initWithDate:(NSDate *)date isAlign:(BOOL)isAlign {
    self = [super init];
    if (self) {

        _isAlign = isAlign;
        _calendar = [NSCalendar currentCalendar];

        [self updateWithDate:date];
    }
    return self;
}

- (void)addMonths:(NSInteger)willAddedMonths {
    if (willAddedMonths > 12 || willAddedMonths < -12 || willAddedMonths == 0) {
        return;
    }
    NSUInteger year = _tempDateComponents.year;
    NSUInteger month = _tempDateComponents.month;

    NSInteger monthSum = month + willAddedMonths;
    if (monthSum > 12) {
        monthSum -= 12;
        year += 1;
    } else if (monthSum < 0) {
        monthSum += 12;
        year -= 1;
    }

    [_tempDateComponents setYearForWeekOfYear:year];
    [_tempDateComponents setMonth:monthSum];
    [_tempDateComponents setDay:_dateComponents.day];

    [self updateWithDate:[_calendar dateFromComponents:_tempDateComponents]];
}

- (void)updateWithDate:(NSDate *)date {
    _date = date;
    _dateComponents = [_calendar components:[XWCalendarUnit all] fromDate:_date];
    _daysOfMonth = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_date].length;

    _tempDateComponents = [_calendar components:[XWCalendarUnit all] fromDate:_date];
    [_tempDateComponents setDay:1];
    _firstDateOfMonth = _tempDateComponents.date;
    _firstDateComponents = [_calendar components:[XWCalendarUnit all] fromDate:_firstDateOfMonth];

    [_tempDateComponents setDay:_daysOfMonth];
    _lastDateOfMonth = _tempDateComponents.date;
    _lastDateComponents = [_calendar components:[XWCalendarUnit all] fromDate:_lastDateOfMonth];
    _weeksOfMonth = _lastDateComponents.weekOfMonth;

    [self configDateComponentsOfMonth];
}

- (void)configDateComponentsOfMonth {

    NSMutableArray *dateComponentsArray = @[].mutableCopy;
    for (NSInteger day = 1; day <= _daysOfMonth; day++) {
        [_tempDateComponents setDay:day];
        NSDateComponents *dc = [_calendar components:[XWCalendarUnit all] fromDate:_tempDateComponents.date];
        [dateComponentsArray addObject:dc];
    }

    if (_isAlign) {
        NSUInteger firstDateWeekday = _firstDateComponents.weekday;
        NSUInteger lastDateWeekday = _lastDateComponents.weekday;
        if (firstDateWeekday != 0) {
            for (NSInteger i = 1; firstDateWeekday - i >= 1; i++) {
                NSDate *date = [NSDate dateWithTimeInterval:-XWOneDayTimeInterval * i sinceDate:_firstDateOfMonth];
                NSDateComponents *dc = [_calendar components:[XWCalendarUnit all] fromDate:date];
                [dateComponentsArray insertObject:dc atIndex:0];
            }
        }
        if (lastDateWeekday != 7) {
            for (NSInteger i = 1; _lastDateComponents.weekday + i <= 7; i++) {
                NSDate *date = [NSDate dateWithTimeInterval:XWOneDayTimeInterval * i sinceDate:self.lastDateOfMonth];
                NSDateComponents *dc = [_calendar components:[XWCalendarUnit all] fromDate:date];
                [dateComponentsArray addObject:dc];
            }
        }
    }

    _dateComponentsOfMonth = [NSArray arrayWithArray:dateComponentsArray];
}

+ (NSCalendarUnit)all {
    return [self eraYearMonthDayHourMinuteSecondNonaSecond] | [self calendarTimeZone] | [self quarterYearForWeekOfYear] | [self weekdayWeekdayOrdinalWeekOfMonthWeekOfYear];
}

+ (NSCalendarUnit)eraYearMonthDay {
    return NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
}

+ (NSCalendarUnit)eraYearMonthDayHourMinuteSecond {
    return [self eraYearMonthDay] | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
}

+ (NSCalendarUnit)eraYearMonthDayHourMinuteSecondNonaSecond {
    return [self eraYearMonthDayHourMinuteSecond] | NSCalendarUnitNanosecond;
}

+ (NSCalendarUnit)weekdayWeekdayOrdinalWeekOfMonthWeekOfYear {
    return NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekOfYear;
}

+ (NSCalendarUnit)quarterYearForWeekOfYear {
    return  NSCalendarUnitQuarter | NSCalendarUnitYearForWeekOfYear;
}

+ (NSCalendarUnit)calendarTimeZone {
    return NSCalendarUnitCalendar | NSCalendarUnitTimeZone;
}

@end
