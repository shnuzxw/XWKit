//
//  MKEnvObserverCenter.m
//  LNUniversal
//
//  Created by liu nian on 15/5/25.
//  Copyright (c) 2015年 Liu Nian site:http://iliunian.com. All rights reserved.
//

#import "MKEnvObserverCenter.h"

@implementation MKEnvObserverCenter
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
    for (MKObserver * ob in _observersAry) {
        if (ob.observer == observer) {
            return;
        }
    }
    MKObserver * ob = [MKObserver createWithObejct:observer];
    [_observersAry addObject:ob];
}

- (void)removeEnvObserver:(id)observer
{
    for (NSInteger i = 0; i < [_observersAry count]; i++) {
        MKObserver * ob = [_observersAry objectAtIndex:i];
        if (ob.observer == observer) {
            [_observersAry removeObjectAtIndex:i];
            return;
        }
    }
}

- (void)noticeObervers:(SEL)selector
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MKObserver * observer = obj;
        [observer noticeOberver:selector];
    }];
}

- (void)noticeObervers:(SEL)selector withObject:(id)object
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MKObserver * observer = obj;
        [observer noticeOberver:selector withObject:object];
    }];
}

- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2
{
    [_observersAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MKObserver * observer = obj;
        [observer noticeOberver:selector withObject:object1 withObject:object2];
    }];
}

@end
