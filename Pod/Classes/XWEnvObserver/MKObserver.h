//
//  MKObserver.h
//  LNUniversal
//
//  Created by liu nian on 15/5/25.
//  Copyright (c) 2015年 Liu Nian site:http://iliunian.com. All rights reserved.
//

// 用于保存observer的object instance
#import <Foundation/Foundation.h>

@interface MKObserver : NSObject {
    __unsafe_unretained id _observer;
}

@property (nonatomic,assign) id observer;

+ (id)createWithObejct:(id)obejct;
- (id)initWithObject:(id)object;

- (void)noticeOberver:(SEL)selector;
- (void)noticeOberver:(SEL)selector withObject:(id)object;
- (void)noticeOberver:(SEL)selector withObject:(id)object1 withObject:(id)object2;

@end
