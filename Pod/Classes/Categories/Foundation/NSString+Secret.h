//
//  NSString+Secret.h
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Secret)

/**
 *  MD5加密算法
 *
 *  @param entity 字符串
 *
 *  @return 字符串
 */
+ (NSString *)encodeMD5:(NSString *)entity;

/**
 *  BASE64加密算法
 *
 *  @param data NSData
 *
 *  @return String
 */
+ (NSString*)encodeBASE64:(NSData *)data;

/**
 *  BASE64解密算法
 *
 *  @param string string
 *
 *  @return NSData
 */
+ (NSData*)decodeBASE64:(NSString *)string;

/**
 * 检验json的有效性
 */
+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson;

/**
 *  字符串格式的参数拼接
 *
 *  @param parameters 参数集合[字典]
 *
 *  @return 字符串
 */
+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters;

/**
 *  为URLString拼接参数
 *
 *  @param urlString  URLString
 *  @param parameters 参数集合[字典]
 *
 *  @return 字符串
 */
+ (NSString *)urlString:(NSString *)urlString appendParameters:(NSDictionary *)parameters;

/**
 *  URL编码
 *
 *  @param url URLString
 *
 *  @return 字符串
 */
+ (NSString *)URLEncode:(NSString *)url;

/**
 *  URL解码
 *
 *  @param url URLString
 *
 *  @return 字符串
 */
+ (NSString *)URLDecodedString:(NSString *)url;


@end
