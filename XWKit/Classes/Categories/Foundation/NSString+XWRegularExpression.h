//
//  NSString+XWRegularExpression.h
//  XWKit
//
//  Created by smile.zhang on 16/5/24.
//  Copyright © 2016年 Zhang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWRegularExpression)

/**
 *  是否合法
 *
 *  @param regex 正则表达式
 *
 *  @return YES:合法;NO:不合法.
 */
- (BOOL)isValidWithRegex:(NSString *)regexString;

/**
 *  URL是否合法
 *
 *  @return YES:合法;NO:不合法.
 */
- (BOOL)isValidUrl;

/**
 *  EMail是否合法
 *
 *  @return YES:合法;NO:不合法.
 */
- (BOOL)isValidEMail;

/**
 *  移动电话是否合法
 *
 *  @return YES:合法;NO:不合法.
 */
- (BOOL)isValidMobilePhone;

/**
 *  固定电话是否合法
 *
 *  @return YES:合法;NO:不合法.
 */
- (BOOL)isValidTelephone;

@end
