//
//  NSDictionary+XWCategory.m
//  BookingClient
//
//  Created by smile.zhang on 16/5/18.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "NSDictionary+XWCategory.h"

@implementation NSDictionary (XWCategory)

- (BOOL)xw_isValid {
    return [[self class] xw_isValidWithDictionary:self];
}

+ (BOOL)xw_isValidWithDictionary:(NSDictionary *)dictionary {
    if (![dictionary isKindOfClass:[NSDictionary class]] || !dictionary || !([dictionary allKeys].count)) {
        return NO;
    } else {
        return YES;
    }
}

@end
