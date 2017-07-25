//
//  NSString+Secret.h
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWSecret)

/**
 *  加密算法
 *
 *  @return 字符串
 */
- (NSString *)encodeMD5;

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
 *  @return NSData
 */
- (NSData *)decodeBASE64;

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
- (NSString *)appendParameters:(NSDictionary *)parameters;

/**
 *  URL编码
 *
 *  @param url URLString
 *
 *  @return 字符串
 */
- (NSString *)URLEncode;

/**
 *  URL解码
 *
 *  @param url URLString
 *
 *  @return 字符串
 */
- (NSString *)URLDecode;

/**
 *  加密算法
 *
 *  @return 加密结果
 */
- (NSString *)SHA1;


@end
