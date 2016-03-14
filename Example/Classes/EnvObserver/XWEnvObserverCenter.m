//
//  XWEnvObserverCenter.m
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

#import "XWEnvObserverCenter.h"

@implementation XWEnvObserverCenter
@synthesize observers = _observersAry;

- (id)init
{
    self = [super init];
    if (self) {
        _observersAry = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
- (void)addEnvObserver:(id)observer
{
    if (observer == nil) {
        return;
    }
    for (XWObserver * ob in _observersAry) {
        if (ob.observer == observer) {
            return;
        }
    }
    XWObserver * ob = [XWObserver createWithObejct:observer];
    [_observersAry addObject:ob];
}

- (void)removeEnvObserver:(id)observer
{
    for (NSInteger i = 0; i < [_observersAry count]; i++) {
        XWObserver * ob = [_observersAry objectAtIndex:i];
        if (ob.observer == observer) {
            [_observersAry removeObjectAtIndex:i];
            return;
        }
    }
}

- (void)noticeObervers:(SEL)selector
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XWObserver * observer = obj;
        [observer noticeOberver:selector];
    }];
}

- (void)noticeObervers:(SEL)selector withObject:(id)object
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XWObserver * observer = obj;
        [observer noticeOberver:selector withObject:object];
    }];
}

- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XWObserver * observer = obj;
        [observer noticeOberver:selector withObject:object1 withObject:object2];
    }];
}

@end
