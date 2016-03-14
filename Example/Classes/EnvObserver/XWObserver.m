//
//  XWObserver.m
//  XWKit
//
//  Created by Yan FENG on 3/5/12.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

#import "XWObserver.h"

@implementation XWObserver

@synthesize observer = _observer;

+ (id)createWithObejct:(id)obejct
{
    return [[XWObserver alloc] initWithObject:obejct];
}

- (id)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        _observer = object;
    }
    return self;
}

- (void)noticeOberver:(SEL)selector
{
    if ([_observer respondsToSelector:selector]){
        IMP imp = [_observer methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(_observer, selector);
    }
}

- (void)noticeOberver:(SEL)selector withObject:(id)object
{
    if ([_observer respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_observer performSelector:selector withObject:object];
#pragma clang diagnostic pop
    }
}

- (void)noticeOberver:(SEL)selector withObject:(id)object1 withObject:(id)object2
{
    if ([_observer respondsToSelector:selector]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_observer performSelector:selector withObject:object1 withObject:object2];
#pragma clang diagnostic pop
    }
}

@end
