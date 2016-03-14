//
//  XWObserver.h
//  XWKit
//
//  Created by smile.Zhang on 16/3/15.
//  Copyright (c) 2016年 Zhang Xiaowei site:http://devzhang.com. All rights reserved.
//

// 用于保存observer的object instance
#import <Foundation/Foundation.h>

@interface XWObserver : NSObject {
    __unsafe_unretained id _observer;
}

@property (nonatomic,assign) id observer;

+ (id)createWithObejct:(id)obejct;
- (id)initWithObject:(id)object;

- (void)noticeOberver:(SEL)selector;
- (void)noticeOberver:(SEL)selector withObject:(id)object;
- (void)noticeOberver:(SEL)selector withObject:(id)object1 withObject:(id)object2;

@end
