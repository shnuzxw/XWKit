//
//  NSString+Secret.h
//  XWCarCost
//
//  Created by smile.zhang on 15/12/22.
//  Copyright © 2015年 Zhang Xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Secret)
// MD5加密算法
+ (NSString *)encodeMD5:(NSString*)entity;

// BASE64加密算法
+ (NSString*)encodeBASE64:(NSData *)data;

// BASE64解密算法
+ (NSData*)decodeBASE64:(NSString *)string;

+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson;
+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters;
+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters;
+ (NSString*)urlEncode:(NSString*)str;
+ (NSString *)URLDecodedString:(NSString*)str;
+ (NSString *)md5StringFromString:(NSString *)string;

@end
