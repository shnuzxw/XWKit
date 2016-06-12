//
//  UIColor+XWCategory.h
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XWCategory)

// 根据16进制和alpha计算UIColor
+ (UIColor *)HEX2Color:(NSInteger)hexCode alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(NSInteger)hexCode;
+ (UIColor *)colorWithHex:(NSInteger)hexCode alpha:(CGFloat)alpha;
+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
