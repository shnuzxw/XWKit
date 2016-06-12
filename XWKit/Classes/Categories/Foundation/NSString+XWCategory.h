//
//  NSString+XWCategory.h
//  BookingClient
//
//  Created by smile.zhang on 16/4/7.
//  Copyright © 2016年 smile.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWCategory)

/**
 *  字符串是否有效 (不去除两边空格）
 *
 *  @return BOOL:YES有效,NO无效.
 */
- (BOOL)xw_isValid;

/**
 *  字符串是否有效
 *
 *  @param isTrim 是否去除两边空格
 *
 *  @return BOOL:YES有效,NO无效.
 */
- (BOOL)xw_isValidWithIsTrimWhiteSpaceAndNewline:(BOOL)isTrim;

/**
 *  是否包含空格
 *
 *  @return Bool
 */
- (BOOL)xw_isContainSpace;

/**
 *  校验字符串是否为空
 *
 *  @param string 将要被校验的字符串
 *
 *  @return BOOL值:YES为空;NO非空.
 */
+ (BOOL)xw_checkStringIsEmpty:(NSString*)string;

/**
 *  去除字符串两边的空格
 *
 *  @param string 将要被处理的字符串
 *
 *  @return 处理后字符串
 */
+ (NSString *)xw_getTrimStringWithString:(NSString*)string;

/**
 *  是否为空
 *
 *  @return BOOL值:YES为空;NO非空.
 */
- (BOOL)xw_isEmpty;

/**
 *  去除两边空格
 *
 *  @return 处理后的字符串
 */
- (NSString *)xw_trimmingWhitespaceAndNewline;

@end
