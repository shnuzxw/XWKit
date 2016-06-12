//
//  NSString+XWCategory.m
//  BookingClient
//
//  Created by smile.zhang on 16/4/7.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import "NSString+XWCategory.h"

@implementation NSString (XWCategory)

- (BOOL)xw_isValid {
    return [self xw_isValidWithIsTrimWhiteSpaceAndNewline:NO];
}

- (BOOL)xw_isValidWithIsTrimWhiteSpaceAndNewline:(BOOL)isTrim {
    if (![self isKindOfClass:[NSString class]] || !self || !self.length) {
        return NO;
    } else {
        if (isTrim) {
            return [[self xw_trimmingWhitespaceAndNewline] xw_isValid];
        } else {
            return YES;
        }
    }
}

- (BOOL)xw_isContainSpace {
    if (self && [self stringByReplacingOccurrencesOfString:@" " withString:@""].length) {
        return YES;
    }
    return NO;
}

+ (BOOL)xw_checkStringIsEmpty:(NSString*)string {
    if (string == nil) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    return [[self xw_getTrimStringWithString:string] isEqualToString:@""];
}

+ (NSString *)xw_getTrimStringWithString:(NSString*)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)xw_isEmpty {
    return [[self class] xw_checkStringIsEmpty:self];
}

- (NSString *)xw_trimmingWhitespaceAndNewline {
    return [[self class] xw_getTrimStringWithString:self];
}


@end
