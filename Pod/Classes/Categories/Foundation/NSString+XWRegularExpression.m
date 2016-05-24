//
//  NSString+XWRegularExpression.m
//  XWKit
//
//  Created by smile.zhang on 16/5/24.
//  Copyright © 2016年 Zhang Xiaowei. All rights reserved.
//

#import "NSString+XWRegularExpression.h"

@implementation NSString (XWRegularExpression)

- (BOOL)isValidWithRegex:(NSString *)regex {
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regexString
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        NSTextCheckingResult *match = [regex firstMatchInString:url
                                                        options:0
                                                          range:NSMakeRange(0, [url length])];
        if (match) {
            // 截获特定的字符串
            NSString *result = [url substringWithRange:match.range];
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

- (BOOL)isValidUrl {
    NSString *regex = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    return [self isValidWithRegex:regex];
}

- (BOOL)isValidEMail {
    NSString *regex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$";
    return [self isValidWithRegex:regex];
}

- (BOOL)isValidMobilePhone {
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    return [self isValidWithRegex:regex];
}

- (BOOL)isValidTelephone {
    NSString *regex = @"^([\\d{3,4}-)\\d{7,8}$](file:///d%7B3,4%7D-)//d%7B7,8%7D$)";
    return [self isValidWithRegex:regex];
}

@end
