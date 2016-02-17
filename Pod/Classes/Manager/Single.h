//
//  Single.h
//  ShareCar
//
//  Created by smile.zhang on 15/9/19.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#ifndef Single_h
#define Single_h

#define SingletonInterface(Class) \
+ (Class *)sharedInstance;


#define SingletonImplementation(Class) \
static Class *__ ## sharedSingleton; \
\
\
+ (void)initialize \
{ \
static BOOL initialized = NO; \
if(!initialized) \
{ \
initialized = YES; \
__ ## sharedSingleton = [[Class alloc] init]; \
} \
} \
\
\
+ (Class *)sharedInstance \
{ \
return __ ## sharedSingleton; \
} \
\

#endif /* Single_h */
