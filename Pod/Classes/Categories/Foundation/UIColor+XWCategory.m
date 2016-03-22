//
//  UIColor+XWCategory.m
//  XWCarCost
//
//  Created by smile.zhang on 15/7/27.
//  Copyright (c) 2015年 Zhang Xiaowei. All rights reserved.
//

#import "UIColor+XWCategory.h"

@implementation UIColor (XWCategory)

// 根据16进制和alpha计算UIColor
+ (UIColor *)HEX2Color:(NSInteger)hexCode alpha:(CGFloat)alpha{
    float red   = ((hexCode >> 16) & 0x000000FF)/255.0f;
    float green = ((hexCode >> 8) & 0x000000FF)/255.0f;
    float blue  = ((hexCode) & 0x000000FF)/255.0f;
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSInteger)hexCode{
    return [self HEX2Color:hexCode alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSInteger)hexCode alpha:(CGFloat)alpha{
    return [self HEX2Color:hexCode alpha:alpha];
}

+ (UIColor *)randomColor {
    return [self randomColorWithAlpha:(arc4random() % 255)/255.0];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(arc4random() % 255)/255.0
                           green:(arc4random() % 255)/255.0
                            blue:(arc4random() % 255)/255.0
                           alpha:alpha];
}

@end
