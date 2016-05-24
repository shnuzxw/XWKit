//
//  NSArray+XWCategory.m
//  BookingClient
//
//  Created by smile.zhang on 16/5/18.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "NSArray+XWCategory.h"

@implementation NSArray (XWCategory)

- (BOOL)xw_isValid {
    return [[self class] xw_isValidWithArray:self];
}

+ (BOOL)xw_isValidWithArray:(NSArray *)array {
    if (![array isKindOfClass:[NSArray class]] || !array || !array.count) {
        return NO;
    } else {
        return YES;
    }
}

@end
