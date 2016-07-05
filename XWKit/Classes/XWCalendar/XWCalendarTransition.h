//
//  XWCalendarTransition.h
//  Pods
//
//  Created by smile.zhang on 16/6/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XWCalendarTransitionType) {
    XWCalendarTransitionTypePresent,
    XWCalendarTransitionTypeZoom,
};

@interface XWCalendarTransition : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

- (instancetype)initWithType:(XWCalendarTransitionType)type;

@end