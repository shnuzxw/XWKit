//
//  XWEnvObserverCenter.h
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWObserver.h"

@interface XWEnvObserverCenter : NSObject {
    NSMutableArray * _observersAry;
}

@property (nonatomic,readonly) NSArray * observers;

- (void)addEnvObserver:(id)observer;
- (void)removeEnvObserver:(id)observer;

- (void)noticeObervers:(SEL)selector;
- (void)noticeObervers:(SEL)selector withObject:(id)object;
- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2;
@end
