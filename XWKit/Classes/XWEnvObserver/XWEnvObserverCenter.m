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

- (id)init {
    self = [super init];
    if (self) {
        _observersAry = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (void)addEnvObserver:(id)observer {
    if (observer == nil) {
        return;
    }

    if (![_observersAry containsObject:observer]) {
        [_observersAry addObject:observer];
    }
}

- (void)removeEnvObserver:(id)observer {
    if ([_observersAry containsObject:observer]) {
        [_observersAry removeObject:observer];
    }
}

- (void)noticeObervers:(SEL)selector {
    for (id obj in _observersAry) {
        if ([obj respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:selector];
#pragma clang diagnostic pop
        }
    }
}

- (void)noticeObervers:(SEL)selector withObject:(id)object {
    for (id obj in _observersAry) {
        if ([obj respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:selector withObject:object];
#pragma clang diagnostic pop
        }
    }
}

- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2 {
    for (id obj in _observersAry) {
        if ([obj respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:selector withObject:object1 withObject:object2];
#pragma clang diagnostic pop
        }
    }
}

@end
