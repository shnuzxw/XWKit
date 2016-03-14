//
//  MKEnvObserverCenter.h
//  LNUniversal
//
//  Created by liu nian on 15/5/25.
//  Copyright (c) 2015年 Liu Nian site:http://iliunian.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKObserver.h"

@interface MKEnvObserverCenter : NSObject {
    NSMutableArray * _observersAry;
}

@property (nonatomic,readonly) NSArray * observers;

- (void)addEnvObserver:(id)observer;
- (void)removeEnvObserver:(id)observer;

- (void)noticeObervers:(SEL)selector;
- (void)noticeObervers:(SEL)selector withObject:(id)object;
- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2;
@end
